import 'package:bloc/bloc.dart';
import 'package:delivery_app_demo/feature/order/create_order/bloc/create_order_event.dart';
import 'package:delivery_app_demo/feature/order/create_order/bloc/create_order_state.dart';
import 'package:delivery_app_demo/feature/order/create_order/resources/repository/order_repository.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  OrderRepository _orderRepository;

  CreateOrderBloc(CreateOrderState initialState) : super(initialState) {
    on<CalculatePricePressed>((event, emitter) async {
      await _onCalculatePricePressed(event, emitter);
    });
    on<GetCurrentOrder>((event, emitter) async {
      await _onGetCurrentOrder(event, emitter);
    });
    on<AddPickupPostCode>((event, emitter) async {
      await _onAddPickupPostCode(event, emitter);
    });
    on<AddDropOffPostCode>((event, emitter) async {
      await _onAddDropOffPostCode(event, emitter);
    });
    on<AddVehicleType>((event, emitter) async {
      await _onAddVehicleType(event, emitter);
    });
  }

  Future<void> _onCalculatePricePressed(
      CalculatePricePressed event, Emitter emitter) async {
    emitter(LoadingOrder());
    emitter(OrderLoaded(
        this._orderRepository.order, this._orderRepository.getVehicleList()));
  }

  Future<void> _onGetCurrentOrder(
      GetCurrentOrder event, Emitter emitter) async {
    emitter(LoadingOrder());
    this._orderRepository = event.orderRepository;
    if (this._orderRepository.order == null) {
      OrderRepository.createNewOrder();
    }

    emitter(OrderLoaded(
        this._orderRepository.order, this._orderRepository.getVehicleList()));
  }

  Future<void> _onAddPickupPostCode(
      AddPickupPostCode event, Emitter emitter) async {
    emitter(LoadingOrder());
    this._orderRepository.addPickUpPostCode(event.postCode);
    emitter(OrderLoaded(
        this._orderRepository.order, this._orderRepository.getVehicleList()));
  }

  Future<void> _onAddDropOffPostCode(
      AddDropOffPostCode event, Emitter emitter) async {
    emitter(LoadingOrder());
    this._orderRepository.addDropOffPostCode(event.postCode);
    emitter(OrderLoaded(
        this._orderRepository.order, this._orderRepository.getVehicleList()));
  }

  Future<void> _onAddVehicleType(AddVehicleType event, Emitter emitter) async {
    emitter(LoadingOrder());
    this._orderRepository.addVehicleType(event.vehicle);
    emitter(OrderLoaded(
        this._orderRepository.order, this._orderRepository.getVehicleList()));
  }
}
