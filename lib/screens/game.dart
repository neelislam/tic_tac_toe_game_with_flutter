import 'package:flutter/material.dart';

import '../constants/colors.dart';

class gamePage extends StatefulWidget {
  const gamePage({super.key});

  @override
  State<gamePage> createState() => _gamePageState();
}

class _gamePageState extends State<gamePage> {
  bool oTurn = true;
  String resultDeclaration = '';
  bool winnerFound = false;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player O', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ) ,),
                          Text(oScore.toString(), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ) ,)
                        ],
                      ),
                      SizedBox(width: 50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player X', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ) ,),
                          Text(xScore.toString(), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ) ,)
                        ],
                      ),
                    ],

                  ),
                )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // Corrected typo and made it const
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                itemCount: 9, // For a 3x3 Tic-Tac-Toe board
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: MainColor.primaryColor,
                        ),
                        color: MainColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(
                            color: MainColor.primaryColor,
                            fontSize: 80,

                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(flex: 2, child: Text(resultDeclaration)),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //1st row check
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        _updateScore(displayXO[0]);
      });
    }
    //2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[4] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[3]} Wins!';
        _updateScore(displayXO[3]);
      });
    }

    //3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[7] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} Wins!';
        _updateScore(displayXO[6]);
      });
    }

    //1st col check
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        _updateScore(displayXO[0]);
      });
    }
    //2nd col
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[1]} Wins!';
        _updateScore(displayXO[1]);
      });
    }

    //3rd col
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} Wins!';
        _updateScore(displayXO[2]);
      });
    }

    //corner 1
    //0- 4 - 8

    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        _updateScore(displayXO[0]);
      });
    }
    //corner 2
    //2 - 4- 6
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} Wins!';
        _updateScore(displayXO[2]);
      });
    }
    if( !winnerFound && filledBoxes == 9){
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }

  void _updateScore(String winner){
    if(winner == 'O'){
      oScore++;
    }else if(winner == 'X'){
      xScore++;
    }
    winnerFound = true;

  }
}
