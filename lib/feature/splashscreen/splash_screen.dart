import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/sizes/app_sizes.dart';
import 'package:salon_flutter/uikit/strings/AppStrings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showMainContent = false;

  @override
  void initState() {
    super.initState();
    // Переход на главную страницу через 1 секунды
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showMainContent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue, // тёмно-синий цвет
      body: Center(
        child: showMainContent ? AnimationFrame() : const SizedBox.shrink(),
      ),
    );
  }
}

class AnimationFrame extends StatefulWidget {
  const AnimationFrame({super.key});

  @override
  _AnimationFrameState createState() => _AnimationFrameState();
}

class _AnimationFrameState extends State<AnimationFrame>
    with TickerProviderStateMixin {
  late AnimationController _controllerStudiya;
  late Animation<double> _animationStudiya;

  late AnimationController _controllerPavla;
  late Animation<double> _animationPavla;

  late AnimationController _controllerFrame;
  late Animation<double> _animationFrame;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimation();
  }

  void _initializeAnimations() {
    //Анимация для плавного появления рамки
    _controllerFrame = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animationFrame = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controllerFrame, curve: Curves.easeIn));

    // Анимация для слова "Студия" сверху вниз
    _controllerStudiya = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationStudiya = Tween<double>(begin: -50, end: 10.0).animate(
      CurvedAnimation(parent: _controllerStudiya, curve: Curves.easeOut),
    );

    // Анимация для слова "Павла Ярошенко" снизу вверх
    _controllerPavla = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animationPavla = Tween<double>(
      begin: 150.0,
      end: 50.0,
    ).animate(CurvedAnimation(parent: _controllerPavla, curve: Curves.easeOut));
  }

  Future<void> _startAnimation() async {
    // Запускаем все анимации одновременно
    _controllerFrame.forward();
    _controllerStudiya.forward();
    _controllerPavla.forward();
  }

  @override
  void dispose() {
    _controllerStudiya.dispose();
    _controllerPavla.dispose();
    _controllerFrame.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _animationFrame,
        _animationStudiya,
        _animationPavla,
      ]),
      builder: (context, child) {
        return Container(
          width: 250,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(_animationFrame.value),
              width: 2,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Stack(
            children: [
              // "Студия" сверху вниз
              _buildAnimatedText(
                text: AppStrings.studio,
                top: _animationStudiya.value,
                opacity: _controllerStudiya.value,
              ),
              // "Павла Ярошенко" снизу вверх
              _buildAnimatedText(
                text: AppStrings.pavlaYaroshenko,
                top: _animationPavla.value,
                opacity: _controllerPavla.value,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText({
    required String text,
    required double top,
    required double opacity,
  }) {
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: Center(
        child: Opacity(
          opacity: opacity,
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: AppSizes.textFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
