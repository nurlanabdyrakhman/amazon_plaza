import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final obscureText;
  const TextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    this.obscureText,
    required this.hintText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode focusNode;
  bool isInFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isInFocus = true;
        });
      } else {
        setState(() {
          isInFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.blue,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              isInFocus
                  ? BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  : BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
            ],
          ),
          child: TextField(
            focusNode: focusNode,
            obscureText: widget.obscureText,
            controller: widget.controller,
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Colors.brown.withOpacity(0.6),
              filled: true,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.cyan,
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
