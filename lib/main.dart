import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memory_game/widgets/table.dart';
import 'package:memory_game/widgets/toast.dart';
//import 'package:desktop_window/desktop_window.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setMaxWindowSize(const Size(1024, 1366));
    DesktopWindow.setMinWindowSize(const Size(414, 896));
  }*/

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
    'astronaut', 'bear', 'capybara', 'fighter', 'greech', 'rocket', 'ship',
    'soldier', 'spy', 'trevor',
  ];

  late GameTable table;
  int moves = 0;
  int time = 0; // Contador de tempo
  late Timer timer;
  final formatter = NumberFormat('00');

  _HomeState() {
    table = GameTable(
        icons: icons,
        onPressed: _incrementMoves,
        onWin: () {
          turnPause();
          GameToast().show(context, 5);
          Future.delayed(const Duration(seconds: 5), () {
            reset();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Tentativas: $moves",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
              formatTime(),
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
              children: [
                Expanded(child: table),
              ]),
        )),
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: [
          IconButton(
              onPressed: turnPause,
              icon: Icon(
                  table.engine.isPaused ? Icons.play_arrow_rounded : Icons.pause)),
          IconButton(onPressed: reset, icon: const Icon(Icons.refresh)),
        ]);
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!table.engine.isPaused) {
        setState(() => ++time);
      }
    });
  }

  void turnPause() => setState(() => table.engine.turnPause());
  void reset() => setState(() {
        timer.cancel();
        table.state.reInitialize();
      });

  void _incrementMoves() => setState(() {
        moves++;
      });

  String formatTime() {
    var hours = time ~/ 3600;
    var minutes = (time % 3600) ~/ 60;
    var seconds = time % 60;

    return "${hours > 0 ? "${formatter.format(hours)}:" : ""}${formatter.format(minutes)}:${formatter.format(seconds)}";
  }
}
