import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../uikit/colors/app_colors.dart';

class CreateAccountSection extends StatefulWidget{
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;

  const CreateAccountSection({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
    required this.isPasswordVisible,
  }) : super(key: key);

  @override
  _CreateAccountSection createState() => _CreateAccountSection();
}

class _CreateAccountSection extends State<CreateAccountSection> {
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _mobileFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _mobileFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    // Слушаем изменения фокуса и обновляем состояние
    _nameFocusNode.addListener(() {
      setState(() {});
    });

    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _mobileFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileFocusNode.dispose();
    _passwordFocusNode.dispose();
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
        // Поле Name
        _buildNamelField(primaryColor, inactiveColor, hintInactiveColor),

        SizedBox(height: 16.0),

        // Поле Email
        _buildEmailField(primaryColor, inactiveColor, hintInactiveColor),

        SizedBox(height: 16.0),

        // Поле Mobile
        _buildMobileField(primaryColor, inactiveColor, hintInactiveColor),

        SizedBox(height: 16.0),

        // Поле Password
        _buildPasswordField(primaryColor, inactiveColor, hintInactiveColor),
      ],
    );
    throw UnimplementedError();
  }

  //поле Name
  Widget _buildNamelField(
      Color primaryColor,
      Color? inactiveColor,
      Color? hintInactiveColor,
      ) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 54,
        child: TextField(
          controller: widget.nameController,
          focusNode: _nameFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: _nameFocusNode.hasFocus ? primaryColor : inactiveColor,
            ),
            hintText: "Имя",
            hintStyle: TextStyle(
              color:
              _nameFocusNode.hasFocus ? primaryColor : hintInactiveColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: _nameFocusNode.hasFocus ? primaryColor : inactiveColor!,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: _nameFocusNode.hasFocus ? primaryColor : inactiveColor!,
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

  //поле Mobile    //todo сделать логику и выпадающий список стран с кодами (если надо будет)
  Widget _buildMobileField(
      Color primaryColor,
      Color? inactiveColor,
      Color? hintInactiveColor,
      ) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 54,
        child: TextField(
          controller: widget.mobileController,
          focusNode: _mobileFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone,
              color: _mobileFocusNode.hasFocus ? primaryColor : inactiveColor,
            ),
            hintText: "Телефон",
            hintStyle: TextStyle(
              color:
              _mobileFocusNode.hasFocus ? primaryColor : hintInactiveColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: _mobileFocusNode.hasFocus ? primaryColor : inactiveColor!,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: _mobileFocusNode.hasFocus ? primaryColor : inactiveColor!,
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

  //поле Password
  Widget _buildPasswordField(
      Color primaryColor,
      Color? inactiveColor,
      Color? hintInactiveColor,
      ) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
        height: 54,
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.isPasswordVisible,
          builder: (context, isVisible, child) {
            return TextField(
              controller: widget.passwordController,
              focusNode: _passwordFocusNode,
              obscureText: !isVisible,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color:
                  _passwordFocusNode.hasFocus
                      ? primaryColor
                      : inactiveColor,
                ),
                hintText: "Пароль",
                hintStyle: TextStyle(
                  color:
                  _passwordFocusNode.hasFocus
                      ? primaryColor
                      : hintInactiveColor,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color:
                    _passwordFocusNode.hasFocus
                        ? primaryColor
                        : inactiveColor,
                  ),
                  onPressed: () {
                    widget.isPasswordVisible.value =
                    !widget.isPasswordVisible.value;
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(
                    color:
                    _passwordFocusNode.hasFocus
                        ? primaryColor
                        : inactiveColor!,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(
                    color:
                    _passwordFocusNode.hasFocus
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
                // Обработка в родительском виджете
              },
            );
          },
        ),
      ),
    );
  }


}