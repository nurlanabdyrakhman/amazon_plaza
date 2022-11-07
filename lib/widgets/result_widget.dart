import 'package:amazon_plaza/screens/product_screen.dart';
import 'package:amazon_plaza/utils/app_color.dart';
import 'package:amazon_plaza/widgets/cost_widget.dart';
import 'package:amazon_plaza/widgets/reting_star_widget.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utils/utils.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(productModel: product),),);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(
                product.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                      child: RatingStatWidget(
                        rating: product.rating,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      product.noOfRating.toString(),
                      style: const TextStyle(color: activeCyanColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  color: Colors.red,
                  cost: product.cost,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
