import 'package:memory_game/widgets/card.dart';
import 'package:memory_game/widgets/table.dart';

class GameEngine {
  int _moves = 0;
  bool _paused = false;
  late int unfindedCouples;
  final _cardStack =
      GameCardStack(); // Pilha contendo as duas cartas escolhidas
  final List<GameCard> _cards;
  final GameTable _table;

  GameEngine(this._table, this._cards) {
    if (_cards.length % 2 == 0) {
      unfindedCouples = _cards.length ~/ 2;
    } else {
      throw Exception('O jogo deve conter pares');
    }
  }

  bool get isEquals =>
      _cardStack.get(0).widget.icon.toString() ==
      _cardStack.get(1).widget.icon.toString();
  bool get isPaused => _paused;
  bool get isEnableToMove => !(isPaused || _cardStack.isFull);
  int get movesCounter => _moves;

  Future showCards() {
    return Future.sync(() {
      // ignore: avoid_function_literals_in_foreach_calls
      _cards.forEach((e) => _flip(e.state));
    }).then((value) => Future.delayed(
        const Duration(seconds: 2),
        // ignore: avoid_function_literals_in_foreach_calls
        () => _cards.forEach((e) => _flip(e.state))));
  }

  void turnPause() {
    _paused = !_paused;
  }

  bool compare(GameCardState card, int index) => card == _cardStack.get(index);

  Future _flip(GameCardState selectedCard) => selectedCard.flip();
  void flipAll() {
    while (!_cardStack.isEmpty) {
      _flip(_cardStack.pop());
    }
  }

  void move(GameCardState selectedCard) {
    if (!selectedCard.fliped && isEnableToMove) {
      _moves++;
      _flip(selectedCard)
      .then((value) {
        _cardStack.add(selectedCard);

        if (_cardStack.isFull) {
          // Executa se a pilha encheu
          if (isEquals) {
            _cardStack.clear();
            --unfindedCouples;
            if (hasWinner()) {
              _table.state.reset();
            }
          } else {
            Future.delayed(const Duration(milliseconds: 300), () => flipAll());
          }
        }
      });
    }
  }

  bool hasWinner() => unfindedCouples == 0;

}

class GameCardStack {
  final _stack = <GameCardState>[];

  void add(GameCardState card) =>
      _stack.length < 2 ? _stack.add(card) : throw Exception("Pilha cheia");

  GameCardState get(int index) =>
      !isEmpty ? _stack[index] : throw Exception("Pilha vazia");

  List<GameCardState> get stack => _stack;
  void clear() => _stack.clear();

  int get length => _stack.length;

  bool get isFull => length == 2;
  bool get isEmpty => _stack.isEmpty;

  GameCardState pop() =>
      !isEmpty ? _stack.removeLast() : throw Exception("Pilha vazia");

  GameCardState get last => _stack.last;
}
