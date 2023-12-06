import 'package:memory_game/widgets/card.dart';
import 'package:memory_game/widgets/table.dart';

class GameEngine {
  bool _paused = false;
  final GameTable _table;
  late int unfindedCouples;
  final _cardStack =
      GameCardStack(); // Pilha contendo as duas cartas escolhidas

  GameEngine(this._table, int coupleNumber) {
    unfindedCouples = coupleNumber * 2;
  }

  bool get isEquals =>
      _cardStack.get(0).widget.icon.toString() ==
      _cardStack.get(1).widget.icon.toString();
  bool get isPaused => _paused;
  bool get isEnableToMove => !(isPaused || _cardStack.isFull);

  void turnPause() {
    _paused = !_paused;
  }

  bool compare(GameCardState card, int index) => card == _cardStack.get(index);

  Future flip(GameCardState selectedCard) => selectedCard.flip();

  void flipAll() {
    _cardStack._stack.forEach((e) => flip(e));
  }

  void move(GameCardState selectedCard) {
    if (!selectedCard.fliped && isEnableToMove) {
      flip(selectedCard).then((value) {
        _cardStack.add(selectedCard);

        if (_cardStack.isFull) {
          // Executa se a pilha encheu
          if (isEquals) {
            _cardStack.clear();
            --unfindedCouples;
            if (hasWinner()) {
              _table.state.reInitialize;
            }
          } else {
            Future.delayed(const Duration(milliseconds: 300), flipAll);
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
