import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../reusable_widgets/reusable_widget_signin.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signin.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Page Content
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome to PetPal!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                        "Enter Email",
                        Icons.person_outline,
                        false,
                        _emailTextController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      reusableTextField(
                        "Enter Password",
                        Icons.lock_outline,
                        true,
                        _passwordTextController,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      forgetPassword(context),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _errorText = null;
                          });

                          final email = _emailTextController.text;
                          final password = _passwordTextController.text;

                          if (email.isEmpty || password.isEmpty) {
                            setState(() {
                              _errorText =
                                  "Please enter both email and password";
                            });
                          } else {
                            try {
                              final userCredential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                              if (userCredential.user == null) {
                                setState(() {
                                  _errorText = "Invalid email or password";
                                });
                              } else {
                                GoRouter.of(context).go('/home');
                              }
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                _errorText = e.message;
                              });
                            } catch (e) {
                              print("Error: $e");
                            }
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 147, 224, 219),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      signUpOption(),
                      if (_errorText != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          child: Text(
                            _errorText!,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Color.fromARGB(255, 255, 119, 0)),
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/signup');
          },
          child: Row(
            children: [
              const Text(
                " Sign Up",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 119, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Color.fromARGB(255, 255, 119, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Forgot Password?",
              style: TextStyle(color: Color.fromARGB(255, 255, 119, 0)),
            ),
            Icon(
              Icons.help_outline,
              color: Colors.white,
            ),
          ],
        ),
        onPressed: () => GoRouter.of(context).go('/reset'),
      ),
    );
  }
}
