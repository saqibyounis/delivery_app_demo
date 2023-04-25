import 'package:bloc/bloc.dart';
import 'package:delivery_app_demo/core/http/response.dart';
import 'package:delivery_app_demo/core/util/geolocator_helper.dart';
import 'package:delivery_app_demo/feature/order/view_price/bloc/index.dart';
import 'package:delivery_app_demo/feature/order/view_price/resources/repository/postcode_repository.dart';
import 'package:place_picker/place_picker.dart';

class ViewPriceBloc extends Bloc<ViewPriceEvent, ViewPriceState> {
  ViewPriceBloc(ViewPriceState initialState) : super(initialState) {
    on<LoadViewPricePage>((event, emitter) async {
      await this._onLoadViewPricePage(event, emitter);
    });
  }

  Future<void> _onLoadViewPricePage(
      LoadViewPricePage event, Emitter emitter) async {
    emitter(LoadingViewPricePage());
    PostCodeRepository postCodeRepository = PostCodeRepository(
        env: event.env,
        apiProvider: event.apiProvider,
        internetCheck: event.internetCheck);

    DataResponse<List<LatLng>> latLngListResponse =
        await postCodeRepository.getLatLngForPostCodes(
            event.orderRepository.order.pickUpPostCode,
            event.orderRepository.order.dropOffPostCode);
    GeolocatorHelper geolocatorHelper = GeolocatorHelper();

    if (latLngListResponse.status == Status.Success) {
      double distance =
          await geolocatorHelper.calculateDistanceBetweenTwoPointsInMiles(
              latLngListResponse.data[0].latitude,
              latLngListResponse.data[0].longitude,
              latLngListResponse.data[1].latitude,
              latLngListResponse.data[1].longitude);
      double priceWithVAT = event.orderRepository.getPriceWithVAT(distance);
      double priceWithoutVAT =
          event.orderRepository.getPriceWithoutVAT(distance);
      priceWithVAT = priceWithVAT / 100;
      priceWithoutVAT = priceWithoutVAT / 100;
      emitter(ViewPricePageLoaded(priceWithVAT, priceWithoutVAT));
    } else {
      emitter(ErrorLoadingData(latLngListResponse.message));
    }
  }
}
