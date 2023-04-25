import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../resource/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(AuthenticationLoading initialState,
      {@required this.userRepository})
      : assert(userRepository != null),
        super(initialState) {
    on<AuthenticationEvent>((event, emitter) async {
      await _onAuthenticationEvent(event, emitter);
    });
    on<LoggedIn>((event, emitter) async {
      await _onLoggedIn(event, emitter);
    });
    on<LoggedOut>((event, emitter) async {
      await _onLoggedOut(event, emitter);
    });
  }

  Future<void> _onAuthenticationEvent(
      AuthenticationEvent event, Emitter emitter) async {
    final bool hasToken = await userRepository.hasToken();

    if (hasToken) {
      emitter(AuthenticationAuthenticated());
    } else {
      emitter(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter emitter) async {
    emitter(AuthenticationLoading());
    await userRepository.persistToken(event.token);
    emitter(AuthenticationAuthenticated());
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter emitter) async {
    emitter(AuthenticationLoading());
    await userRepository.deleteToken();
    emitter(AuthenticationUnauthenticated());
  }
}
