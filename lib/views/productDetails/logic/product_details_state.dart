part of 'product_details_cubit.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class GetRatesLoadingState extends ProductDetailsState {}

class GetRatesSuccessState extends ProductDetailsState {}

class GetRatesErrorState extends ProductDetailsState {
  const GetRatesErrorState({required this.error});

  final String error;
}

class AddOrupdateRateLoadingState extends ProductDetailsState {}

class AddOrupdateRateSuccessState extends ProductDetailsState {}

class AddOrupdateRateErrorState extends ProductDetailsState {}

class AddCommentLoadingState extends ProductDetailsState {}

class AddCommentSuccessState extends ProductDetailsState {}

class AddCommentErrorState extends ProductDetailsState {}
