import 'package:delivery_app_demo/feature/order/create_order/resources/repository/order_repository.dart';
import 'package:equatable/equatable.dart';

abstract class CreateOrderEvent extends Equatable {}

class GetCurrentOrder extends CreateOrderEvent {
  final OrderRepository orderRepository;

  GetCurrentOrder(this.orderRepository);

  @override
  List<Object> get props => [];
}

class CalculatePricePressed extends CreateOrderEvent {
  @override
  List<Object> get props => [];
}

class AddDropOffPostCode extends CreateOrderEvent {
  final String postCode;

  AddDropOffPostCode(this.postCode);

  @override
  List<Object> get props => [];
}

class AddPickupPostCode extends CreateOrderEvent {
  final String postCode;

  AddPickupPostCode(this.postCode);

  @override
  List<Object> get props => [];
}

class AddVehicleType extends CreateOrderEvent {
  final String vehicle;

  AddVehicleType(this.vehicle);

  @override
  List<Object> get props => [];
}
