import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunes_reloaded/theme/app_colors.dart';
import 'package:tunes_reloaded/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).brightness == Brightness.dark 
                ? AppColors.dark // Use dark mode color
                : AppColors.light, // Use light mode color
            title: const Text("SETTINGS"),
          ),
      body: Container(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              Text("Dark Mode"),
              CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme())
            ],
          ),
        ),
      ),
    );
  }
}
