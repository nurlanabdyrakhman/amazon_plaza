import 'dart:html';

import 'package:amazon_plaza/utils/app_color.dart';
import 'package:amazon_plaza/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInformationWidget({
    super.key,
    required this.productName,
    required this.cost,
    required this.sellerName,
  });
 

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
     SizedBox spaceThingy = const SizedBox(
    height: 7,
  );
    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productName,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.9,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: CostWidget(
                color: Colors.black,
                cost: cost,
              ),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Sold by ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: sellerName,
                    style: const TextStyle(
                      color: activeCyanColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
