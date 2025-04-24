import 'package:app/core/dio_servises.dart';
import 'package:app/core/models/product_model/fave_product.dart';
import 'package:app/core/models/product_model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final DioServises _dioServises = DioServises();
  List<ProductModel> products = [];
  List<ProductModel> searchResult = [];
  List<ProductModel> categoryList = [];
  List<ProductModel> favoriteProductsList = [];
  Map<String, bool> isFave = {};
  String userId = Supabase.instance.client.auth.currentUser!.id;
  Future<void> getProduct({String? query, String? category}) async {
    products.clear();
    searchResult.clear();
    categoryList.clear();
    favoriteProductsList.clear();
    emit(GetDataLoadingState());
    try {
      Response response = await _dioServises
          .getData("products?select=*,fave_product(*),purchase(*)");
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFaveProduct();
      search(query);
      getCategory(category);
      emit(GetDataSuccesseState());
    } catch (e) {
      emit(GetDataErrorState(e.toString()));
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResult.add(product);
        }
      }
    }
  }

  void getCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryList.add(product);
        }
      }
    }
  }

  Future<void> addToFave({required String productId}) async {
    String path = 'fave_product';
    emit(AddToFaveLoadingState());
    try {
      await _dioServises.postData(path, {
        "is_favorite": true,
        "for_user": userId,
        "for_product": productId,
      });
      
      isFave.addAll({productId: true});
      emit(AddToFaveSuccesseState());
    } catch (e) {
      emit(AddToFaveErrorState());
    }
  }

  bool checkIsFave({required String productId}) {
    return isFave.containsKey(productId);
  }

  Future<void> deletFave({required String productId}) async {
    emit(DeletFromFaveLoadingState());
    String path = 'fave_product?for_product=eq.$productId&for_user=eq.$userId';
    try {
      await _dioServises.deletData(path);
      isFave.removeWhere((key, value) => key == productId);
      await getProduct();
      emit(DeletFromFaveSuccesseState());
    } catch (e) {
      emit(DeletFromFaveErrorState());
    }
  }

  void getFaveProduct() {
    for (ProductModel product in products) {
      if (product.faveProduct!.isNotEmpty) {
        for (FaveProduct favoriteProduct in product.faveProduct!) {
          if (favoriteProduct.forUser == userId) {
            favoriteProductsList.add(product);
            isFave.addAll({
              product.productId!: true,
            });
          }
        }
      }
    }
  }
}
