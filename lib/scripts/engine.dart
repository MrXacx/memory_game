import 'package:memory_game/widgets/card.dart';

class GameEngine {
  bool _paused = true;
  late int unfindedCouples;
  final _cardStack =
      GameCardStack(); // Pilha contendo as duas cartas escolhidas
  final Function onWin;

  GameEngine(int coupleNumber, this.onWin) {
    unfindedCouples = coupleNumber;
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
    while (!_cardStack.isEmpty) {
      flip(_cardStack.pop());
    }
  }

  bool move(GameCardState selectedCard) {
    if (!selectedCard.fliped && isEnableToMove) {
      flip(selectedCard);
      _cardStack.add(selectedCard);

      if (_cardStack.isFull) {
        // Executa se a pilha encheu
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (isEquals) {
            --unfindedCouples;
            _cardStack.clear();

            if (hasWinner()) {
              onWin();
            } else {
              print(unfindedCouples);
            }
          } else {
            flipAll();
          }
        });
        return true;
      }
    }

    return false;
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
