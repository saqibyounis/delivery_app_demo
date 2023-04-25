import 'package:delivery_app_demo/core/constant/env.dart';
import 'package:delivery_app_demo/core/http/api_provider.dart';
import 'package:delivery_app_demo/core/http/response.dart';
import 'package:delivery_app_demo/core/util/geolocator_helper.dart';
import 'package:delivery_app_demo/core/util/internet_check.dart';
import 'package:delivery_app_demo/feature/order/create_order/resources/repository/order_repository.dart';
import 'package:delivery_app_demo/feature/order/view_price/resources/repository/postcode_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:place_picker/place_picker.dart';

void main() {
  test("Unit Testing for PostCode Repository", () async {
    PostCodeRepository postCodeRepository = PostCodeRepository(
        env: EnvValue.production,
        apiProvider: ApiProvider(),
        internetCheck: InternetCheck());
    OrderRepository orderRepository = OrderRepository();
    OrderRepository.createNewOrder();
    orderRepository.addVehicleType("Car");
    DataResponse<List<LatLng>> latLngListResponse =
        await postCodeRepository.getLatLngForPostCodes("B6 6SP", "B29 7DN");
    GeolocatorHelper geolocatorHelper = GeolocatorHelper();

    double distance =
        await geolocatorHelper.calculateDistanceBetweenTwoPointsInMiles(
            latLngListResponse.data[0].latitude,
            latLngListResponse.data[0].longitude,
            latLngListResponse.data[1].latitude,
            latLngListResponse.data[1].longitude);
    double priceWithVAT = orderRepository.getPriceWithVAT(distance);
    double priceWithoutVAT = orderRepository.getPriceWithoutVAT(distance);
    priceWithVAT = priceWithVAT / 100;
    priceWithoutVAT = priceWithoutVAT / 100;
    expect(priceWithVAT.toStringAsFixed(3), "6.006");
    expect(priceWithoutVAT.toStringAsFixed(3), "5.005");
  });
}
