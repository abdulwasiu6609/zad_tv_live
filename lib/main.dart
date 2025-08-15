import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'live_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZadTvApp());
}

class ZadTvApp extends StatelessWidget {
  const ZadTvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zad TV — Live',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LivePage(),
    );
  }
}
