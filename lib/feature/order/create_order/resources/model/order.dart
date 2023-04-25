import 'package:delivery_app_demo/feature/order/create_order/resources/model/vehicle.dart';

class Order {
  String _pickUpPostCode;
  String _dropOffPostCode;
  Vehicle _vehicleType;
  final double _VAT = 20;

  String get pickUpPostCode => _pickUpPostCode;

  set pickUpPostCode(String value) {
    _pickUpPostCode = value;
  }

  String get dropOffPostCode => _dropOffPostCode;

  Vehicle get vehicleType => _vehicleType;

  set vehicleType(Vehicle value) {
    _vehicleType = value;
  }

  set dropOffPostCode(String value) {
    _dropOffPostCode = value;
  }

  double get VAT => _VAT;
}
