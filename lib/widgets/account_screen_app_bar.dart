
import 'package:amazon_plaza/screens/search_screen.dart';
import 'package:amazon_plaza/utils/app_color.dart';
import 'package:amazon_plaza/utils/constants.dart';
import 'package:amazon_plaza/utils/utils.dart';
import 'package:flutter/material.dart';


class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    
    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Image.network(
              amazonLogoUrl,
              height: kAppBarHeight * 0.8,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.brown,
                ),
              ),
              IconButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen(),),);
                },
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
