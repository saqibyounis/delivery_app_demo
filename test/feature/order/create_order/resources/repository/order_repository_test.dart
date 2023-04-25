import 'package:delivery_app_demo/core/constant/env.dart';
import 'package:delivery_app_demo/core/http/api_provider.dart';
import 'package:delivery_app_demo/core/util/internet_check.dart';
import 'package:delivery_app_demo/feature/order/create_order/resources/repository/order_repository.dart';
import 'package:delivery_app_demo/feature/order/view_price/resources/repository/postcode_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Unit testing for Order Repository", () {
    PostCodeRepository postCodeRepository = PostCodeRepository(
        env: EnvValue.production,
        apiProvider: ApiProvider(),
        internetCheck: InternetCheck());
    OrderRepository orderRepository = OrderRepository();
    OrderRepository.createNewOrder();
    expect(orderRepository.order != null, true);
    orderRepository.addVehicleType("Car");
    expect(orderRepository.order.vehicleType != null, true);
    orderRepository.addPickUpPostCode("B6 6SP");
    expect(orderRepository.order.pickUpPostCode, "B6 6SP");
    orderRepository.addDropOffPostCode("B29 7DN");
    expect(orderRepository.order.dropOffPostCode, "B29 7DN");
  });
}
