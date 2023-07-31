import 'package:flutter/material.dart';
import 'package:flutter_imc/pageg/page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ImcPage(),
    );
  }
}
