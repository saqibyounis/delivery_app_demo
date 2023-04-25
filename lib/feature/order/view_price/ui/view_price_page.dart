import 'package:delivery_app_demo/core/constant/env.dart';
import 'package:delivery_app_demo/core/http/api_provider.dart';
import 'package:delivery_app_demo/core/util/internet_check.dart';
import 'package:delivery_app_demo/core/widget/loading_widget.dart';
import 'package:delivery_app_demo/feature/order/create_order/resources/repository/order_repository.dart';
import 'package:delivery_app_demo/feature/order/view_price/bloc/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPricePage extends StatefulWidget {
  final OrderRepository orderRepository;

  const ViewPricePage({Key key, this.orderRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewPricePageState();
  }
}

class _ViewPricePageState extends State<ViewPricePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewPriceBloc>(
      create: (context) => ViewPriceBloc(LoadingViewPricePage())
        ..add(LoadViewPricePage(
            widget.orderRepository,
            RepositoryProvider.of<Env>(context),
            RepositoryProvider.of<ApiProvider>(context),
            RepositoryProvider.of<InternetCheck>(context))),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Price"),
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return BlocBuilder<ViewPriceBloc, ViewPriceState>(
      builder: (context, state) {
        if (state is ViewPricePageLoaded) {
          return _priceLoadedWidget(context, state);
        }

        if (state is LoadingViewPricePage) {
          return LoadingWidget(
            visible: true,
          );
        }

        if (state is ErrorLoadingData) {
          return _errorWidget(context, state);
        }
        return SizedBox();
      },
    );
  }

  Widget _priceLoadedWidget(BuildContext context, ViewPricePageLoaded state) {
    return Container(
        margin: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            ListTile(
              title: Text("Price (Including VAT 20%)"),
              subtitle: Text("£ ${state.priceWithVAT.toStringAsFixed(3)}"),
            ),
            ListTile(
              title: Text("Price (Excluding VAT)"),
              subtitle: Text("£ ${state.priceWithoutVAT.toStringAsFixed(3)}"),
            ),
          ],
        ));
    ;
  }

  Widget _errorWidget(BuildContext context, ErrorLoadingData state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      margin: EdgeInsets.all(8.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error please try again (${state.error})",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.0.h,
          ),
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Retry"))
        ],
      ),
    );
  }
}
