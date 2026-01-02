import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../uikit/colors/app_colors.dart';

class EnterEmailSection extends StatefulWidget{
  final TextEditingController emailController;

  const EnterEmailSection({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  _EnterEmailSection createState() => _EnterEmailSection();
}

class _EnterEmailSection extends State<EnterEmailSection> {
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();

    // Слушаем изменения фокуса и обновляем состояние

    _emailFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primaryBlue;
    final inactiveColor = Colors.grey[400];
    final hintInactiveColor = Colors.grey[500];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Поле Email
        _buildEmailField(primaryColor, inactiveColor, hintInactiveColor),
      ],
    );
    throw UnimplementedError();
  }

  //поле Email
  Widget _buildEmailField(
      Color primaryColor,
      Color? inactiveColor,
      Color? hintInactiveColor,
      ) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 54,
        child: TextField(
          controller: widget.emailController,
          focusNode: _emailFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: _emailFocusNode.hasFocus ? primaryColor : inactiveColor,
            ),
            hintText: "Email адрес",
            hintStyle: TextStyle(
              color:
              _emailFocusNode.hasFocus ? primaryColor : hintInactiveColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: _emailFocusNode.hasFocus ? primaryColor : inactiveColor!,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: _emailFocusNode.hasFocus ? primaryColor : inactiveColor!,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: primaryColor, width: 1.0),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
          ),
          onTap: () {
            // Вызываем setState через StatefulBuilder или другой метод
            // В StatelessWidget мы не можем вызвать setState
            // Это нужно обрабатывать в родительском виджете
          },
        ),
      ),
    );
  }
}
