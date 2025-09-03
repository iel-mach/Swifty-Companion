import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final dynamic data;
  final Color color;
  final String selectedCursus;
  final bool isPortrait;
  const Profile({
    super.key,
    required this.data,
    required this.color,
    required this.selectedCursus,
    required this.isPortrait
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userInfo = widget.data;
    final grade = (widget.selectedCursus == 'C Piscine') ? userInfo['cursus_users'][0]['grade'] : userInfo['cursus_users'][1]['grade'];
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: widget.isPortrait ?  MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Color.fromRGBO(32, 32, 38, 0.85),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Wallet",
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${userInfo['wallet']} ₳",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Evaluation points",
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${userInfo['correction_point']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Grade",
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      grade,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: widget.isPortrait ?  MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Color.fromRGBO(32, 32, 38, 0.85),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Pool Period",
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${userInfo['pool_month']} ${userInfo['pool_year']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: widget.isPortrait ?  MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Color.fromRGBO(32, 32, 38, 0.85),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Compus", 
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${userInfo['campus'][0]['name']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: widget.isPortrait ?  MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Color.fromRGBO(32, 32, 38, 0.85),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.email_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                "${userInfo['email']}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}