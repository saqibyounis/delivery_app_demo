import 'package:delivery_app_demo/feature/landing/splash_page.dart';
import 'package:delivery_app_demo/feature/order/create_order/ui/create_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/env.dart';
import '../../core/http/api_provider.dart';
import '../../core/util/internet_check.dart';
import '../../core/widget/loading_widget.dart';
import '../authentication/bloc/index.dart';
import '../signin/resources/repository/index.dart';
import '../signin/ui/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: MediaQuery.of(context).size);
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const LoadingWidget(
              visible: true,
            );
          }

          if (state is AuthenticationAuthenticated) {
            return CreateOrderPage();
          }
          if (state is AuthenticationUnauthenticated) {
            return SignInPage(
                authRepository: AuthRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context)));
          }

          return SplashPage();
        });
  }
}
