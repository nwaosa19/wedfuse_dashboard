import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedme_dashboard/views/home_view.dart';

import 'navigation_view.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: const Drawer(
        child: NavigationView(),
      ),
      appBar: size.width < 700
          ? AppBar(
              centerTitle: true,
              title: const Text("Wedme"),
            )
          : null,
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Row(
          children: [
            size.width < 700 ? Container() : const NavigationView(),
            Container(
              width: size.width < 700 ? size.width : size.width * 0.75,
              child: HomeView(),
            ),
          ],
        ),
      ),
    );
  }
}
