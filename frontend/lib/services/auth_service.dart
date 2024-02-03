// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lifelens/helpers/constants.dart';
import 'package:flutter/widgets.dart';

class _LoginInfo extends ChangeNotifier {
  var _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value){
    _isLoggedIn = value;
    notifyListeners();
  }
}


class AuthService {
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;
  AuthService._internal();

  final _loginInfo = _LoginInfo();
  get loginInfo => _loginInfo;

  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

 
 login() async {
  
  final authorizationTokenRequest = AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI, issuer: AUTH0_ISSUER, scopes:['openid', 'profile', 'email', 'offline_access',],);

  final result = await appAuth.authorizeAndExchangeCode(authorizationTokenRequest);

  
  
   _loginInfo.isLoggedIn= true;


 }

 logout(){
  _loginInfo.isLoggedIn = false;
 }
}
