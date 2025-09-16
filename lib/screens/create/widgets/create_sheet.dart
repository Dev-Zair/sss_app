import 'package:flutter/material.dart';

Widget buildCreateSheet(BuildContext context) => SafeArea(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Container( 
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Создать',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _items.length,
          separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: item.onTap,
            );
          },
        ),
      ),
    ],
  ),
);

class _SheetItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  _SheetItem({required this.icon, required this.title, required this.onTap});
}

final _items = [
  _SheetItem(icon: Icons.shopping_bag_outlined, title: 'Продажа', onTap: () {}),
  _SheetItem(icon: Icons.inventory_2_outlined, title: 'Товар', onTap: () {}),
  _SheetItem(icon: Icons.add_box_outlined, title: 'Приёмка', onTap: () {}),
  _SheetItem(
    icon: Icons.remove_circle_outline,
    title: 'Списание',
    onTap: () {},
  ),
  _SheetItem(icon: Icons.assignment_outlined, title: 'Ревизия', onTap: () {}),
  _SheetItem(
    icon: Icons.compare_arrows_outlined,
    title: 'Перемещение',
    onTap: () {},
  ),
];
