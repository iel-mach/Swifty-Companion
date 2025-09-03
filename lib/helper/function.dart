import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setAccesToken(String accessToken) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('accessToken', accessToken);
}

Future <String?> getaccessToken() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? accessToken = sharedPreferences.getString('accessToken');
  return accessToken;
}

Future<ImageProvider> getImage(String? coalition, String selectedCursus) async {

  if (selectedCursus == '42cursus'){
    switch (coalition) {
      case 'Bios':
        return AssetImage("assets/Bios.jpg");
      case 'Freax':
        return AssetImage("assets/Freax.jpg");
      case 'Commodore':
        return AssetImage("assets/Commodore.jpg");
      case 'Pandora':
        return AssetImage("assets/Pandora.jpg");
      default:
        return AssetImage("assets/1337.jpg");
    }
  }
  return AssetImage("assets/1337.jpg");
}

Color hexToColor(String hex) {
  if (hex.isEmpty) return Colors.white;
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse(hex, radix: 16));
}