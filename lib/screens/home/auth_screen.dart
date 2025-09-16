import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sss_app/screens/home/for_get_password_screen.dart';
import 'package:sss_app/src/common/styles/app_colors.dart';
import 'package:sss_app/src/common/widgets/primary_button.dart';
import 'package:sss_app/src/common/widgets/simple_text_field.dart';
import 'package:sss_app/screens/home/main_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  static const String _defaultAddress = 'https://eco.eldor.kz';
  static const String _defaultLogin = 'admin';
  static const String _defaultPassword = '123456';

  final _addressController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _addressController.text = _defaultAddress;
    _loginController.text = _defaultLogin;
    _passwordController.text = _defaultPassword;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _tryLogin() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final addr = _addressController.text.trim();
    final login = _loginController.text.trim();
    final pass = _passwordController.text;

    final ok =
        addr == _defaultAddress &&
        login == _defaultLogin &&
        pass == _defaultPassword;

    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Неверные данные. Проверьте адрес, логин и пароль.'),
        ),
      );
    }
  }

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
                                  SimpleTextField(
                                    label: 'Адрес сайта',
                                    hintText: 'https://eco.eldor.kz',
                                    controller: _addressController,
                                    validator: (v) {
                                      final val = (v ?? '').trim();
                                      if (val.isEmpty) return 'Введите адрес';
                                      return null;
                                    },
                                    autofillHints: const [AutofillHints.url],
                                  ),
                                  const SizedBox(height: 15),
                                  SimpleTextField(
                                    label: 'Логин',
                                    hintText: 'Введите ваш логин',
                                    controller: _loginController,
                                    validator: (v) {
                                      if ((v ?? '').trim().isEmpty)
                                        return 'Введите логин';
                                      return null;
                                    },
                                    autofillHints: const [
                                      AutofillHints.username,
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  SimpleTextField(
                                    label: 'Пароль',
                                    hintText: 'Введите ваш пароль',
                                    isPassword: true,
                                    controller: _passwordController,
                                    validator: (v) {
                                      if ((v ?? '').isEmpty)
                                        return 'Введите пароль';
                                      return null;
                                    },
                                    autofillHints: const [
                                      AutofillHints.password,
                                    ],
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
                                onPressed: _tryLogin,
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
