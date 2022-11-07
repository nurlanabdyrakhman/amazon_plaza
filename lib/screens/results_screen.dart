import 'package:amazon_plaza/widgets/loading_widget.dart';
import 'package:amazon_plaza/widgets/result_widget.dart';
import 'package:amazon_plaza/widgets/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ResultScreen extends StatelessWidget {
  final query;
  const ResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Showing results for',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: query,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3.3,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('products')
                        .where('productName', isEqualTo: query)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snopshot) {
                      if (snopshot.connectionState == ConnectionState.waiting) {
                        return LoadingWidget();
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2 / 3.5),
                            itemCount: snopshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ProductModel product =
                                  ProductModel.getModelFromJson(
                                json: snopshot.data!.docs[index].data(),
                              );
                              return ResultWidget(product: product);
                            });
                      }
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
