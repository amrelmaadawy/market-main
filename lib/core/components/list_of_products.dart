import 'package:app/core/components/product_card.dart';
import 'package:app/core/cubit/home_cubit.dart';
import 'package:app/core/functions/snake_bar.dart';
import 'package:app/core/models/product_model/product_model.dart';
import 'package:app/core/shimmer/shimmer_list_of_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfProducts extends StatelessWidget {
  const ListOfProducts({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFaveoriteView = false,
    this.isMyOrdersView = false,
  });
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFaveoriteView;
  final bool isMyOrdersView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProduct(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is PaymentSuccesseState) {
            snakeBar(context, 'payment done successfully', Colors.green);
            Navigator.pop(context);
          }
          if (state is PaymentErrorState) {
            snakeBar(context, 'Error please try again', Colors.red);
          }
        },
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();
          List<ProductModel> product = query != null
              ? homeCubit.searchResult
              : category != null
                  ? homeCubit.categoryList
                  : isFaveoriteView
                      ? homeCubit.favoriteProductsList
                      : isMyOrdersView
                          ? homeCubit.myOrdersList
                          : homeCubit.products;
          return product.isEmpty
              ? Center(
                  child: Text(
                    'There is no element',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              : state is GetDataLoadingState
                  ? ShimmerListOfProduct()
                  : ListView.builder(
                      shrinkWrap: shrinkWrap ?? true,
                      physics: physics ?? const NeverScrollableScrollPhysics(),
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          onPaymentSuccess: () {
                            homeCubit.payment(
                                productId: product[index].productId!);
                          },
                          products: product[index],
                          isFave: homeCubit.checkIsFave(
                              productId: product[index].productId!),
                          onPressed: () {
                            bool isFavorite = homeCubit.checkIsFave(
                                productId: product[index].productId!);
                            isFavorite
                                ? homeCubit.deletFave(
                                    productId: product[index].productId!)
                                : homeCubit.addToFave(
                                    productId: product[index].productId!);
                          },
                        );
                      });
        },
      ),
    );
  }
}
