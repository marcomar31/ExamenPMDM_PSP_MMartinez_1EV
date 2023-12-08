import 'package:flutter/material.dart';

class DrawerCustomizado extends StatelessWidget {
  final Function(int indice)? onItemTap;

  DrawerCustomizado({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'MENÚ',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            selectedColor: Colors.white,
            selected: true,
            title: const Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text('HOME'),
              ],
            ),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            selectedColor: Colors.white,
            selected: true,
            title: const Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text('AJUSTES'),
              ],
            ),
            onTap: () {
              onItemTap!(1);
            },
          ),
          ListTile(
            selectedColor: Colors.white,
            selected: true,
            title: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text('LOGOUT'),
              ],
            ),
            onTap: () {
              onItemTap!(2);
            },
          ),
        ],
      ),
    );
  }
}
