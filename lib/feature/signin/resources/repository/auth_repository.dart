import 'package:delivery_app_demo/core/http/api_provider.dart';
import 'package:delivery_app_demo/feature/signin/resources/model/user.dart';
import 'package:meta/meta.dart';

import '../../../../core/constant/env.dart';
import '../../../../core/http/response.dart';
import '../../../../core/util/internet_check.dart';
import 'auth_api_provider.dart';

class AuthRepository {
  final ApiProvider apiProvider;
  AuthApiProvider authApiProvider;
  InternetCheck internetCheck;
  Env env;

  AuthRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck}) {
    authApiProvider =
        AuthApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> signIn(String email, String password) async {
    final response = await authApiProvider.signIn(email, password);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response != null) {
      User user = User.getUserFromMap(response);
      final String token = user.token;
      apiProvider.setToken(token);
      return DataResponse.success(token);
    } else {
      return DataResponse.error("Error");
    }
  }
}
