import 'package:equatable/equatable.dart';

abstract class ViewPriceState extends Equatable {}

class LoadingViewPricePage extends ViewPriceState {
  @override
  List<Object> get props => [];
}

class ErrorLoadingData extends ViewPriceState {
  final String error;

  ErrorLoadingData(this.error);

  @override
  List<Object> get props => [];
}

class ViewPricePageLoaded extends ViewPriceState {
  final double priceWithVAT;
  final double priceWithoutVAT;

  ViewPricePageLoaded(this.priceWithVAT, this.priceWithoutVAT);

  @override
  List<Object> get props => [];
}
