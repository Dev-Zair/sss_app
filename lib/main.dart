import 'package:flutter/material.dart';
import 'package:sss_app/screens/welcome/welcome_screen.dart';
import 'package:sss_app/src/features/language/data/memory_language_repository.dart';
import 'package:sss_app/src/features/language/presentation/language_controller.dart';
import 'package:sss_app/src/features/language/presentation/language_scope.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    
    final languageController = LanguageController(MemoryLanguageRepository());
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => LanguageScope(
        controller: languageController,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}
