import 'package:flutter/material.dart';
import 'package:swif/component/custombar.dart';

class Skills extends StatelessWidget {
  final dynamic skills;
  final Color color;
  final bool isPortrait;
  const Skills({super.key, required this.skills, required this.color, required this.isPortrait});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final levelData = skills[index]['level'];
        final levelDouble = double.tryParse(levelData.toString()) ?? 0.0;
        final level = levelDouble.floor();
        final per = levelDouble - level;
        final perRounded = double.parse(per.toStringAsFixed(2));
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: isPortrait ? MediaQuery.of(context).size.height * 0.15 : MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(32, 32, 38, 0.85),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  skills[index]['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Custombar(level: level, percentage: perRounded, color: color)
              ],
            ),
          ),
        );
      }
    );
  }
}