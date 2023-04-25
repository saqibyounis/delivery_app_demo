import 'dart:core';

import 'package:delivery_app_demo/feature/signin/ui/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/index.dart';
import '../bloc/index.dart';
import '../resources/repository/index.dart';

class SignInPage extends StatelessWidget {
  final AuthRepository authRepository;

  SignInPage({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Delivery App Demo"),
        ),
        body: RepositoryProvider(
          create: (context) => authRepository,
          child: BlocProvider(
            create: (context) {
              return SignInBloc(
                SignInInitial(),
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                authRepository: authRepository,
              );
            },
            child: SignInForm(),
          ),
        ));
  }
}
