import 'package:delivery_app_demo/core/constant/env.dart';
import 'package:delivery_app_demo/core/route/routes.dart';
import 'package:delivery_app_demo/core/widget/dialog/DAppDialog.dart';
import 'package:delivery_app_demo/core/widget/drop_down_widget/drop_down_widget.dart';
import 'package:delivery_app_demo/core/widget/input_field_widget.dart';
import 'package:delivery_app_demo/core/widget/loading_widget.dart';
import 'package:delivery_app_demo/feature/authentication/bloc/authentication_bloc.dart';
import 'package:delivery_app_demo/feature/authentication/bloc/authentication_event.dart';
import 'package:delivery_app_demo/feature/order/create_order/bloc/create_order_bloc.dart';
import 'package:delivery_app_demo/feature/order/create_order/bloc/create_order_event.dart';
import 'package:delivery_app_demo/feature/order/create_order/bloc/create_order_state.dart';
import 'package:delivery_app_demo/feature/order/create_order/resources/repository/order_repository.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../../../app/colors.dart';

class CreateOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateOrderPageState();
  }
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final TextEditingController pickupPostCodeTextController =
      TextEditingController();
  final TextEditingController dropOffPostCodeTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<OrderRepository>(
      create: (context) => OrderRepository(),
      child: BlocProvider<CreateOrderBloc>(
        create: (context) => CreateOrderBloc(LoadingOrder())
          ..add(
              GetCurrentOrder(RepositoryProvider.of<OrderRepository>(context))),
        child: Scaffold(appBar: _appBar(context), body: _bodyWidget(context)),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text("Create Order"),
      actions: [
        IconButton(
            onPressed: () => _onLogoutPressed(context),
            icon: Icon(Icons.exit_to_app))
      ],
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          return Container(
            margin: EdgeInsets.all(8.0.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.0.h,
                  ),
                  InputFieldWidget(
                      "Pickup Post Code",
                      pickupPostCodeTextController
                        ..addListener(() {
                          BlocProvider.of<CreateOrderBloc>(context).add(
                              AddPickupPostCode(
                                  pickupPostCodeTextController.text));
                        })),
                  SizedBox(
                    height: 8.0.h,
                  ),
                  InputFieldWidget(
                      "Drop off Post Code",
                      dropOffPostCodeTextController
                        ..addListener(() {
                          BlocProvider.of<CreateOrderBloc>(context).add(
                              AddDropOffPostCode(
                                  dropOffPostCodeTextController.text));
                        })),
                  SizedBox(
                    height: 24.0.h,
                  ),
                  DropDownWidget(
                      state.vehicles.map((e) => e.name).toList().cast(),
                      state.order.vehicleType == null
                          ? "Not Selected"
                          : state.order.vehicleType.name,
                      (value) => this._onVehicleSelected(context, value)),
                  SizedBox(height: 180.0.h),
                  _calculatePriceButton(context)
                ],
              ),
            ),
          );
        }

        return Container(
          child: LoadingWidget(
            visible: true,
          ),
        );
      },
    );
  }

  Widget _calculatePriceButton(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: primaryColor)),
              backgroundColor: primaryColor,
              minimumSize: Size(double.infinity, 48.0.sp)),
          onPressed: () => this._onCalculatePricePressed(context),
          child: Text("Calculate"),
        ));
  }

  void _showLocationPicker(BuildContext context) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(RepositoryProvider.of<Env>(context).gMapKey)));

    print(result);
  }

  void _onAddPickupCodeTapped(BuildContext context) {
    print("_onAddPickupCodeTapped");
    this._showLocationPicker(context);
  }

  void _onAddDropOffCodeTapped(BuildContext context) {
    this._showLocationPicker(context);
  }

  void _onCalculatePricePressed(BuildContext context) {
    Navigator.pushNamed(context, Routes.viewPrice,
        arguments: RepositoryProvider.of<OrderRepository>(context));
  }

  void _onVehicleSelected(
      BuildContext context, DropDownValueModel vehicleType) {
    BlocProvider.of<CreateOrderBloc>(context)
        .add(AddVehicleType(vehicleType.name));
  }

  void _onLogoutPressed(BuildContext context) {
    RepositoryProvider.of<DAppDialog>(context).showYesNoDIalog(context,
        () => BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()));
  }
}
