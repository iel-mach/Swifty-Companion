import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:swif/component/profile.dart';
import 'package:swif/component/projects.dart';
import 'package:swif/component/skills.dart';
import 'package:swif/component/userinfo.dart';
import 'package:swif/helper/function.dart';
import 'package:swif/screens/search_page.dart';

class HomePage extends StatefulWidget {
  final dynamic data;
  final dynamic coalition;
  const HomePage({super.key, required this.data, required this.coalition});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCursus = '42cursus';
  int indexPage = 0;
  late StreamSubscription<InternetStatus> subscription;
  bool? isInternet;
  String? iamge;

   @override
  void initState() {
    subscription = InternetConnection().onStatusChange.listen((status) {
      switch(status) {
        case InternetStatus.connected:
          setState(() {
            isInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isInternet = false;
          });
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursusUsers = widget.data['cursus_users'];
    final coalition = widget.coalition;
    if(cursusUsers[0]['grade'] == "Pisciner" && cursusUsers.length == 1){
      selectedCursus = 'C Piscine';
    }
    final skillsData = selectedCursus == '42cursus' ? cursusUsers[1]['skills'] :  cursusUsers[0]['skills'];
    bool  coalitionNotEmpty = (coalition is List && coalition.isNotEmpty);
    final Color color = (selectedCursus == 'C Piscine' || !coalitionNotEmpty) ? Color(0xFF02CFCF)  : hexToColor(coalition[0]['color']);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final pages = [
      Profile(data : widget.data, color : color, selectedCursus : selectedCursus, isPortrait : isPortrait),
      Projects(data: widget.data['projects_users'], selectedCursus : selectedCursus), 
      Skills(skills:  skillsData, color: color, isPortrait : isPortrait)
    ];
    iamge = (selectedCursus == 'C Piscine' || !coalitionNotEmpty) ? 'Piciner' : coalition[0]['name'];
    final titles = ['Profile', 'Projects', 'Skills'];
    if(isInternet == false){
      return offlinePage();
    }
    return FutureBuilder(
      future: getImage(iamge, selectedCursus),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError){
          return Center(child: Text("Error loading background image"));
        }
        else if (!snapshot.hasData) {
          return Text("No image found");
        }
        else {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: snapshot.data!,
                fit: BoxFit.cover, 
              )
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () {
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                ),
                title: Text(
                  titles[indexPage],
                  style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
              ),
              backgroundColor: Colors.transparent,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: indexPage,
                onTap: (value) {
                  setState(() {
                    indexPage = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.person, size: 30, color: Colors.grey[700],), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.code, size: 30, color: Colors.grey[700],), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.design_services, size: 30, color: Colors.grey[700],), label: "")
                ]
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: isPortrait ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.65,
                      child: UserInfo(
                        coalition: coalition,
                        data: widget.data,
                        color: color,
                        onCursusChange: (value){
                          setState(() {
                            selectedCursus = value;
                          });
                        },
                        selectedCursus: selectedCursus,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    pages[indexPage],
                  ],
                ),
              ),
            ),
          );
        }
      }
    );
  }
  Widget offlinePage() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Text("You are offline",
          style: TextStyle(
            fontSize: 21,
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}