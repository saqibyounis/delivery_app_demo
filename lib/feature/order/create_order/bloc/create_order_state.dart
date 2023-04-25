import 'package:delivery_app_demo/feature/order/create_order/resources/model/order.dart';
import 'package:equatable/equatable.dart';

import '../resources/model/vehicle.dart';

abstract class CreateOrderState extends Equatable {}

class LoadingOrder extends CreateOrderState {
  @override
  List<Object> get props => [];
}

class OrderLoaded extends CreateOrderState {
  final Order order;
  final List<Vehicle> vehicles;
  OrderLoaded(this.order, this.vehicles);

  @override
  List<Object> get props => [];
}
