import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Providers
import 'providers/index.dart';
import 'core/services/index.dart';
import 'core/services/patient_repository.dart';
import 'core/services/visit_repository.dart';
import 'core/services/birth_repository.dart';

// Theme
import 'shared/theme/app_theme.dart';

// Screens
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/home/screens/home_screen.dart';

future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<PatientRepository>(
          create: (_) => PatientRepository(),
        ),
        Provider<VisitRepository>(
          create: (_) => VisitRepository(),
        ),
        Provider<BirthRepository>(
          create: (_) => BirthRepository(),
        ),
        // Providers
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            context.read<AuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientProvider(
            context.read<PatientRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => VisitProvider(
            context.read<VisitRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Prenatal Care App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        home: const AuthWrapper(),
      ),
    );
  }
}

/// Auth Wrapper to handle authentication state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.isAuthenticated) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
