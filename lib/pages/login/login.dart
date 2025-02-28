import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunes_reloaded/auth/auth_service.dart';
import 'package:tunes_reloaded/common/widget/button/basic_app_button.dart';
import 'package:tunes_reloaded/pages/home/home_page.dart';
import 'package:tunes_reloaded/pages/register/register.dart';
import 'package:tunes_reloaded/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  // Text Controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isLoading = false; // To track loading state

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void login() async {
    setState(() => _isLoading = true);

    final email = _email.text.trim();
    final password = _password.text.trim();

    try {
      await authService.signInWithEmailAndPassword(email, password);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: SvgPicture.asset("assets/vectors/tunes_logo.svg", height: 50, width: 60),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signInText(),
              const SizedBox(height: 50),
              _emailField(context),
              const SizedBox(height: 10),
              _passwordField(context),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : BasicAppButton(onPressed: login, title: "Sign In"),
              const SizedBox(height: 30),
              _registerBottomText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text('Sign In', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: "E-Mail")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      obscureText: true, // Hides password input
      decoration: InputDecoration(hintText: "Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _registerBottomText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('New to this App? ', style: TextStyle(fontSize: 15)),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  RegisterPage()),
              );
            },
            child: Text("Register Now", style: TextStyle(fontSize: 15, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
