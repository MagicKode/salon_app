import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class LoginFormSection extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> isPasswordVisible;

  const LoginFormSection({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
  }) : super(key: key);

  @override
  _LoginFormSectionState createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    // Слушаем изменения фокуса и обновляем состояние
    _emailFocusNode.addListener(() {
      setState(() {});
    });

    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
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
        // Поле Email
        _buildEmailField(primaryColor, inactiveColor, hintInactiveColor),

        SizedBox(height: 16.0),

        // Поле Password
        _buildPasswordField(primaryColor, inactiveColor, hintInactiveColor),
      ],
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
            hintText: "Email",
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
                hintText: "Password",
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
