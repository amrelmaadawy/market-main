import 'package:app/core/shimmer/shimmer_product_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeView extends StatelessWidget {
  const ShimmerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade500,
                    highlightColor: Colors.grey.shade300,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(itemBuilder: (context,index)
                    {
                      return CircleAvatar( radius: 30,
                      backgroundColor: Colors.white,
                      );
                      
                    }, 
                    separatorBuilder: (context, index) => SizedBox(width: 20,),
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    ),
                  ),
                  ListView.builder(itemBuilder: (context, index) {
                    return ShimmerProductItem();
                  },
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}
