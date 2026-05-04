import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Placeholder for future providers like DatabaseService, ReceiptService
        Provider<int>.value(value: 42),
      ],
      child: const ReceiptIQApp(),
    ),
  );
}

class ReceiptIQApp extends StatelessWidget {
  const ReceiptIQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReceiptIQ',
      theme: AppTheme.lightTheme,
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
