import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../reusable_widgets/reusable_widget_signin.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String? _errorText;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: .0,
      end: 1.0,
    ).animate(_animationController);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -5),
      end: Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/009/925/006/original/cute-purple-aesthetic-abstract-minimal-background-perfect-for-wallpaper-backdrop-postcard-background-vector.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Rectangle at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Simba.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),

          // Page Content
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, 0),
                            end: Offset(0, 0),
                          ).animate(_animationController),
                          child: Text(
                            "Hola Amigos!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
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
                          height: 20,
                        ),
                        reusableTextField(
                          "Enter Password",
                          Icons.lock_outline,
                          true,
                          _passwordTextController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        forgetPassword(context),
                        firebaseUIButton(context, "Login", () async {
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
                        }),
                        signUpOption(),
                        if (_errorText != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                            ),
                            child: Text(
                              _errorText!,
                              style: TextStyle(
                                color: Colors.black,
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
          style: TextStyle(color: Colors.black),
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
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
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.help_outline,
              color: Colors.black,
            ),
          ],
        ),
        onPressed: () => GoRouter.of(context).go('/reset'),
      ),
    );
  }
}
