import 'dart:async';
import 'dart:convert';

import 'package:delivery_app_demo/core/http/api_provider.dart';
import 'package:meta/meta.dart';

class PostCodeApiProvider {
  PostCodeApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final String baseUrl;

  ApiProvider apiProvider;

  Future<Map<String, dynamic>> getLatLngForPostCodes(
      String postCode1, String postCode2) async {
    try {
      final String data = json.encode({
        "postcodes": [postCode1, postCode2]
      });
      print(data);
      return await apiProvider.post('$baseUrl/postcodes', data);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}
