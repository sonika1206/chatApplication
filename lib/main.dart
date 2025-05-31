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
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:Colors.blue,
        scaffoldBackgroundColor:Colors.white,
        colorScheme: const ColorScheme.light(
         primary: Colors.blue,
          secondary: Color(0xFFFF6584),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF333333)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor:Colors.blue,
          unselectedItemColor: Color(0xFF333333),
        ),
      ),
     routerConfig: router,
    );
  }
}