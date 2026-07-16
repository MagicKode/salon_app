import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_buttons_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/create_account_validator.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/sign_in_section.dart';
import 'package:salon_flutter/feature/auth/createaccountscreen/sections/term_and_privacy.dart';
import 'package:salon_flutter/uikit/strings/app_strings.dart';

import '../../../config/theme/custom_colors.dart';
import '../../../uikit/widgets/welcome/welcome_section.dart';
import '../../navigation/main_navigation_screen.dart';
import '../authblock/bloc/auth_block.dart';
import '../authblock/bloc/auth_event.dart';
import '../authblock/bloc/auth_state.dart';

class CreateAccountBody extends StatefulWidget {
  const CreateAccountBody({super.key});

  @override
  State<CreateAccountBody> createState() => _CreateAccountBodyState();
}

class _CreateAccountBodyState extends State<CreateAccountBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  bool _nameTouched = false;
  bool _emailTouched = false;
  bool _phoneTouched = false;
  bool _passwordTouched = false;

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        _nameTouched = true;
        _validateName();
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _emailTouched = true;
        _validateEmail();
      }
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        _phoneTouched = true;
        _validatePhone();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _passwordTouched = true;
        _validatePassword();
      }
    });
  }

  void _validateName() {
    if (!_nameTouched && _nameError == null) return;
    final error = CreateAccountValidator.validateName(_nameController.text);
    setState(() {
      _nameError = error;
    });
  }

  void _validateEmail() {
    if (!_emailTouched && _emailError == null) return;
    final error = CreateAccountValidator.validateEmail(_emailController.text);
    setState(() {
      _emailError = error;
    });
  }

  void _validatePhone() {
    if (!_phoneTouched && _phoneError == null) return;
    final error = CreateAccountValidator.validatePhone(
      _mobileNumberController.text,
    );
    setState(() {
      _phoneError = error;
    });
  }

  void _validatePassword() {
    if (!_passwordTouched && _passwordError == null) return;
    final error = CreateAccountValidator.validatePassword(
      _passwordController.text,
    );
    setState(() {
      _passwordError = error;
    });
  }

  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _mobileNumberController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _passwordError == null;
  }

  void _dispatchRegisterEvent() {
    _nameTouched = true;
    _emailTouched = true;
    _phoneTouched = true;
    _passwordTouched = true;
    _validateName();
    _validateEmail();
    _validatePhone();
    _validatePassword();

    if (!_isFormValid()) {
      _showError('Пожалуйста, заполните все поля корректно');
      return;
    }

    context.read<AuthBloc>().add(
      AuthRegisterRequested(
        phoneNumber: _mobileNumberController.text.trim(),
        password: _passwordController.text.trim(),
        firstName: _nameController.text.trim(),
        email: _emailController.text.trim(),
      ),
    );
  }

  void _showError(String message) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colors.textOnPrimary)),
        backgroundColor: colors.statusError,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
            (route) => false,
          );
        }
        if (state is AuthFailure) {
          _showError(state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeSection(
                      title: AppStrings.registerTitle,
                      subtitle: AppStrings.registerSubtitle,
                    ),
                    const SizedBox(height: 38.0),
                    CreateAccountSection(
                      nameController: _nameController,
                      emailController: _emailController,
                      mobileController: _mobileNumberController,
                      passwordController: _passwordController,
                      isPasswordVisible: _isPasswordVisible,
                      nameError: _nameError,
                      emailError: _emailError,
                      phoneError: _phoneError,
                      passwordError: _passwordError,
                      nameFocusNode: _nameFocusNode,
                      emailFocusNode: _emailFocusNode,
                      phoneFocusNode: _phoneFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                    ),
                    const SizedBox(height: 12.0),
                    TermsAndPrivacy(
                      onTermAndPrivacyPressed: _onTermAndPrivacyPressed,
                    ),
                    const SizedBox(height: 48.0),
                    CreateAccountButtonsSection(
                      isLoading: state is AuthLoading,
                      onRegisterPressed: _dispatchRegisterEvent,
                    ),
                    const SizedBox(height: 12.0),
                    SignInSection(onSignInPressed: _signIn),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTermAndPrivacyPressed() {}

  void _signIn() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
