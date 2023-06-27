import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 195, 248, 252),
  background: Color.fromARGB(255, 230, 253, 255),
);

var kDarkScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 6, 65, 82),
  background: Color.fromARGB(255, 29, 29, 29),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // ).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kDarkScheme.onBackground,
            foregroundColor: kDarkScheme.onSecondary,
            titleTextStyle: GoogleFonts.kanit(
              color: kDarkScheme.onSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            elevation: 15,
            shadowColor: Colors.black,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kDarkScheme.onBackground,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkScheme.primary,
                  foregroundColor: kDarkScheme.background)),
          inputDecorationTheme:
              InputDecorationTheme(labelStyle: TextStyle(color: Colors.white)),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: kDarkScheme.background)),
          textTheme: ThemeData().textTheme.copyWith(
                titleMedium: GoogleFonts.kanit(
                  color: kDarkScheme.onSecondary,
                  fontSize: 16,
                ),
                bodyLarge: GoogleFonts.ubuntu(
                    color: kDarkScheme.onSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                bodySmall: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                labelMedium: GoogleFonts.kanit(
                    color: kDarkScheme.background.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
          bottomSheetTheme: const BottomSheetThemeData().copyWith(
            backgroundColor: kDarkScheme.secondary,
          ),
          scaffoldBackgroundColor: kDarkScheme.background,
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: Colors.black,
            titleTextStyle: GoogleFonts.kanit(
              color: kColorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
            elevation: 15,
            shadowColor: Colors.black,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.background,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleMedium: GoogleFonts.kanit(
                  color: kColorScheme.onPrimaryContainer,
                  fontSize: 16,
                ),
                bodyLarge: GoogleFonts.ubuntu(
                    color: kColorScheme.onSecondaryContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
          scaffoldBackgroundColor: kColorScheme.secondaryContainer,
        ),
        home: const Expenses(),
        themeMode: ThemeMode.system,
      ),
    );
  //});
}
