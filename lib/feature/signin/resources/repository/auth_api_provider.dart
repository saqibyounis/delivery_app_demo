import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import '../../../../core/http/api_provider.dart';

class AuthApiProvider {
  AuthApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final String baseUrl;

  ApiProvider apiProvider;

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final String data =
          json.encode({'username': email, 'password': password});
      return await apiProvider.post('$baseUrl/auth/login', data);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}
