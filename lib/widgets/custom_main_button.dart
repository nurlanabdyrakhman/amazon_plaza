import 'package:amazon_plaza/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  CustomMainButton({
    super.key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(screenSize.width * 0.5, 40),
      ),
      onPressed: onPressed,
      child: !isLoading
          ? child
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: AspectRatio(
                aspectRatio: 1/1,
                child: CircularProgressIndicator(
                  color: Colors.brown,
                ),
              )),
    );
  }
}
