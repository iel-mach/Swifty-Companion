import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_exception.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final clientId = dotenv.env['clientId'].toString();
  final clientSecret = dotenv.env['clientSecret'].toString();
  final redirectUri = dotenv.env['redirectUri'].toString();
  final customScheme = dotenv.env['customScheme'].toString();
  final issue = "${dotenv.env['API_BASE_URL']}/oauth";

  late OAuth2Helper oauth2Helper;

  AuthService() {
    final client = OAuth2Client(
      authorizeUrl: '$issue/authorize',
      tokenUrl: '$issue/token',
      redirectUri: redirectUri,
      customUriScheme: customScheme,
      
    );

    oauth2Helper = OAuth2Helper(
      client,
      grantType:  OAuth2Helper.clientCredentials,
      clientId: clientId,
      clientSecret: clientSecret,
      enablePKCE: false,
      scopes: ['public'],
      
    );
  }

  OAuth2Helper get helper => oauth2Helper;

  Future<AccessTokenResponse?> get getToken async =>
      await oauth2Helper.getToken();

  Future<String?> getAccessToken() async {
    try {
      AccessTokenResponse? tokenResponse = await oauth2Helper.getToken();
      if (tokenResponse != null) {
        if (tokenResponse.isExpired()) {
          await oauth2Helper.refreshToken(tokenResponse);
          tokenResponse = await oauth2Helper.getToken();
        }
        return tokenResponse!.accessToken;
      }
    } on OAuth2Exception catch (e) {
      print("OAuth Error: ${e.error}");
      print("Details: ${e.errorDescription}");
    } catch (e, stack) {
      print("General Error: $e");
      print(stack);
    }
    return null;
  }
}