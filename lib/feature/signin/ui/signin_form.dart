import 'package:delivery_app_demo/app/colors.dart';
import 'package:delivery_app_demo/core/util/package_info_helper.dart';
import 'package:delivery_app_demo/core/widget/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widget/snack_bar/snack_bar.dart';
import '../bloc/index.dart';

class SignInForm extends StatefulWidget {
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginButtonPressed() {
    BlocProvider.of<SignInBloc>(context).add(
      SignInButtonPressed(
        username: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          RepositoryProvider.of<DAppSnackBar>(context)
              .showErrorSnackBar(state.error, context);
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20.0.sp, right: 20.0.sp),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 28.h),
                    Text("Login",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0.sp)),
                    Form(
                      child: Column(
                        children: [
                          SizedBox(height: 28.h),
                          _emailWidget(),
                          SizedBox(height: 28.h),
                          _passwordWidget(),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const SizedBox(height: 30),
                                _signInButton(state),
                                const SizedBox(height: 30),
                              ]),
                          Container(
                            child: state is SignInLoading
                                ? const CircularProgressIndicator()
                                : null,
                          )
                        ],
                      ),
                    ),
                    Expanded(child: _versionInfoWidget(context))
                  ]));
        },
      ),
    );
  }

  Widget _signInButton(SignInState state) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: primaryColor)),
              backgroundColor: primaryColor,
              minimumSize: Size(double.infinity, 48.0.sp)),
          onPressed: state is! SignInLoading ? _onLoginButtonPressed : null,
          child: Text("Login"),
        ));
  }

  Widget _emailWidget() {
    return InputFieldWidget("Email Address", _emailController);
  }

  Widget _passwordWidget() {
    return InputFieldWidget(
      "Password",
      _passwordController,
      isPasswordField: true,
    );
  }

  Widget _versionInfoWidget(BuildContext context) {
    return Text(
        "Version ${RepositoryProvider.of<PackageInfoHelper>(context).getAppVersion()}");
  }
}
