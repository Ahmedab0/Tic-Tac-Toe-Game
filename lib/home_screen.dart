import 'package:flutter/material.dart';
import 'game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSwitch = false;
  String activePlayer = 'X';
  String result = ' ';
  bool gameOver = false;
  int turn = 0;

  Game game = Game();

   late bool landscape;

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    setState(() {
      landscape = isLandscape;
    });
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: !isLandscape
            ? Column(
                children: [
                  // Start Switch
                  // Start Turn Text
                  ...firstBlock(),
                  // Start GridView
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.52,
                    child: GridView.count(
                      padding: const EdgeInsets.all(17),
                      crossAxisCount: 3,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                      children: List.generate(
                        9,
                        (index) => GestureDetector(
                          onTap: gameOver
                              ? null
                              : () {
                                  _onTap(index);
                                  //print('activePlayer => $activePlayer');
                                  //print('PlayerX => ${Player.playerX[index]}');
                                  //print('PlayerO => ${Player.playerO[index]}');
                                },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).shadowColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: FittedBox(
                              child: Text(
                                Player.playerX.contains(index)
                                    ? 'X'
                                    : Player.playerO.contains(index)
                                        ? 'O'
                                        : '',
                                style: TextStyle(
                                  color: Player.playerX.contains(index)
                                      ? Theme.of(context).splashColor
                                      : Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Start Winner Text
                  // Start Button
                  ...lastBlock(),
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.left -
                            MediaQuery.of(context).padding.right) *
                        0.5,
                    child: Column(
                      children: [
                        ...firstBlock(),
                        //SizedBox(height: ),
                        ...lastBlock(),
                      ],
                    ),
                  ),
                  // Start GridView
                  SizedBox(
                    width: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.left -
                            MediaQuery.of(context).padding.right) *
                        0.5,
                    child: GridView.count(
                      padding: const EdgeInsets.all(17),
                      crossAxisCount: 3,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                      children: List.generate(
                        9,
                        (index) => GestureDetector(
                          onTap: gameOver
                              ? null
                              : () {
                                  _onTap(index);
                                  //print('activePlayer => $activePlayer');
                                  //print('PlayerX => ${Player.playerX[index]}');
                                  //print('PlayerO => ${Player.playerO[index]}');
                                },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).shadowColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: FittedBox(
                              child: Text(
                                Player.playerX.contains(index)
                                    ? 'X'
                                    : Player.playerO.contains(index)
                                        ? 'O'
                                        : '',
                                style: TextStyle(
                                  color: Player.playerX.contains(index)
                                      ? Theme.of(context).splashColor
                                      : Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();
      if (!isSwitch && !gameOver && turn != 9) {
        game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  updateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        result = '$winnerPlayer is the winner';
        gameOver = true;
      } else if (!gameOver && turn == 9) {
        result = 'it\'s Draw!';
      }
    });
  }

  List<Widget> firstBlock() {
    return [
      // Start Switch
      SizedBox(
        height: !landscape
            ? (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.12
            : (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.25,
        child: SwitchListTile.adaptive(
          title: const Text(
            'Turn On/Off Two Player Mode',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          value: isSwitch,
          onChanged: (newValues) {
            setState(() {
              isSwitch = newValues;
            });
          },
        ),
      ),
      // Start Turn Text
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: !landscape
            ? (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.13
            : (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.25,
        child: FittedBox(
          child: Text(
            'It\'s Turn! $activePlayer'.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            //textAlign: TextAlign.center,
          ),
        ),
      ),
    ];
  }

  List<Widget> lastBlock() {
    return [
      // Start Winner Text
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: !landscape
            ? (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.13
            : (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.25,
        //color: Colors.white,
        child: FittedBox(
          child: Text(
            result.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            //textAlign: TextAlign.center,
          ),
        ),
      ),
      // Start Button
      Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        height: !landscape
            ? (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.1
            : (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.25,
        //color: Colors.deepPurple,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).splashColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
          ),
          onPressed: () {
            setState(() {
              Player.playerX = [];
              Player.playerO = [];
              isSwitch = false;
              activePlayer = 'X';
              result = ' ';
              gameOver = false;
              turn = 0;
            });
          },
          icon: const Icon(
            Icons.replay,
            size: 28,
          ),
          label: const Text(
            'Repeat The Game',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    ];
  }
}
