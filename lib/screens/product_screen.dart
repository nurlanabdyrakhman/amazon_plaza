import 'package:amazon_plaza/model/product_model.dart';
import 'package:amazon_plaza/model/review_model.dart';
import 'package:amazon_plaza/resources/cloudfirestore_medhods.dart';
import 'package:amazon_plaza/utils/app_color.dart';
import 'package:amazon_plaza/utils/constants.dart';
import 'package:amazon_plaza/widgets/cost_widget.dart';
import 'package:amazon_plaza/widgets/custom_main_button.dart';
import 'package:amazon_plaza/widgets/custom_simple_rounded_button_.dart';
import 'package:amazon_plaza/widgets/reting_star_widget.dart';
import 'package:amazon_plaza/widgets/review_dialog.dart';
import 'package:amazon_plaza/widgets/review_widget.dart';
import 'package:amazon_plaza/widgets/search_bar_widget.dart';
import 'package:amazon_plaza/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_detail_model.dart';
import '../providers/user_details_provider.dart';
import '../utils/utils.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({super.key, required this.productModel});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceThingy = Expanded(
    child: Container(),
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height:
                          screenSize.height + (kAppBarHeight - (kAppBarHeight)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.productModel.sellerName,
                                        style: const TextStyle(
                                          color: activeCyanColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      widget.productModel.productName,
                                      // style: const TextStyle(
                                      //   color: activeCyanColor,
                                      //   fontSize: 15,
                                      // ),
                                    ),
                                  ],
                                ),
                                RatingStatWidget(
                                    rating: widget.productModel.rating),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: screenSize.height / 3,
                              constraints: BoxConstraints(
                                  maxHeight: screenSize.height / 3),
                              child: Image.network(widget.productModel.url),
                            ),
                          ),
                          spaceThingy,
                          CostWidget(
                              color: Colors.black,
                              cost: widget.productModel.cost),
                          spaceThingy,
                          CustomMainButton(
                            child: Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.orange,
                            isLoading: false,
                            onPressed: () async {
                          await CloudFirestoreClass().addProductToOrders(
                                  model: widget.productModel,
                                  userDetails: 
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails
                                  
                                  );
                              Utils().showSnackBar(
                                  context: context, content: 'Done');
                            },
                          ),
                          spaceThingy,
                          CustomMainButton(
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.yellow,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFirestoreClass().addProductToCart(
                                  productModel: widget.productModel);
                              Utils().showSnackBar(
                                  context: context, content: 'added to cart');
                            },
                          ),
                          spaceThingy,
                          CustomSimpleRoundedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(
                                  productUid: widget.productModel.uid,
                                ),
                              );
                            },
                            text: 'Add a review for this product',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.productModel.uid)
                            .collection('reviews')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ReviewModel model =
                                      ReviewModel.getModelFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data());
                                  return ReviewWidget(review: model);
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
