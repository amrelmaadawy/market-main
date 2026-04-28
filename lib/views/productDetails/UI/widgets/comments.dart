import 'package:app/core/models/product_model/product_model.dart';
import 'package:app/views/productDetails/logic/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Comments extends StatelessWidget {
  const Comments({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailsCubit>();
          final data = cubit.comments.where((c) => c['product_id'] == productModel.productId).toList();

          return data.isEmpty? Text('No comments yet '): ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]["user_name"],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(data[index]["comment"],
                          style: TextStyle(fontSize: 15)),
                      SizedBox(
                        height: 5,
                      ),
                      data[index]["reply"] != null
                          ? Column(
                              children: [
                                Text("Replay :-",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data[index]["reply"],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            )
                          : Container()
                    ]);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: data.length);
        });
  }
}
