import 'package:bloc/bloc.dart';
import 'package:delivery_app_demo/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';
import 'core/bloc/simple_bloc_delegate.dart';
import 'core/constant/env.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = SimpleBlocDelegate();
  DI di = DI();
  runApp(App(
    env: EnvValue.production,
    di: di,
  ));
}
