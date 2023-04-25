import 'package:delivery_app_demo/core/constant/env.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/http/api_provider.dart';
import '../../../../core/util/internet_check.dart';
import '../../create_order/resources/repository/order_repository.dart';

abstract class ViewPriceEvent extends Equatable {}

class LoadViewPricePage extends ViewPriceEvent {
  final OrderRepository orderRepository;
  final Env env;
  final ApiProvider apiProvider;
  final InternetCheck internetCheck;

  LoadViewPricePage(
      this.orderRepository, this.env, this.apiProvider, this.internetCheck);

  @override
  List<Object> get props => [];
}
