import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:nodo_app_2/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your FlexColorScheme for light and dark themes
    const FlexScheme lightTheme = FlexScheme.aquaBlue;
    const FlexScheme darkTheme = FlexScheme.aquaBlue;

    return MaterialApp(
      title: 'Flutter Demo',
      // Define supported locales and delegates
      supportedLocales: const [
        Locale('es', 'ES'), // Spanish - Spain
        // Add more locales as needed
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('es', 'ES'), // Set Spanish as the default locale
      // Theme setup
      theme: FlexColorScheme.light(
        scheme: lightTheme,
        fontFamily: GoogleFonts.poppins().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).toTheme.copyWith(
        // Additional customizations for the light theme if needed
      ),
      darkTheme: FlexColorScheme.dark(
        scheme: darkTheme,
        fontFamily: GoogleFonts.poppins().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).toTheme.copyWith(
        // Additional customizations for the dark theme if needed
      ),
      themeMode: ThemeMode.system, // Use system theme mode (light/dark)
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const Home(title: 'Nodo'), // Home as the default route
        // '/Perfil': (context) => const Perfil(title: 'Perfil Page'), // Define Perfil as a named route
      },
      debugShowCheckedModeBanner: false,
    );
  }
}