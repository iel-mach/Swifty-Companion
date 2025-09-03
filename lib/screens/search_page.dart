import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:swif/screens/home_page.dart';
import 'package:swif/services/data_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isloading = false;
  late StreamSubscription<InternetStatus> subscription;
  bool? isInternet;
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
    final data = DataService();
    TextEditingController searchController = TextEditingController();
    if(isInternet == false){
      return offlinePage();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: !isloading ?  SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("./assets/42logo.png", width: 100,),
              SizedBox(height: 20,),
              Form(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(
                      color: Colors.grey
                    ),
                    decoration: InputDecoration(
                      hint: Text("search.."),
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.amberAccent
          
                        ),
          
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.amberAccent
                        ),
                      ),
                    ),
                  ),
                )
              ),
              SizedBox(height: 20,),
              MaterialButton(
                color: Colors.amber,
                onPressed:  () async {
                  if(searchController.text.isEmpty){
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Type Username',
                      desc: 'Please type username before submitting..',
                      btnOkOnPress: () {},
                    ).show();
                  }
                  final user = await data.getUsers(searchController.text);
                  if(searchController.text == user['login']){
                    if(!context.mounted) return;
                    await showDialog(
                      context: context,
                      builder: (context) =>
                        AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: InkWell(
                            onTap: () async {
                              if(user['cursus_users'][0]['has_coalition'] == true){
                                setState(() => isloading = true);
                                final coalition = await data.getCoalition(user['login']);
                                setState(() => isloading = false);
                                if(!context.mounted) return;
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    data: user,
                                    coalition: coalition
                                  )
                                ), (route) => false
                                );
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user['image']['versions']['large']),
                                  radius: 50,
                                ),
                                SizedBox(width: 15,),
                                Text(
                                  user['login'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  }
                  else{
                     if(!context.mounted) return;
                     AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'User Not Found',
                      desc: 'This is User Not found',
                      btnOkOnPress: () {},
                    ).show();
                  }
                } ,
                child: Text("Search"),
              )
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
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
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}