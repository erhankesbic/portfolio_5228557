import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'viewmodels/home_view_model.dart';
import 'viewmodels/theme_view_model.dart';

void main() async {
  // Stelle sicher, dass Flutter initialisiert ist
  WidgetsFlutterBinding.ensureInitialized();

  // Locator für Dependency Injection einrichten
  setupLocator();

  // Explizit Material Icons Font laden
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            title: 'Portfolio App',
            debugShowCheckedModeBanner: false,
            theme: themeViewModel.lightTheme,
            darkTheme: themeViewModel.darkTheme,
            themeMode: ThemeMode.system, // Or could be controlled by a setting
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
