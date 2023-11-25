import '../widgets/game_card.dart';

class GameEngine {
  final cardStack = GameCardStack(); // Pilha contendo as duas cartas escolhidas
  bool isEquals() => cardStack.get(0) == cardStack.get(1);
  bool compare(GameCardState card, int index) => card == cardStack.get(index);
}

class GameCardStack {
  final _stack = <GameCardState>[];

  void add(GameCardState card) =>
      _stack.length < 2 ? _stack.add(card) : throw Exception("Pilha cheia");

  GameCardState get(int index) =>
      _stack.isNotEmpty ? _stack[index] : throw Exception("Pilha vazia");

  List<GameCardState> get stack => _stack;

  void clear() => _stack.clear();

  int length() => _stack.length;

  bool isFull() => length() == 2;
}
