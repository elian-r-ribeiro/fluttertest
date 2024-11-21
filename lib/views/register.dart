import 'package:flutter/material.dart';
import 'package:fluttertest/services/authService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService _authService = AuthService();

  bool _obscureText = true;

  void _showDialog(String title, String message, bool isError) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
          backgroundColor: isError ? Colors.red[100] : Colors.green[100],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar',
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
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatória';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text('Nome'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
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
                obscureText: _obscureText,
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
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
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
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;

                    _authService
                        .registerUser(
                            name: name, email: email, password: password)
                        .then((value) {
                      if (value != null) {
                        _showDialog('Erro', value, true);
                      } else {
                        _showDialog(
                            'Sucesso', 'Cadastro efetuado com sucesso', false);
                      }
                    });
                  }
                },
                child: const Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Já tenho uma conta',
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
