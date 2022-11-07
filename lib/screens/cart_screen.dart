import 'package:amazon_plaza/model/product_model.dart';
import 'package:amazon_plaza/model/user_detail_model.dart';
import 'package:amazon_plaza/resources/cloudfirestore_medhods.dart';
import 'package:amazon_plaza/utils/app_color.dart';
import 'package:amazon_plaza/utils/constants.dart';
import 'package:amazon_plaza/utils/utils.dart';
import 'package:amazon_plaza/widgets/cart_item_widget.dart';
import 'package:amazon_plaza/widgets/custom_main_button.dart';
import 'package:amazon_plaza/widgets/search_bar_widget.dart';
import 'package:amazon_plaza/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_details_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: false,
        isReadOnly: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomMainButton(
                              child: const Text(
                                'Loading',
                              ),
                              color: yellowColor,
                              isLoading: true,
                              onPressed: () {});
                        } else {
                          return CustomMainButton(
                              child: Text(
                                'Proceed to buy (${snapshot.data!.docs.length}) items',
                                style: TextStyle(color: Colors.black),
                              ),
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestoreClass().buyAllItemsInCart(
                                   userDetails:
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails
                                );
                                Utils().showSnackBar(
                                    context: context, content: 'Done');
                              });
                        }
                      },
                    )),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
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
                                ProductModel model =
                                    ProductModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return CartItemWidget(product: model);
                              });
                        }
                      }),
                )
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 5,
                //     itemBuilder: (context, indext) {
                //       return CartItemWidget(
                //         product: ProductModel(
                //           url:
                //               'https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png',
                //           productName: 'Dordoy Plaza',
                //           cost: 9999999999999,
                //           discount: 0,
                //           uid: 'super-onlayn',
                //           sellerName: 'Nurlan Abdyrakhmanov',
                //           sellerUid: '0555767676ttn',
                //           rating: 1,
                //           noOfRating: 1,
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
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
