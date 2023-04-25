import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'index.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription subscription;

  ConnectivityBloc(AppStarted initialState) : super(initialState) {
    final ConnectivityState currentState = state;
    if (currentState is AppStarted) {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult connectivityResult) {
        // Got a new connectivity status!
        if (connectivityResult == ConnectivityResult.mobile) {
          InternetAvailable();
          return true;
        } else if (connectivityResult == ConnectivityResult.wifi) {
          InternetAvailable();
          return true;
        } else {
          InternetUnAvailable();
          return false;
        }
      });
    }
  }

  @override
  ConnectivityState get initialState => AppStarted();

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
