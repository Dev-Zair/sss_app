import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/app_colors.dart';

enum InputFieldType { string, integer, doubleType, numType, phoneKz }

/// +7 (XXX) XXX XX XX formatlovchi formatter
class KzPhoneTextInputFormatter extends TextInputFormatter {
  static final _digitsOnly = RegExp(r'\d+');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Faqat raqamlarni olamiz
    final digits = StringBuffer();
    for (final m in _digitsOnly.allMatches(newValue.text)) {
      digits.write(m.group(0));
    }
    var raw = digits.toString();

    // 8 bilan boshlangan bo'lsa - 7 ga almashtiramiz
    if (raw.isNotEmpty && raw[0] == '8') {
      raw = '7${raw.substring(1)}';
    }
    // Boshi doimo 7 bo'lsin (mamlakat kodi)
    if (raw.isEmpty) raw = '7';
    if (raw[0] != '7') raw = '7${raw.substring(1)}';

    // Maks 11 ta raqam: 7 XXX XXX XX XX
    if (raw.length > 11) raw = raw.substring(0, 11);

    // Format: +7 (XXX) XXX XX XX
    final buf = StringBuffer('+7 ');
    final rest = raw.substring(1); // country code ni olib tashladik

    if (rest.isNotEmpty) {
      buf.write('(');
      buf.write(rest.substring(0, rest.length.clamp(0, 3)));
      if (rest.length >= 3) buf.write(') ');
    }
    if (rest.length > 3) {
      buf.write(rest.substring(3, rest.length.clamp(3, 6)));
      if (rest.length >= 6) buf.write(' ');
    }
    if (rest.length > 6) {
      buf.write(rest.substring(6, rest.length.clamp(6, 8)));
      if (rest.length >= 8) buf.write(' ');
    }
    if (rest.length > 8) {
      buf.write(rest.substring(8, rest.length.clamp(8, 10)));
    }

    final formatted = buf.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class SimpleTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLength;
  final InputFieldType type;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final List<String>? autofillHints;
  final int? maxLines;
  final bool enabled;
  final bool autofocus;

  const SimpleTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.maxLength,
    this.type = InputFieldType.string,
    this.isPassword = false,
    this.validator,
    this.autofillHints,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = false,
  });

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late final TextEditingController _controller;
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasText = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText.value = widget.isPassword;
    _hasText.value = _controller.text.isNotEmpty;

    // phoneKz bo'lsa boshlang'ich "+7 " ni qo'yib yuboramiz
    if (widget.type == InputFieldType.phoneKz && _controller.text.isEmpty) {
      _controller.text = '+7 ';
    }

    _controller.addListener(() {
      _hasText.value = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    _obscureText.dispose();
    _hasText.dispose();
    super.dispose();
  }

  TextInputType getKeyboardType() {
    switch (widget.type) {
      case InputFieldType.integer:
        return TextInputType.number;
      case InputFieldType.doubleType:
      case InputFieldType.numType:
        return const TextInputType.numberWithOptions(decimal: true);
      case InputFieldType.phoneKz:
        return TextInputType.phone;
      case InputFieldType.string:
        return widget.isPassword
            ? TextInputType.visiblePassword
            : TextInputType.text;
    }
  }

  List<TextInputFormatter>? getInputFormatters() {
    switch (widget.type) {
      case InputFieldType.integer:
        return [FilteringTextInputFormatter.digitsOnly];
      case InputFieldType.doubleType:
      case InputFieldType.numType:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,}$'))];
      case InputFieldType.phoneKz:
        return [KzPhoneTextInputFormatter()];
      case InputFieldType.string:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureText,
      builder: (context, isObscure, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: _hasText,
          builder: (context, hasText, _) {
            return FormField<String>(
              initialValue: _controller.text,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              builder: (field) {
                final showError = field.errorText != null;
                final iconColor = showError ? Colors.red : Colors.grey;

                return TextField(
                  autofocus: widget.autofocus,
                  enabled: widget.enabled,
                  maxLines: widget.maxLines,
                  autofillHints: widget.autofillHints,
                  controller: _controller,
                  obscureText: isObscure,
                  keyboardType: getKeyboardType(),
                  inputFormatters: getInputFormatters(),
                  // phoneKz uchun maxLength kerak emas — formatter o'zi cheklaydi
                  maxLength: widget.type == InputFieldType.phoneKz
                      ? null
                      : widget.maxLength,
                  onChanged: (val) => field.didChange(val),
                  decoration: InputDecoration(
                    labelText: widget.label,
                    hintText: widget.hintText,
                    errorText: field.errorText,
                    counterText: '',
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade400,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                        width: 1.5,
                      ),
                    ),
                    errorStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red.shade400,
                    ),
                    suffixIcon: widget.isPassword
                        ? IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: iconColor,
                              size: 20.sp,
                            ),
                            onPressed: () =>
                                _obscureText.value = !_obscureText.value,
                          )
                        : hasText && widget.enabled
                            ? IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: iconColor,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  _controller.clear();
                                  if (widget.type == InputFieldType.phoneKz) {
                                    _controller.text = '+7 ';
                                  }
                                  field.didChange(_controller.text);
                                },
                              )
                            : null,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}