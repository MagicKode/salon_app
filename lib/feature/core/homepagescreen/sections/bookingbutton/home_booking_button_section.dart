import 'package:flutter/material.dart';
import '../../../../../uikit/colors/app_colors.dart';

class HomeBookingButtonSection extends StatefulWidget {
  final VoidCallback onPressed;
  final ScrollController scrollController;

  const HomeBookingButtonSection({
    super.key,
    required this.onPressed,
    required this.scrollController,
  });

  @override
  State<HomeBookingButtonSection> createState() => _HomeBookingButtonSectionState();
}

class _HomeBookingButtonSectionState extends State<HomeBookingButtonSection> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant HomeBookingButtonSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_onScroll);
      widget.scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.position.pixels;
    final atBottom = (maxScroll - currentScroll) <= 100;
    if (atBottom != _expanded) {
      setState(() => _expanded = atBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        return SizedBox(
          height: 52,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: _expanded ? Alignment.center : Alignment.centerRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _expanded ? fullWidth : 150,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryBlue.withOpacity(0.85),
                    AppColors.primaryBlue.withOpacity(0.65),
                  ],
                ),
                borderRadius: BorderRadius.circular(_expanded ? 16 : 26),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    blurRadius: _expanded ? 12 : 6,
                    offset: Offset(0, _expanded ? 4 : 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(_expanded ? 16 : 26),
                  onTap: widget.onPressed,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _expanded ? 18 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                      child: const Text('Оставить заявку'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
