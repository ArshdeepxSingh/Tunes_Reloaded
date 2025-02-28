import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tunes_reloaded/model/playlist_provider.dart';
import 'package:tunes_reloaded/pages/splash/splash.dart';
import 'package:tunes_reloaded/theme/theme_provider.dart';

void main() async {
  // supabase setup
  await Supabase.initialize(
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZiaWd2anF6Ymxtcm52am94aGJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA2NDA3MzIsImV4cCI6MjA1NjIxNjczMn0.O1Am3x0VYAC_IR5JWAeixtS1bOxEPJVEfi42ywLl2EU",
      url: "https://fbigvjqzblmrnvjoxhba.supabase.co");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => PlaylistProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: SplashPage(),
    );
  }
}
