import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_app/src/common/styles/app_colors.dart';
import 'package:sss_app/src/common/widgets/primary_button.dart';
import 'package:sss_app/src/common/widgets/simple_text_field.dart';

class ForGetPasswordScreen extends StatefulWidget {
  const ForGetPasswordScreen({super.key});

  @override
  State<ForGetPasswordScreen> createState() => _ForGetPasswordScreenState();
}

class _ForGetPasswordScreenState extends State<ForGetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/icon.png', height: 150),
            const Text(
              'Восстановление пароля',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),
            SimpleTextField(
              label: 'Номер телефона',
              type: InputFieldType.phoneKz,
              autofillHints: const [AutofillHints.telephoneNumber],
              autofocus: true,
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 53,
              width: double.infinity,
              child: PrimaryButton(onPressed: () {}, text: 'Отправить'),
            ),
            CupertinoButton(
              child: Text('Войти', style: TextStyle(color: AppColors.primary)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
