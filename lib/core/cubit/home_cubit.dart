import 'package:app/core/models/product_model/product_model.dart';
import 'package:app/core/repositories/product_repository.dart';
import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductRepository productRepository;

  HomeCubit({required this.productRepository}) : super(HomeInitial());

  List<ProductModel> products = [];
  List<ProductModel> searchResult = [];
  List<ProductModel> categoryList = [];
  List<ProductModel> favoriteProductsList = [];
  List<ProductModel> myOrdersList = [];
  Map<String, bool> isFave = {};
  String userId = "dummy_user_123";
  
  Future<void> getProduct({String? query, String? category}) async {
    products.clear();
    searchResult.clear();
    categoryList.clear();
    favoriteProductsList.clear();
    myOrdersList.clear();
    isFave.clear();
    emit(GetDataLoadingState());
    try {
      products = await productRepository.getProducts();
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
    emit(AddToFaveLoadingState());
    try {
      await productRepository.addToFavorite(productId);

      isFave.addAll({productId: true});
      var product = products.firstWhere((p) => p.productId == productId);
      favoriteProductsList.add(product);

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
    try {
      await productRepository.removeFromFavorite(productId);
      
      isFave.removeWhere((key, value) => key == productId);
      favoriteProductsList.removeWhere((p) => p.productId == productId);
      
      emit(DeletFromFaveSuccesseState());
    } catch (e) {
      emit(DeletFromFaveErrorState());
    }
  }

  void getFaveProduct() {
    // Favorites are handled locally after adding
  }

  Future<void> payment({required String productId}) async {
    emit(PaymentLoadingState());
    try {
      await productRepository.processPayment(productId);
      var product = products.firstWhere((p) => p.productId == productId);
      myOrdersList.add(product);
      emit(PaymentSuccesseState());
    } catch (e) {
      emit(PaymentErrorState());
    }
  }

  void getMyOrders() {
     // Handled locally now in payment
  }
}
