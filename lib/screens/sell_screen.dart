import 'package:amazon_plaza/providers/user_details_provider.dart';
import 'package:amazon_plaza/resources/cloudfirestore_medhods.dart';
import 'package:amazon_plaza/widgets/custom_main_button.dart';
import 'package:amazon_plaza/widgets/loading_widget.dart';
import 'package:amazon_plaza/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];
  //Expanded spaceThingy = Expanded(child: Container());

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 35),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                image == null
                                    ? Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT175bePHbmKjgNQNIix843Qk0gKTvWzZhhIQ&usqp=CAU',
                                        height: screenSize.height / 10,
                                      )
                                    : Image.memory(
                                        image!,
                                        height: screenSize.height / 10,
                                      ),
                                IconButton(
                                  onPressed: () async {
                                    Uint8List? temp = await Utils().pickImage();
                                    if (temp != null) {
                                      setState(() {
                                        image = temp;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.file_upload),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              height: screenSize.height * 0.9,
                              width: screenSize.width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                border:
                                    Border.all(color: Colors.grey, width: 3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFieldWidget(
                                      title: ' Name',
                                      obscureText: false,
                                      controller: nameController,
                                      hintText: 'Enter the name of the item'),
                                  TextFieldWidget(
                                      title: 'Cost',
                                      obscureText: false,
                                      controller: costController,
                                      hintText: 'Enter the name of the item'),
                                  const Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'none',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    leading: Radio(
                                      value: 1,
                                      activeColor: const Color(0xFF6200EE),
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(
                                          () {
                                            selected = i!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text(
                                      '70 %',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    leading: Radio(
                                      value: 2,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(
                                          () {
                                            selected = i!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text(
                                      '60 %',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    leading: Radio(
                                      value: 3,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(
                                          () {
                                            selected = i!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text(
                                      '50%',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    leading: Radio(
                                      value: 4,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(
                                          () {
                                            selected = i!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CustomMainButton(
                                child:  Text(
                                  'Sell',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                color: Colors.orange,
                                isLoading: isLoading,
                                onPressed: () async {
                                  String ouput = await CloudFirestoreClass()
                                      .uploadProductToDatabase(
                                    image: image,
                                    productName: nameController.text,
                                    rawCost: costController.text,
                                    discount: keysForDiscount[selected - 1],
                                    sellerName:
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails
                                            .name,
                                    sellerUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  );
                                  if (ouput == 'success') {
                                    Utils().showSnackBar(
                                        context: context,
                                        content: 'Posted Product');
                                  } else {
                                    Utils().showSnackBar(
                                        context: context, content: ouput);
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CustomMainButton(
                                child: const Text(
                                  'Beck',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                color: Colors.cyan,
                                isLoading: false,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }
}
//  const Text(
//                                     'Item details',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 24,
//                                       color: Colors.black,
//                                     ),
//                                   ),
