import 'package:flutter/material.dart';
import 'package:sss_app/screens/create/widgets/create_sheet.dart';
import 'package:sss_app/screens/scanner/barcode_scanner_screen.dart';
import 'package:sss_app/screens/settings/screens/language_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
          );
          if (result != null && context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Сканировано: $result')));
          }
        },
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Сканировать'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(context: context, builder: buildCreateSheet);
            },
            child: const Text('Открыть фильтр'),
          ),
          ElevatedButton(
            onPressed: () async {
              final code = await Navigator.push<String>(
                context,
                MaterialPageRoute(builder: (_) => const LanguageScreen()),
              );
              if (code != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Выбран язык: $code')),
                );
              }
            },
            child: const Text('Язык'),
          ),
        ],
      ),
    );
  }
}
