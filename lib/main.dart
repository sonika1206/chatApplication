import 'package:chat2/chat/logic/theme_provider.dart';
import 'package:chat2/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://txvofymelshyvluaarpy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4dm9meW1lbHNoeXZsdWFhcnB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg1MDU2ODUsImV4cCI6MjA2NDA4MTY4NX0.t5vXNLC8uGIUOTlWrP6ZWIosBEz2e6KOwAxSmhRbcJY',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode, 
      theme: ThemeData(
        primaryColor:  Color.fromARGB(255, 162, 215, 233),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary:  Color.fromARGB(255, 162, 215, 233),
          secondaryContainer: Colors.grey,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF333333)),
          bodySmall: TextStyle(color:Colors.black)
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor:  Color.fromARGB(255, 162, 215, 233),
          unselectedItemColor: Color(0xFF333333),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor:  Color.fromARGB(255, 162, 215, 233),
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary:  Color.fromARGB(255, 162, 215, 233),
          secondary: Colors.grey,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall:TextStyle(color: Color.fromARGB(255, 61, 63, 65)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor:  Color.fromARGB(255, 162, 215, 233),
          unselectedItemColor: Colors.white70,
        ),
      ),
      routerConfig: router,
    );
  }
}
