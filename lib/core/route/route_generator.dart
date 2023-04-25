import 'package:delivery_app_demo/feature/order/view_price/ui/view_price_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../feature/landing/landing_page.dart';
import '../../feature/order/create_order/ui/create_order_page.dart';
import '../../feature/signin/resources/repository/index.dart';
import '../../feature/signin/ui/sign_in_page.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute<dynamic>(builder: (_) => LandingPage());

      case Routes.signIn:
        if (args is AuthRepository) {
          return MaterialPageRoute<dynamic>(
              builder: (_) => SignInPage(authRepository: args));
        }

        return _errorRoute();

      case Routes.viewPrice:
        return MaterialPageRoute<dynamic>(
            builder: (_) => ViewPricePage(
                  orderRepository: args,
                ));

        return _errorRoute();

      case Routes.createOrder:
        return MaterialPageRoute<dynamic>(builder: (_) => CreateOrderPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
