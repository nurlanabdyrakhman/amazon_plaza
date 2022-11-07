import 'package:amazon_plaza/utils/constants.dart';
import 'package:amazon_plaza/widgets/category_widget.dart';
import 'package:amazon_plaza/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2 / 3.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: categoriesList.length,
          itemBuilder: (context,index)=>CategoryWidget(index: index),
        ),
      ),
    );
  }
}
