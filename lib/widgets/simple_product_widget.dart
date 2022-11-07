import 'package:amazon_plaza/model/product_model.dart';
import 'package:amazon_plaza/screens/product_screen.dart';
import 'package:flutter/material.dart';

class SimpleProductWidget extends StatelessWidget {
  final ProductModel productModel;
 
  const SimpleProductWidget({super.key,  required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductScreen(productModel: productModel),),);
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.network(productModel.url),
          ),
        ),
      ),
    );
  }
}
