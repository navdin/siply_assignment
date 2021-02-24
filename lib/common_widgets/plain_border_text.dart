import 'package:flutter/material.dart';

class PlainBorderText extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color backColor;
  final Color borderColor;
  final double height;
  final double width;

  PlainBorderText(
      {this.title,
      this.style,
      this.backColor = const Color.fromRGBO(13, 37, 63, 1),
      this.borderColor = Colors.white,
      this.height,
      this.width});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(4),
        height: height,
        width: width,
        color: backColor ?? Color.fromRGBO(13, 37, 63, 1),
        child: Center(
          child: Text(
            title,
            style: style ?? TextStyle(color: Colors.white),
          ),
        ),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, border: Border.all(color: borderColor)),
    );
  }
}
