
import 'package:flutter/material.dart';

import '../model/user_detail_model.dart';
import '../resources/cloudfirestore_medhods.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
