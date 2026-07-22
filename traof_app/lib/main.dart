import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'features/splash/splash_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/donor/screens/donor_dashboard.dart';
import 'features/family/screens/family_dashboard.dart';
import 'features/employee/screens/employee_dashboard.dart';
import 'features/admin/screens/admin_dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const TraofApp());
}

class TraofApp extends StatelessWidget {
  const TraofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق تراؤف',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/donor': (context) => const DonorDashboard(),
        '/family': (context) => const FamilyDashboard(),
        '/employee': (context) => const EmployeeDashboard(),
        '/admin': (context) => const AdminDashboard(),
      },
    );
  }
}
