import 'package:delivery_app_demo/core/http/api_provider.dart';
import 'package:delivery_app_demo/feature/order/view_price/resources/repository/postcode_api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:place_picker/place_picker.dart';

import '../../../../../core/constant/env.dart';
import '../../../../../core/http/response.dart';
import '../../../../../core/util/internet_check.dart';

class PostCodeRepository {
  final ApiProvider apiProvider;
  PostCodeApiProvider postCodeApiProvider;
  InternetCheck internetCheck;
  Env env;

  PostCodeRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck}) {
    postCodeApiProvider = PostCodeApiProvider(
        baseUrl: env.postCodeAPIUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<List<LatLng>>> getLatLngForPostCodes(
      String postCode1, String postCode2) async {
    final response =
        await postCodeApiProvider.getLatLngForPostCodes(postCode1, postCode2);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response['status'] == 200) {
      try {
        List result = response["result"];

        LatLng latLng1 = LatLng(
            result[0]["result"]["latitude"], result[0]["result"]["longitude"]);
        LatLng latLng2 = LatLng(
            result[1]["result"]["latitude"], result[1]["result"]["longitude"]);

        return DataResponse.success([latLng1, latLng2]);
      } catch (ex, stack) {
        debugPrintStack(stackTrace: stack, label: ex.toString());
        return DataResponse.error("Error");
      }
    } else {
      return DataResponse.error("Error");
    }
  }
}

// {
// "status": 200,
// "result": [
// {
// "query": "B6 6SP",
// "result": {
// "postcode": "B6 6SP",
// "quality": 1,
// "eastings": 407860,
// "northings": 290488,
// "country": "England",
// "nhs_ha": "West Midlands",
// "longitude": -1.885614,
// "latitude": 52.512226,
// "european_electoral_region": "West Midlands",
// "primary_care_trust": "Heart of Birmingham Teaching",
// "region": "West Midlands",
// "lsoa": "Birmingham 037E",
// "msoa": "Birmingham 037",
// "incode": "6SP",
// "outcode": "B6",
// "parliamentary_constituency": "Birmingham, Perry Barr",
// "admin_district": "Birmingham",
// "parish": "Birmingham, unparished area",
// "admin_county": null,
// "date_of_introduction": "198001",
// "admin_ward": "Aston",
// "ced": null,
// "ccg": "NHS Birmingham and Solihull",
// "nuts": "Birmingham",
// "pfa": "West Midlands",
// "codes": {
// "admin_district": "E08000025",
// "admin_county": "E99999999",
// "admin_ward": "E05011121",
// "parish": "E43000250",
// "parliamentary_constituency": "E14000566",
// "ccg": "E38000258",
// "ccg_id": "15E",
// "ced": "E99999999",
// "nuts": "TLG31",
// "lsoa": "E01008916",
// "msoa": "E02001863",
// "lau2": "E08000025",
// "pfa": "E23000014"
// }
// }
// },
// {
// "query": "B29 7DN",
// "result": {
// "postcode": "B29 7DN",
// "quality": 1,
// "eastings": 404783,
// "northings": 283047,
// "country": "England",
// "nhs_ha": "West Midlands",
// "longitude": -1.931057,
// "latitude": 52.445367,
// "european_electoral_region": "West Midlands",
// "primary_care_trust": "South Birmingham",
// "region": "West Midlands",
// "lsoa": "Birmingham 096G",
// "msoa": "Birmingham 096",
// "incode": "7DN",
// "outcode": "B29",
// "parliamentary_constituency": "Birmingham, Selly Oak",
// "admin_district": "Birmingham",
// "parish": "Birmingham, unparished area",
// "admin_county": null,
// "date_of_introduction": "198001",
// "admin_ward": "Bournbrook & Selly Park",
// "ced": null,
// "ccg": "NHS Birmingham and Solihull",
// "nuts": "Birmingham",
// "pfa": "West Midlands",
// "codes": {
// "admin_district": "E08000025",
// "admin_county": "E99999999",
// "admin_ward": "E05011128",
// "parish": "E43000250",
// "parliamentary_constituency": "E14000567",
// "ccg": "E38000258",
// "ccg_id": "15E",
// "ced": "E99999999",
// "nuts": "TLG31",
// "lsoa": "E01033634",
// "msoa": "E02001922",
// "lau2": "E08000025",
// "pfa": "E23000014"
// }
// }
// }
// ]
// }
