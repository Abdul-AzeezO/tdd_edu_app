import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/services/dependency_injection/injection.dart';
import 'package:education_app/core/services/router.dart';
import 'package:education_app/src/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        fontFamily: kfPoppins,
        colorScheme: ColorScheme.fromSwatch(accentColor: kcPrimaryColor),
      ),
      initialRoute: OnboardingView.routeName,
      onGenerateRoute: generateRoute,
    );
  }
}
