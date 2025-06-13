import 'dart:async';
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  List<int> matchedIndexes = [];
  int attempts = 0;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 22
    )
  );
  static var customFontWhiteRes = GoogleFonts.coiny(
      textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontSize: 35
      )
  );

  static var customFontWhitePlayer = GoogleFonts.coiny(
      textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontSize: 30
      )
  );
  static var customFontWhiteScore = GoogleFonts.coiny(
      textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontSize: 40
      )
  );

  static var customFontWhiteTimer = GoogleFonts.coiny(
      textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 3,
          fontSize: 28
      )
  );


  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_){
      setState(() {
        if(seconds > 0){
          seconds--;
        }
      });
    });

  }

  void stopTimer(){
    resetTimer();
    timer?.cancel();
  }

  void resetTimer()=>
    seconds = maxSeconds;

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
                          Text('Player O', style: customFontWhitePlayer ,),
                          Text(oScore.toString(), style: customFontWhiteScore,)
                        ],
                      ),
                      SizedBox(width: 50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player X', style: customFontWhitePlayer ,),
                          Text(xScore.toString(), style: customFontWhiteScore,)
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
                        color: matchedIndexes.contains(index)? MainColor.accentColor:   MainColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(
                            color: MainColor.primaryColor,
                            fontSize: 70,

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

            Expanded(flex: 2,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(resultDeclaration, style: customFontWhiteRes,),
                        SizedBox(height: 80,),
                        _buildTimer()
                      ],
                    )
                )
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null? false : timer!.isActive;
    if (isRunning){
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
  }

  void _checkWinner() {
    //1st row check
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        matchedIndexes.addAll([0,1,2]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[4] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[3]} Wins!';
        matchedIndexes.addAll([3,4,5]);
        stopTimer();

        _updateScore(displayXO[3]);
      });
    }

    //3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[7] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} Wins!';
        matchedIndexes.addAll([6,7,8]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }

    //1st col check
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        matchedIndexes.addAll([0,3,6]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    //2nd col
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[1]} Wins!';
        matchedIndexes.addAll([1,4,7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }

    //3rd col
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} Wins!';
        matchedIndexes.addAll([2,5,8]);
        stopTimer();
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
        matchedIndexes.addAll([0,4,8]);
        stopTimer();
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
        matchedIndexes.addAll([2,4,6]);
        stopTimer();
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

  void _clearBoard(){
    setState(() {
      for(int i = 0; i<9; i++){
        displayXO[i]='';
      }
      resultDeclaration='';
    });
    filledBoxes=0;
  }

  Widget _buildTimer(){

    final isRunning = timer == null? false : timer!.isActive;
    return isRunning ? SizedBox(width: 100, height: 100,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: 1- seconds/maxSeconds,
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 8,
          backgroundColor: MainColor.accentColor,

        ),
        Center(
          child: Text('$seconds', style: customFontWhiteTimer,),
        )
      ],
    ),)  :
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white60,
          padding: EdgeInsets.symmetric(horizontal: 100,vertical: 10),
        ),
        onPressed: (){
          startTimer();
          _clearBoard();
          attempts++;
        },
        child: Text(
          attempts==0 ? 'Start' : 'Play Again',
          style: customFontWhite,
        )
    );
  }
}
