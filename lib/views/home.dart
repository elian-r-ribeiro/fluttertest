import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
                'Elian',
                style: TextStyle(fontSize: 24),
              ),
              accountEmail: Text('elianrodriguesribeiro@gmail.com'),
            ),
            ListTile(
              title: Text(
                'Sair',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {},
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
