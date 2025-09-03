import 'package:flutter/material.dart';

class Custommarks extends StatelessWidget {
  final int? mark;
  final String? cursus;
  final dynamic project;
  const Custommarks({super.key, required this.mark, required this.cursus, required this.project});


  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color colormark;
    if(cursus == '42cursus'){
      if(project['project']['name'].toString().toLowerCase().contains('exam') && (mark != null && mark != 100)){
        icon = Icons.close;
        colormark = Colors.red;
      }
      else if (!project['project']['name'].toString().toLowerCase().contains('exam') && (mark != null && mark! <= 50)){
        icon = Icons.close;
        colormark = Colors.red;
      }
      else{
        icon = Icons.check;
        colormark = Colors.green;
      }
    }
    else{
      if(project['project']['name'].toString().toLowerCase().contains('exam') && (mark != null && mark! < 25)){
        icon = Icons.close;
        colormark = Colors.red;
      }
      else if (!project['project']['name'].toString().toLowerCase().contains('exam') && (mark != null && mark! <= 50)){
        icon = Icons.close;
        colormark = Colors.red;
      }
      else{
        icon = Icons.check;
        colormark = Colors.green;
      }
    }
    return SizedBox(
      child: mark != null ? Row(
        children: [
          Icon(icon,color: colormark,),
          Text(
            "$mark",
            style: TextStyle(
              color: colormark,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ) : 
      Icon(
        Icons.access_time,
        color: Colors.green,
      ),
    ) ;
  }
}