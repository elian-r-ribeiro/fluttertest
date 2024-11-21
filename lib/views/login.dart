import 'package:flutter/material.dart';
import 'package:fluttertest/services/authService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService _authService = AuthService();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              'assets/Unao.jpg',
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email é obrigatório';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  label: Text('Email'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha é obrigatória';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  label: Text('Senha'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String email = emailController.text;
                    String password = passwordController.text;
                    _authService
                        .loginUser(email: email, password: password)
                        .then((erro) {
                      if (erro != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erro'),
                              content: Text(erro),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'registerPage');
              },
              child: const Text(
                'Criar uma conta',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'passwordRecover');
              },
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Spacer(flex: 2)
          ],
        ),
      ),
    );
  }
}
