import 'package:customer_feedback_admin/providers/FeedbackProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/admin_login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/dashboard/feedback_list_screen.dart';
import 'screens/dashboard/feedback_details_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()..checkAuthStatus()), // ✅ Check auth status on startup
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return MaterialApp(
          title: 'Admin Dashboard',
          theme: ThemeData(primarySwatch: Colors.blue),
          debugShowCheckedModeBanner: false,
          home: authProvider.isAuthenticated ? const DashboardScreen() : const AdminLoginScreen(), // ✅ Auto-redirect
          routes: {
            '/dashboard': (context) => const DashboardScreen(),
            '/feedback_list': (context) => const FeedbackListScreen(),
            '/feedback_details': (context) => const FeedbackDetailsScreen(),
          },
        );
      },
    );
  }
}
