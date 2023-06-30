import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String text;
  final Color color;
  const MyTitle({
    super.key,
    required this.text,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 20,
          fontFamily: 'titr',
          shadows: const [
            Shadow(
              blurRadius: 12.0,
              color: Colors.black,
              offset: Offset(0, 2.0),
            ),
            Shadow(
              blurRadius: 12.0,
              color: Colors.white,
              offset: Offset(2.0, 0),
            ),
          ]),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  const MyText({
    super.key,
    required this.text,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontFamily: 'vazir',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
