import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/http/response.dart';
import '../../authentication/bloc/index.dart';
import '../resources/repository/index.dart';
import 'index.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  SignInBloc(
    SignInInitial initialState, {
    @required this.authRepository,
    @required this.authenticationBloc,
  })  : assert(authRepository != null),
        assert(authenticationBloc != null),
        super(initialState) {
    on<SignInButtonPressed>((event, emitter) async {
      await _onSignInButtonPressed(event, emitter);
    });
  }

  Future<void> _onSignInButtonPressed(
      SignInButtonPressed event, Emitter emitter) async {
    emitter(SignInLoading());

    try {
      final response =
          await authRepository.signIn(event.username, event.password);
      if (response.status == Status.ConnectivityError) {
        //Internet problem
        emitter(const SignInFailure(error: ""));
      }
      if (response.status == Status.Success) {
        authenticationBloc.add(LoggedIn(token: response.data));
        emitter(SignInSuccess());
      } else {
        emitter(SignInFailure(error: response.message));
      }
    } catch (error) {
      emitter(SignInFailure(error: error.toString()));
    }
  }
}
