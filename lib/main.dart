import 'package:flutter/material.dart';
import 'package:swif/helper/function.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swif/screens/search_page.dart';
import 'package:swif/services/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final auth = AuthService();
  final String? accessToken = await auth.getAccessToken();
  if(accessToken != null) {
   setAccesToken(accessToken);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}