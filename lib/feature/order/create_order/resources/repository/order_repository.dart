import '../model/order.dart';
import '../model/vehicle.dart';

class OrderRepository {
  static final OrderRepository _instance = OrderRepository._internal();
  static Order _order;
  factory OrderRepository() {
    return _instance;
  }

  OrderRepository._internal() {}

  Order get order => _order;

  static void createNewOrder() {
    _order = Order();
  }

  List<Vehicle> getVehicleList() {
    List<Vehicle> vehicleList = [
      Vehicle("Car", 100),
      Vehicle("Small Van", 150),
      Vehicle("Medium Van", 180),
      Vehicle("Luton Van", 200),
    ];

    return vehicleList;
  }

  void addPickUpPostCode(String postCode) {
    _order.pickUpPostCode = postCode;
  }

  void addDropOffPostCode(String postCode) {
    _order.dropOffPostCode = postCode;
  }

  void addVehicleType(String vehicleType) {
    try {
      Vehicle vehicle = getVehicleList().firstWhere(
          (element) => element.name.toLowerCase() == vehicleType.toLowerCase());

      _order.vehicleType = vehicle;
    } catch (ex, stackTrace) {
      _order.vehicleType = null;
    }
  }

  double getPriceWithoutVAT(double distance) {
    double price = distance * _order.vehicleType.pricePerMile;
    return price;
  }

  double getPriceWithVAT(double distance) {
    double price = distance * _order.vehicleType.pricePerMile;
    double VAT = (_order.VAT / 100) * price;

    return price + VAT;
  }
}
