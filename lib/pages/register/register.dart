import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunes_reloaded/auth/auth_service.dart';
import 'package:tunes_reloaded/common/widget/button/basic_app_button.dart';
import 'package:tunes_reloaded/pages/home/home_page.dart';
import 'package:tunes_reloaded/pages/login/login.dart';
import 'package:tunes_reloaded/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // get auth service
  final authService = AuthService();

  // text controllers 
   
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();


  void signUp() async{

    // prepare data 

    final email = _email.text;
    final password = _password.text;
    final confirmPassword = _confirmPassword.text;

    // check that password match 
    if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
    return;
  }
    // attempt sign up 

    try {
      await authService.signUpWithEmailAndPassword(email, password);

      // pop register page 
      Navigator.of(context).pop();

      // if login is successful, navigate to home page
       Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()),
                            (route) => false);

    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error signing up: $e ")));
      }
      
    }  

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: SvgPicture.asset("assets/vectors/tunes_logo.svg", height: 50, width: 60),
          leading: BackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              SizedBox(height: 50),
              _emailField(context),
              SizedBox(height: 10),
              _passwordField(context),
              SizedBox(height: 10),
              _confirmPasswordField(context),
              SizedBox(height: 20),
              BasicAppButton(
                  onPressed: signUp,
                  title: "Create Account"),
              SizedBox(height: 30),
              _signInText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return Text('Register',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }


  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(hintText: "E-Mail")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(hintText: "Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
      obscureText: true, // To hide password input
    );
  }

    Widget _confirmPasswordField(BuildContext context) {
    return TextField(
      controller: _confirmPassword,
      decoration: InputDecoration(hintText: "Confirm Password")
          .applyDefaults(Theme.of(context).inputDecorationTheme),
      obscureText: true, // To hide password input
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account? ',
              style: TextStyle(fontSize: 15)),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
              },
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 15, color: AppColors.primary),
              ))
        ],
      ),
    );
  }
}
