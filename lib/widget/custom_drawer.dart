import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      
      duration: const Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
      decoration: BoxDecoration(
        color: TColor.bg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Custom Full Height Drawer',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black),
                  title: const Text('Home', style: TextStyle(color: Colors.black)),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.black),
                  title: const Text('Settings', style: TextStyle(color: Colors.black)),
                  onTap: () {
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.black),
                  title: const Text('About', style: TextStyle(color: Colors.black)),
                  onTap: () {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );}
}