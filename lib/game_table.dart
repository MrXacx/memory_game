import 'package:flutter/material.dart';
import 'game_card.dart';

class GameTable extends StatelessWidget {
  final _icons = <IconData>[Icons.plus_one];
  final state = _GameTable();

  GameTable({super.key}) {
    _icons.addAll(_icons); // Duplica ícones
    _icons.shuffle(); // Embaralha a lista
  }

  @override
  Widget build(BuildContext context) => GridView.count(
      crossAxisCount: 6,
      children: List.generate(
          _icons.length,
          (index) => GameCard(
              icon: _icons[index]) // Emite uma carta para cada ícone da lista
          ));
}

class _GameTable {
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
