import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/services/authService.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Tela Inicial',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text(
                widget.user.displayName != null
                    ? widget.user.displayName!
                    : "Não informado",
                style: TextStyle(fontSize: 24),
              ),
              accountEmail: Text(widget.user.email != null
                  ? widget.user.email!
                  : "Não informado"),
            ),
            ListTile(
              title: Text(
                'Sair',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                AuthService().logoutUser();
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 28,
              ),
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Bem-vindo à tela inicial!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
