import '../game_card.dart';

class Game{
  final cardStack = GameCardStack();

  bool isEquals() => cardStack.get(0) == cardStack.get(1);
  bool compare(GameCard card, int index) => card == cardStack.get(index);
}

class GameCardStack {
  final _stack = <GameCard>[];

  void add(GameCard card) =>
      _stack.length < 2 ? _stack.add(card) : throw Exception("Pilha cheia");

  GameCard get(int index) =>
      _stack.isNotEmpty ? _stack[index] : throw Exception("Pilha vazia");

  void clear() => _stack.clear();

  int length() => _stack.length;
}
