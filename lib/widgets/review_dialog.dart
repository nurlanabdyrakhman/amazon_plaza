import 'package:amazon_plaza/model/review_model.dart';
import 'package:amazon_plaza/model/user_detail_model.dart';
import 'package:amazon_plaza/providers/user_details_provider.dart';
import 'package:amazon_plaza/resources/cloudfirestore_medhods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({super.key, required this.productUid});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Type a review for this product!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      submitButtonText: 'Send',
      commentHint: 'Type here',

      onSubmitted: (RatingDialogResponse res) async {
        CloudFirestoreClass().uploadReviewToDatabase(
          productUid: productUid,
          model: ReviewModel(
            senderName: Provider.of<UserDetailsProvider>(context, listen: false)
                .userDetails
                .name,
            description: res.comment,
            rating: res.rating.toInt(),
          ),
        );
      },
    );
  }
}
