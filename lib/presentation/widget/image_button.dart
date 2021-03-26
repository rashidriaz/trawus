import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final Function onPressed;
  final String caption;
  final String imageUrl;

  const ImageButton({this.onPressed, this.imageUrl, this.caption});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            caption,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
            ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(18),
      ),
    );
  }
}
