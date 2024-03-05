import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/layout_view.dart';
import 'views/login_page.dart';

const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyApUuLphZrzNQhoEmTe10jp5sGR1i1VCwk",
  authDomain: "wedfuse-19d54.firebaseapp.com",
  projectId: "wedfuse-19d54",
  storageBucket: "wedfuse-19d54.appspot.com",
  messagingSenderId: "754228586570",
  appId: "1:754228586570:web:1554f198875a6b1d7e1eb3",
  measurementId: "G-PVSMVNL1P5",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedme Admin Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
