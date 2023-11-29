import 'package:flutter/material.dart';
import 'package:memory_game/widgets/game_table.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: "Jogo da Memória",
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> icons = [
    // Lista de nomes do ícones
    'astronaut',
    'bear',
    'capybara',
    'fighter',
    'greech',
    'rocket',
    'ship',
    'soldier',
    'spy',
    'trevor',
  ];
  static GameTable table = GameTable(icons: icons); // Tabuleiro
  int moves = 0; // Contador de jogadas
  int time = 0; // Contador de tempo
  bool paused = true; // Estado do jogo

  @override
  Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Jogo da Memória',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5),
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
            ),
          ),
          bottomSheet: BottomAppBar(
            surfaceTintColor: Theme.of(context).colorScheme.inversePrimary,
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Número de tenttivas: $moves",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "$time",
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
          ),
          body: Center(
              child: SizedBox(
                  width: 768,
                  height: 1000,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [Expanded(child: table.build(context))],
                  ))),
          persistentFooterAlignment: AlignmentDirectional.bottomCenter,
          persistentFooterButtons: [
            IconButton(
                onPressed: turnPause,
                icon: Icon(paused == true ? Icons.arrow_forward : Icons.pause)),
            IconButton(onPressed: reset, icon: const Icon(Icons.refresh)),
          ]);

  void countTime() => setState(() => ++time);
  void turnPause() => setState(() => paused = !paused);

  void reset() => setState(() {
        moves = 0;
        time = 0;
        paused = true;
        table = GameTable(icons: icons);
      });
}
