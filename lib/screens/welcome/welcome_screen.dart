import 'package:flutter/material.dart';
import 'package:sss_app/screens/home/auth_screen.dart';
import 'package:sss_app/src/common/styles/app_colors.dart';
import 'package:sss_app/src/common/widgets/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: const [
                    WelcomeItem(
                      image: 'assets/images/welcome_box.png',
                      title: 'Полный контроль',
                      subtitle:
                          'SSS Group предоставляет удобные инструменты для учёта и контроля всего товарооборота',
                    ),
                    WelcomeItem(
                      image: 'assets/images/welcome_scan.png',
                      title: 'Сканирование',
                      subtitle:
                          'С SSS Group легко сканировать коды маркировки и получать всю информацию о товаре',
                    ),
                    WelcomeItem(
                      image: 'assets/images/welcome_sell.png',
                      title: 'Режим продажи',
                      subtitle:
                          'Продавайте товары быстрее с интерфейсом, адаптированным под терминалы от SSS Group',
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _page == i ? 10 : 8,
                    height: _page == i ? 10 : 8,
                    decoration: BoxDecoration(
                      color: _page == i
                          ? AppColors.primary
                          : Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: PrimaryButton(
                  text: _page == 2 ? 'Начать' : 'Далее',
                  onPressed: () {
                    if (_page == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const WelcomeItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250, fit: BoxFit.contain),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
