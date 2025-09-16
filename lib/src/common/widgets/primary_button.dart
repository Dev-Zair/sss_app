import 'package:flutter/material.dart';
import 'package:sss_app/src/common/styles/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
    this.child,
  });

  final String? text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isEnabled && !isLoading) ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? color : color.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.transparent,
      ),
      child: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : child ?? Text(text ?? 'Button', style: TextStyle(color: textColor)),
    );
  }
}
