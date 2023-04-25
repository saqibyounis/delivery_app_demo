import 'package:bloc/bloc.dart';
import 'package:delivery_app_demo/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc/simple_bloc_delegate.dart';
import 'core/constant/env.dart';
import 'core/di/di.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = SimpleBlocDelegate();
  DI di = DI();
  runApp(App(env: EnvValue.development));
}
