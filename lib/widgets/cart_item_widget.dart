
import 'package:amazon_plaza/widgets/custom_simple_rounded_button_.dart';
import 'package:amazon_plaza/widgets/custom_square_buttom.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../resources/cloudfirestore_medhods.dart';
import '../screens/product_screen.dart';
import '../utils/app_color.dart';
import '../utils/utils.dart';
import 'product_information_widget.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 1,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductScreen(productModel: product)),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(product.url),
                      ),
                    ),
                  ),
                  ProductInformationWidget(
                    productName: product.productName,
                    cost: product.cost,
                    sellerName: product.sellerName,
                  )
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Row(
              children: [
                CustomSquareButton(
                    child:  Icon(Icons.remove),
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40),
                CustomSquareButton(
                    child: const Text(
                      "0",
                      style: TextStyle(
                        color: activeCyanColor,
                      ),
                    ),
                    onPressed: () {
                      
                    },
                    color: Colors.white,
                    dimension: 40),
                CustomSquareButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      await CloudFirestoreClass().addProductToCart(
                          productModel: ProductModel(
                              url: product.url,
                              productName: product.productName,
                              cost: product.cost,
                              discount: product.discount,
                              uid: Utils().getUid(),
                              sellerName: product.sellerName,
                              sellerUid: product.sellerUid,
                              rating: product.rating,
                              noOfRating: product.noOfRating));
                    },
                    color: backgroundColor,
                    dimension: 40),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                          onPressed: () async {
                            CloudFirestoreClass()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          text: "Delete"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(color: activeCyanColor, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}