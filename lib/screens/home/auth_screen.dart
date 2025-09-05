import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_app/screens/home/for_get_password_screen.dart';
import 'package:sss_app/src/common/styles/app_colors.dart';
import 'package:sss_app/src/common/widgets/primary_button.dart';
import 'package:sss_app/src/common/widgets/simple_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // tugma klaviatura ostida qolmasligi uchun ruxsat beramiz
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // klaviaturani yopish
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return SingleChildScrollView(
                // klaviatura chiqsa pastdan joy ochamiz
                padding: EdgeInsets.only(bottom: bottomInset + 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),

                            // MARKAZ
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/icon.png',
                                    height: 150,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Войти в SSS group',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const SimpleTextField(
                                    label: 'Адрес сайта',
                                    hintText: 'https://example.eldor.kz',
                                    autofillHints: [
                                      AutofillHints.url,
                                      AutofillHints.username,
                                      AutofillHints.password,
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  const SimpleTextField(
                                    label: 'Логин',
                                    hintText: 'Введите ваш логин',
                                    autofillHints: [AutofillHints.username],
                                  ),
                                  const SizedBox(height: 15),
                                  const SimpleTextField(
                                    label: 'Пароль',
                                    hintText: 'Введите ваш пароль',
                                    isPassword: true,
                                    autofillHints: [AutofillHints.password],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // PASTKI BLOK: tugma + "Забыли пароль?"
                            SizedBox(
                              height: 53,
                              width: double.infinity,
                              child: PrimaryButton(
                                onPressed: () {
                                  // if (_formKey.currentState?.validate() ?? false) { ... }
                                },
                                text: 'Войти',
                                isEnabled: true,
                                isLoading: false,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                'Забыли пароль?',
                                style: TextStyle(color: AppColors.primary),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ForGetPasswordScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
