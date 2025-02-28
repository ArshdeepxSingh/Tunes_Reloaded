import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tunes_reloaded/common/widget/button/basic_app_button.dart';
import 'package:tunes_reloaded/pages/home/home_page.dart';
import 'package:tunes_reloaded/pages/login/login.dart';
import 'package:tunes_reloaded/pages/register/register.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null && mounted) {
      // Redirect to HomePage if the user is already logged in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/weeknd.jpg"),
              ),
            ),
          ),
          Container(
            color: Colors.black.withAlpha(190),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      "assets/vectors/tunes_logo.svg",
                      height: 80,
                      width: 200,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Enjoy Listening To Your Favourite Tunes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Dive deep into the world of music with Tunes, the latest generation of music players.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                    },
                    title: "Get Started",
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Already have an account? Sign In",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
