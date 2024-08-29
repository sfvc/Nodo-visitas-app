import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:nodo_app_2/config/constants/enviroments.dart';
import 'package:nodo_app_2/config/router/app_router.dart';

Future main() async {
  await Enviroments.initEnviroment();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define your FlexColorScheme for light and dark themes
    const FlexScheme lightTheme = FlexScheme.aquaBlue;
    const FlexScheme darkTheme = FlexScheme.aquaBlue;
    final appRouterProvider = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouterProvider,

      locale: const Locale('es', 'ES'), // Set Spanish as the default locale
      // Theme setup
      theme: FlexColorScheme.light(
        scheme: lightTheme,
        fontFamily: GoogleFonts.poppins().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 15,
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ).toTheme.copyWith(),
      darkTheme: FlexColorScheme.dark(
        scheme: darkTheme,
        fontFamily: GoogleFonts.poppins().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).toTheme.copyWith(),
      themeMode: ThemeMode.system, // Use system theme mode (light/dark)

      debugShowCheckedModeBanner: false,
    );
  }
}
