import 'package:flutter/material.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/screens/navigation_screen.dart';

import '../utils/global_variables.dart';

enum AuthMode { signup, login }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  AuthMode _authMode = AuthMode.login;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  void login() async {
    String res = await AuthMethods()
        .login(_emailController.text, _passwordController.text);
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  void signup() async {
    String res = await AuthMethods().signup(_emailController.text,
        _passwordController.text, _displayNameController.text);
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_authMode == AuthMode.login) {
      login();
    } else {
      signup();
    }
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter an email address.";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a passowrd.";
        }
        if (value.length < 6) {
          return "Password must have at least 6 characters.";
        }
        return null;
      },
    );
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Username',
      ),
      controller: _displayNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a username.";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        color: Colors.blueGrey[100],
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: Image.network(
                        'https://www.pngall.com/wp-content/uploads/2/Mercury-Planet.png'),
                  ),
                  const Text(
                    'Welcome to Project Mercury',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  _authMode == AuthMode.signup
                      ? _buildDisplayNameField()
                      : Container(),
                  _buildEmailField(),
                  _buildPasswordField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_authMode == AuthMode.login
                          ? "Don't have an account?"
                          : "Already have an Account?"),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.login
                                ? AuthMode.signup
                                : AuthMode.login;
                          });
                        },
                        child: Text(
                            _authMode == AuthMode.login ? 'Signup' : 'Login'),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () async {
                          _submitForm();
                          // await AuthMethods().signInAnonymously();
                          // if (FirebaseAuth.instance.currentUser != null) {
                          //   Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //       builder: (context) => const NavigationScreen(),
                          //     ),
                          //   );
                          // }
                        },
                        child: Text(
                          _authMode == AuthMode.login ? 'Login' : 'Signup',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
