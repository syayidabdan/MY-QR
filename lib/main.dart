import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:qr_generator_and_scanner/ui/home_screen.dart';
import 'package:qr_generator_and_scanner/ui/qr_generator_screen.dart';
import 'package:qr_generator_and_scanner/ui/qr_scanner_screen.dart';
import 'package:qr_generator_and_scanner/ui/splash_screen.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      builder: (context) {
        return const MainApp();
      }));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
          fontFamily: 'Manrope',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/create': (context) => const QrGeneratorScreen(),
        '/scan': (context) => const QrScannerScreen()
      },
    );
  }
}