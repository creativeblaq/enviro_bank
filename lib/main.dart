import 'package:enviro_bank/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xff07060B),
          primaryColorLight: const Color(0xff403648),
          iconTheme: const IconThemeData(
            color: Color(0xffE6E2E8),
          ),
          brightness: Brightness.dark,
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xff07060B),
            onPrimary: Colors.white,
            secondary: Color(0xff6161FF),
            tertiary: Color(0xffD13832),
            onSecondary: Colors.white,
            error: Colors.redAccent,
            onError: Colors.white,
            background: Color(0xff07060B),
            onBackground: Colors.white,
            surface: Color(0xff07060B),
            onSurface: Colors.white,
          ),
          textTheme: GoogleFonts.montserratTextTheme().apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          useMaterial3: true),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
