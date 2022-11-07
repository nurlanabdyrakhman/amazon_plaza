import 'package:flutter/material.dart';

class RatingStatWidget extends StatelessWidget {
  final int rating;
  const RatingStatWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < 5; i++) {
      children.add(
        i < rating
            ? const Icon(
                Icons.star,
                color: Colors.teal,
              )
            : Icon(
                Icons.star_border,
                color: Colors.purple,
              ),
      );
    }
    return Row(
      children: children,
    );
  }
}
