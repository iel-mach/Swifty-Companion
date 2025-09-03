import 'package:flutter/material.dart';

class Custombar extends StatelessWidget {
  final double percentage;
  final int level;
  final Color color;
  const Custombar({super.key, required this.level, required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: Stack(
        children: [
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.9,
            color: Color.fromRGBO(32, 32, 38, 0.85), // background dark
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage, // e.g. 0.72 for 72%
            child: Container(
              height: 30,
              color: color, // bar color
            ),
          ),
           Positioned.fill(
            child: Center(
              child: Text(
                'level $level - ${(percentage * 100).round()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}