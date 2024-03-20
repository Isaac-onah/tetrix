import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetrix/piece.dart';
import 'package:tetrix/pixel.dart';
import 'package:tetrix/values.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {


  //current tetrix piece
  Piece currentPiece = Piece(type: Tetromino.T);

  @override
  void initState() {
    super.initState();

    //start game when app  starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
//frame refresh rate
  Duration frameRate = const Duration(milliseconds: 800);
  gameLoop(frameRate);
  }

  //gameLoop
  void gameLoop(Duration frameRate){
Timer.periodic(
  frameRate,(timer){
    setState(() {
      //move to current piece position down
      currentPiece.movePiece(Direction.down);
    });
  }
);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
          itemCount: rowLength * colLength,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowLength),
          itemBuilder: (context, index) {
            if(currentPiece.position.contains(index)){
              return Pixel(color: Colors.yellow, child: index,);
            }else{
              return Pixel(color: Colors.grey[900], child: index,);
            }
          }),
    );
  }
}
