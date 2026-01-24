import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../uikit/colors/app_colors.dart';

class CodeEnterSection extends StatefulWidget {
  final TextEditingController codeController;
  final int codeLength; // Длина кода (по умолчанию 4)

  const CodeEnterSection({
    Key? key,
    required this.codeController,
    this.codeLength = 4,
  }) : super(key: key);

  @override
  _CodeEnterSection createState() => _CodeEnterSection();
}

class _CodeEnterSection extends State<CodeEnterSection> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  late List<String> _codeDigits;
  late List<GlobalKey> _fieldKeys = [];

  @override
  void initState() {
    super.initState();
    _initCodeFields();
    widget.codeController.addListener(_updateParentController);
  }

  void _initCodeFields() {
    _focusNodes = List.generate(widget.codeLength, (index) => FocusNode());
    _controllers = List.generate(
      widget.codeLength,
      (index) => TextEditingController(),
    );
    _codeDigits = List.filled(widget.codeLength, '');
    _fieldKeys = List.generate(widget.codeLength, (index) => GlobalKey());

    // Настройка слушателей фокуса
    for (int i = 0; i < widget.codeLength; i++) {
      _focusNodes[i].addListener(() {
        setState(() {});
      });

      _controllers[i].addListener(() {
        _onDigitChanged(i);
      });
    }
  }

  void _onDigitChanged(int index) {
    String text = _controllers[index].text;

    if (text.length > 1) {
      // Если введено больше одного символа, оставляем только последний
      _controllers[index].text = text.substring(text.length - 1);
      _codeDigits[index] = _controllers[index].text;
    } else if (text.isNotEmpty) {
      _codeDigits[index] = text;

      // Автоматически переходим к следующему полю
      if (index < widget.codeLength - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        // Если это последнее поле, убираем фокус
        _focusNodes[index].unfocus();
      }
    } else {
      _codeDigits[index] = '';
    }

    _updateParentController();
  }


  void _updateParentController() {
    String fullCode = _codeDigits.join('');
    widget.codeController.text = fullCode;
  }

  Widget _buildCodeField(
    int index,
    Color primaryColor,
    Color? inactiveColor,
    Color? hintInactiveColor,
  ) {
    return Container(
      key: _fieldKeys[index],
      width: 60,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focusNodes[index].hasFocus ? primaryColor : inactiveColor!,
          width: _focusNodes[index].hasFocus ? 2 : 1,
        ),
        color:
            _focusNodes[index].hasFocus
                ? primaryColor.withOpacity(0.05)
                : Colors.transparent,
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _focusNodes[index].hasFocus ? primaryColor : Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintStyle: TextStyle(fontSize: 30, color: hintInactiveColor),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            // Обработка ввода
            if (value.isNotEmpty && index < widget.codeLength - 1) {
              // Автопереход уже в _onDigitChanged
            }
          },
          onSubmitted: (value) {
            if (index < widget.codeLength - 1) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index].unfocus();
            }
          },
          onTap: () {
            // При тапе на поле выделяем весь текст
            _controllers[index].selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controllers[index].text.length,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    widget.codeController.removeListener(_updateParentController);
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
        // Заголовок или описание (опционально)
        SizedBox(height: 8),

        // Контейнер с полями ввода кода
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.codeLength,
              (index) => _buildCodeField(
                index,
                primaryColor,
                inactiveColor,
                hintInactiveColor,
              ),
            ),
          ),
        ),

        // Скрытое поле для хранения полного кода (опционально, для совместимости)
        SizedBox(height: 8),
        Opacity(
          opacity: 0,
          child: TextField(controller: widget.codeController, enabled: false),
        ),
      ],
    );
  }
}
