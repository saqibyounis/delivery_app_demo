import 'package:delivery_app_demo/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constant/env.dart';
import '../core/route/route_generator.dart';
import '../core/route/routes.dart';
import 'theme.dart';

class App extends StatelessWidget {
  final Env env;
  final DI di;
  const App({Key key, @required this.env, @required this.di}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: di.diForRepositoryProvider(env),
        child: MultiBlocProvider(
          providers: di.diForBlocProvider(),
          child: MaterialApp(
            title: 'Delivery App Demo',
            theme: basicTheme,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: Routes.landing,
          ),
        ));
  }
}
