import 'package:delivery_app_demo/core/util/package_info_helper.dart';
import 'package:delivery_app_demo/core/widget/dialog/DAppDialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/authentication/bloc/authentication_bloc.dart';
import '../../feature/authentication/bloc/authentication_event.dart';
import '../../feature/authentication/bloc/authentication_state.dart';
import '../../feature/authentication/resource/user_repository.dart';
import '../bloc/connectivity/connectivity_bloc.dart';
import '../bloc/connectivity/connectivity_state.dart';
import '../constant/env.dart';
import '../http/api_provider.dart';
import '../util/internet_check.dart';
import '../widget/snack_bar/snack_bar.dart';

class DI {
  static final DI _instance = DI._internal();

  factory DI() {
    return _instance;
  }

  DI._internal() {}

  List<RepositoryProvider> diForRepositoryProvider(Env env) {
    return [
      RepositoryProvider<Env>(
        create: (context) => env,
        lazy: true,
      ),
      RepositoryProvider<InternetCheck>(
        create: (context) => InternetCheck(),
        lazy: true,
      ),
      RepositoryProvider<UserRepository>(
        create: (context) => UserRepository(),
        lazy: true,
      ),
      RepositoryProvider<ApiProvider>(
        create: (context) => ApiProvider(),
        lazy: true,
      ),
      RepositoryProvider<DAppSnackBar>(
        create: (context) => DAppSnackBar(),
        lazy: true,
      ),
      RepositoryProvider<DAppDialog>(
        create: (context) => DAppDialog(),
        lazy: true,
      ),
      RepositoryProvider<PackageInfoHelper>(
        create: (context) => PackageInfoHelper(),
        lazy: false,
      ),
    ];
  }

  List<BlocProvider> diForBlocProvider() {
    return [
      BlocProvider<ConnectivityBloc>(
        create: (context) {
          return ConnectivityBloc(AppStarted());
        },
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(AuthenticationLoading(),
              userRepository: RepositoryProvider.of<UserRepository>(context))
            ..add(AuthStarted());
        },
      ),
    ];
  }
}
