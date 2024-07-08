import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../reusable_widgets/reusable_widget_signin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Column(
                    children: <Widget>[
                      SlideTransition(
                        position: _slideAnimation,
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
                        "Enter Username",
                        Icons.person_outline,
                        false,
                        _userNameTextController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                        "Enter Your Email",
                        Icons.person_outline,
                        false,
                        _emailTextController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                        "Enter Password",
                        Icons.lock_outlined,
                        true,
                        _passwordTextController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                        "Enter Phone Number",
                        Icons.phone,
                        false,
                        _phoneNumberController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "Register", () async {
                        setState(() {
                          _errorText = null;
                        });

                        final email = _emailTextController.text;
                        final password = _passwordTextController.text;
                        final phoneNumber = _phoneNumberController.text;

                        if (email.isEmpty ||
                            password.isEmpty ||
                            phoneNumber.isEmpty) {
                          setState(() {
                            _errorText = "Please fill in all fields";
                          });
                          return;
                        }

                        if (!isValidPhoneNumber(phoneNumber)) {
                          setState(() {
                            _errorText = "Invalid phone number format";
                          });
                          return;
                        }

                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          if (userCredential.user != null) {
                            await FirebaseFirestore.instance
                                .collection('UserData')
                                .doc(userCredential.user?.uid)
                                .set({
                              "email": userCredential.user?.email,
                              "phone_no": phoneNumber,
                              "username": _userNameTextController.text,
                            });

                            print("Not Null-creds\n");
                            GoRouter.of(context).go('/signin');
                          } else {
                            print("Null-creds\n");
                            setState(() {
                              _errorText = "Account creation failed";
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            setState(() {
                              _errorText = "This email is already in use";
                            });
                          } else {
                            setState(() {
                              _errorText = e.message;
                            });
                          }
                        } catch (e) {
                          print("Error: $e");
                        }
                      }),
                      if (_errorText != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
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
        ],
      ),
    );
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 11 && int.tryParse(phoneNumber) != null;
  }
}
