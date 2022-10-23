import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Color(0xFF015C92),
          size: 50.0,
        ),
      ),
    );
  }
}