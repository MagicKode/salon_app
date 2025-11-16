import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';
import 'package:salon_flutter/uikit/strings/AppStrings.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingPages = [
    {
      AppStrings.image: AppStrings.imageAddressFirst,
      AppStrings.imageTitle: AppStrings.titleFirst,
      AppStrings.imageDescription: AppStrings.descriptionFirst,
    },
    {
      AppStrings.image: AppStrings.imageAddressSecond,
      AppStrings.imageTitle: AppStrings.titleSecond,
      AppStrings.imageDescription: AppStrings.descriptionSecond,
    },
    {
      AppStrings.image: AppStrings.imageAddressThird,
      AppStrings.imageTitle: AppStrings.titleThird,
      AppStrings.imageDescription: AppStrings.descriptionThird,
    },
    {
      AppStrings.image: AppStrings.imageAddressFourth,
      AppStrings.imageTitle: AppStrings.titleFourth,
      AppStrings.imageDescription: AppStrings.descriptionFourth,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children:
                onboardingPages.map((page) {
                  return Stack(
                    children: [
                      // Фон - картинка
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(page['image'], fit: BoxFit.cover),
                      ),

                      // Градиент для лучшей читаемости текста
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            stops: [0.4, 0.9],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),

          // Текст поверх картинки
          Positioned(
            bottom: 300,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  onboardingPages[_currentPage][AppStrings.imageTitle],
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  onboardingPages[_currentPage][AppStrings.imageDescription],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Индикатор точек
          Positioned(
            top: MediaQuery.of(context).padding.bottom + 600,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(onboardingPages.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),

          // Кнопка далее
          Positioned(
            bottom: 150,
            right: 24,
            left: 24,
            child: _buildCustomFloatingButton(),
          ),

          // Строка "Уже есть аккаунт?" и кнопка "Войти"
          Positioned(
            bottom: 70,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.alreadyHaveAnAccount,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(width: 2),
                TextButton(
                  onPressed: _login,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    AppStrings.signIn,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomFloatingButton() {
    final isLastPage = _currentPage == onboardingPages.length - 1;
    final isThirdPage = _currentPage == 2; // 3я картинка (индекс 2)
    final isSecondPage = _currentPage == 1; // 3я картинка (индекс 2)
    final isFirstPage = _currentPage == 0; // 3я картинка (индекс 2)

    String buttonText;
    if (isLastPage) {
      buttonText = AppStrings.signInWithEmail;
    } else if (isThirdPage) {
      buttonText = AppStrings.getStarted;
    } else {
      buttonText = AppStrings.next;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.primaryButtonColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: _nextPage,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Центрируем текст
              children: [
                if (isLastPage)
                  Icon(Icons.email, color: Colors.white, size: 20),
                if (isLastPage)
                  SizedBox(width: 8),
                Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _login() {
    // Навигация на экран входа
    print('Переход на экран входа');
    // Navigator.pushNamed(context, '/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
