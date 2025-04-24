import 'package:app/core/components/cashed_loading_image.dart';
import 'package:app/core/functions/custom_app_bar.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:app/core/models/product_model/product_model.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/productDetails/UI/widgets/comments.dart';
import 'package:app/views/productDetails/UI/widgets/rating.dart';
import 'package:app/views/productDetails/logic/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController feedBackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRate(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is AddOrupdateRateSuccessState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => widget));
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: customAppBar(context, widget.product.productName ?? ''),
            body: state is GetRatesLoadingState ||
                    state is AddCommentLoadingState
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CashedLoadingWidget(
                                imageUrl: widget.product.imageUrl),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  widget.product.productName ?? 'Product Name'),
                              Text(widget.product.price ?? ''),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text('${cubit.avrage}'),
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                              child: Text(widget.product.description ??
                                  'Product Description')),
                          Rating(
                            rate: cubit.userRate.toDouble(),
                            onRatingUpdate: (rating) {
                              cubit.addOrUpdateRate(
                                  productId: widget.product.productId!,
                                  data: {
                                    "rates": rating.toInt(),
                                    "user_id": cubit.userId,
                                    "product_id": widget.product.productId
                                  });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormFeild(
                            lableText: 'Enter Your Feed Back',
                            controller: feedBackController,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await context
                                      .read<LoginstateCubit>()
                                      .getData();
                                  await cubit.addComment(
                                      data: {
                                        "comment": feedBackController.text,
                                        "user_id": cubit.userId,
                                        "product_id": widget.product.productId,
                                        // ignore: use_build_context_synchronously
                                        "user_name": context
                                                .read<LoginstateCubit>()
                                                .userModule
                                                ?.name ??
                                            'User Name',
                                      },
                                      productId: widget.product.productId!,
                                      userId: cubit.userId);

                                  feedBackController.clear();
                                },
                                icon: const Icon(Icons.send)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Comments',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Comments(
                            productModel: widget.product,
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    feedBackController.dispose();
    super.dispose();
  }
}
