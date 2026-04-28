import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? lineColor;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;
  final double lineThickness;

  const OrDivider({
    Key? key,
    this.text = "or",
    this.textColor,
    this.lineColor,
    this.fontSize = 16.0,
    this.verticalPadding = 24.0,
    this.horizontalPadding = 16.0,
    this.lineThickness = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = this.textColor ?? Colors.black;
    final lineColor = this.lineColor ?? Colors.grey[300];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: lineColor,
              thickness: lineThickness,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: lineColor,
              thickness: lineThickness,
            ),
          ),
        ],
      ),
    );
  }
}