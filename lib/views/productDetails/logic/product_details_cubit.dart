import 'package:app/views/productDetails/logic/models/rates.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  List<Rates> rates = [];
  List<Map<String, dynamic>> comments = []; 
  int userRate = 5;
  int avrage = 0;
  String userId = "dummy_user_123";

  Future<void> getRate({required String productId}) async {
    emit(GetRatesLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock network
      emit(GetRatesSuccessState());
    } catch (e) {
      emit(GetRatesErrorState(error: e.toString()));
    }
  }

  bool _isRateExist({required String productId}) {
    return rates
        .any((rate) => rate.userId == userId && rate.productId == productId);
  }

  Future<void> addOrUpdateRate(
      {required String productId, required Map<String, dynamic> data}) async {
    emit(AddOrupdateRateLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock network
      if (_isRateExist(productId: productId)) {
         var index = rates.indexWhere((r) => r.userId == userId && r.productId == productId);
         if(index != -1) rates[index] = Rates.fromJson(data);
      } else {
         rates.add(Rates.fromJson(data));
      }
      userRate = data['rates'];
      emit(AddOrupdateRateSuccessState());
    } catch (e) {
      emit(AddOrupdateRateErrorState());
    }
  }

  Future<void> addComment({
    required Map<String, dynamic> data,
    required String productId,
    required String userId,
  }) async {
    emit(AddCommentLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock network
      comments.add(data);
      emit(AddCommentSuccessState());
    } catch (e) {
      emit(AddCommentErrorState());
    }
  }
}
