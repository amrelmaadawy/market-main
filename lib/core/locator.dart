import 'package:app/core/dio_servises.dart';
import 'package:app/core/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton<DioServises>(() => DioServises());

  // Repositories
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(dioServises: locator<DioServises>()));
}
