import 'package:flutter/material.dart';
import '../features/insightmind/presentation/pages/home_page.dart';

class InsightMindApp extends StatelessWidget {
  const InsightMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InsightMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(241, 67, 198, 1),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}