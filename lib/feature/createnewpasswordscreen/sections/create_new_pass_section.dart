import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../uikit/colors/app_colors.dart';

class CreateNewPassSection extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;

  const CreateNewPassSection({
    Key? key,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
  }) : super(key: key);

  @override
  _CreateNewPassSection createState() => _CreateNewPassSection();
}

class _CreateNewPassSection extends State<CreateNewPassSection> {
  late FocusNode _newPasswordFocusNode;
  late FocusNode _confirmNewPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusNode = FocusNode();

    // Слушаем изменения фокуса и обновляем состояние
    _newPasswordFocusNode.addListener(() {
      setState(() {});
    });

    _confirmNewPasswordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
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
        // Поле Password
        _buildNewPasswordField(primaryColor, inactiveColor, hintInactiveColor),

        SizedBox(height: 16.0),

        // Поле Email
        _buildConfirmNewEmailField(
          primaryColor,
          inactiveColor,
          hintInactiveColor,
        ),
      ],
    );
    throw UnimplementedError();
  }

  //поле NewPassword
  Widget _buildNewPasswordField(
    Color primaryColor,
    Color? inactiveColor,
    Color? hintInactiveColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 54,
        child: TextField(
          controller: widget.newPasswordController,
          focusNode: _newPasswordFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color:
                  _newPasswordFocusNode.hasFocus ? primaryColor : inactiveColor,
            ),
            hintText: "Новый пароль",
            hintStyle: TextStyle(
              color:
                  _newPasswordFocusNode.hasFocus
                      ? primaryColor
                      : hintInactiveColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color:
                    _newPasswordFocusNode.hasFocus
                        ? primaryColor
                        : inactiveColor!,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color:
                    _newPasswordFocusNode.hasFocus
                        ? primaryColor
                        : inactiveColor!,
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

  //поле confirmNewPassword
  Widget _buildConfirmNewEmailField(
    Color primaryColor,
    Color? inactiveColor,
    Color? hintInactiveColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 54,
        child: TextField(
          controller: widget.confirmNewPasswordController,
          focusNode: _confirmNewPasswordFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color:
                  _confirmNewPasswordFocusNode.hasFocus
                      ? primaryColor
                      : inactiveColor,
            ),
            hintText: "Подтвердите новый пароль",
            hintStyle: TextStyle(
              color:
                  _confirmNewPasswordFocusNode.hasFocus
                      ? primaryColor
                      : hintInactiveColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color:
                    _confirmNewPasswordFocusNode.hasFocus
                        ? primaryColor
                        : inactiveColor!,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color:
                    _confirmNewPasswordFocusNode.hasFocus
                        ? primaryColor
                        : inactiveColor!,
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
