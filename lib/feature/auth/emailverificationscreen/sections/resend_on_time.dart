import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salon_flutter/uikit/colors/app_colors.dart';

class ResendOnTime extends StatefulWidget {
  final VoidCallback onResendPressed;
  final int countdownSeconds;

  const ResendOnTime({
    Key? key,
    required this.onResendPressed,
    this.countdownSeconds = 180,
  }) : super(key: key);

  @override
  _ResendOnTimeState createState() => _ResendOnTimeState();
}

class _ResendOnTimeState extends State<ResendOnTime> {
  late Timer _timer;
  int _remainingSeconds = 0;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
    _remainingSeconds = widget.countdownSeconds;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer.cancel();
      }
    });
  }

  void _handleResend() {
    if (_canResend) {
      _startTimer();
      widget.onResendPressed();
    }
  }

  String _formatTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      alignment: Alignment.centerRight, // Выравнивание по правому краю
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end, // Контент справа
        children: [
          if (!_canResend)
          // Во время отсчета - текст справа
            Row(
              mainAxisSize: MainAxisSize.min, // Занимает только нужное место
              children: [
                Text(
                  "Повторная отправка через ",
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: 45,
                  alignment: Alignment.center,
                  child: Text(
                    _formatTime(),
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          else
          // Когда отсчет закончен - кнопка справа
            GestureDetector(
              onTap: _handleResend,
              child: Text(
                "Отправить код повторно",
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
