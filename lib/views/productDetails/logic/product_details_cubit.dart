import 'package:app/core/dio_servises.dart';
import 'package:app/views/productDetails/logic/models/rates.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final DioServises _dioServises = DioServises();
  List<Rates> rates = [];
  int userRate = 5;
  int avrage = 0;
  String userId = Supabase.instance.client.auth.currentUser!.id;
  Future<void> getRate({required String productId}) async {
    emit(GetRatesLoadingState());

    try {
      Response response =
          await _dioServises.getData("rates?select=*&product_id=eq.$productId");
      for (var rate in response.data) {
        rates.add(Rates.fromJson(rate));
      }

      for (var userRate in rates) {
        avrage += userRate.rates!;
      }

      if (rates.isNotEmpty) {
        avrage = avrage ~/ rates.length;
      } else {
        avrage = 0;
      }

      List<Rates> userRates = rates.where((Rates rates) {
        return rates.userId == userId;
      }).toList();
      if (userRates.isNotEmpty) {
        userRate = userRates[0].rates!;
      }
      if (kDebugMode) {
        print('rate for user ${rates[0].userId}');
        print('user Id $userId');
        print('user length ${userRates.length}');
        print('user length $userRate');
      }
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
    String path = 'rates?select=*&product_id=eq.$productId&user_id=eq.$userId';
    try {
      if (_isRateExist(productId: productId)) {
        await _dioServises.patchData(path, data);
      } else {
        await _dioServises.postData(path, data);
      }
      emit(AddOrupdateRateSuccessState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(AddOrupdateRateErrorState());
    }
  }

  Future<void> addComment({
    required Map<String, dynamic> data,
    required String productId,
    required String userId,
  }) async {
    emit(AddCommentLoadingState());
    String path = 'comments?&user_id=eq.$userId&product_id=eq.$productId';
    try {
      await _dioServises.postData(path, data);
      emit(AddCommentSuccessState());
    } catch (e) {
      emit(AddCommentErrorState());
    }
  }
}
