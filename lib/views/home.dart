import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/services/authService.dart';
import 'package:fluttertest/services/firebaseService.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _manufacturerController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _categoryController = TextEditingController();
  Firebaseservice _firebaseservice = Firebaseservice();

  void _openModalForm({String? docId}) async {
    if (docId != null) {
      DocumentSnapshot document = await _firebaseservice.getCar(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      _manufacturerController.text = data["manufacturer"];
      _modelController.text = data["model"];
      _yearController.text = data["year"];
      _categoryController.text = data["category"];
    }

    showModalBottomSheet(
        backgroundColor: Colors.grey,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Adicionar carros",
                  style: TextStyle(fontSize: 17),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _manufacturerController,
                  decoration: InputDecoration(
                      labelText: "Fabricante",
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _modelController,
                  decoration: InputDecoration(
                      labelText: "Modelo",
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _yearController,
                  decoration: InputDecoration(
                      labelText: "Ano de fabricação",
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                      labelText: "Categoria",
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (docId == null) {
                        _firebaseservice.addCar(
                            _manufacturerController.text,
                            _modelController.text,
                            _yearController.text,
                            _categoryController.text);

                        _manufacturerController.clear();
                        _modelController.clear();
                        _yearController.clear();
                        _categoryController.clear();
                      } else {
                        _firebaseservice.updateTask(
                            docId,
                            _manufacturerController.text,
                            _modelController.text,
                            _yearController.text,
                            _categoryController.text);
                      }
                    },
                    child: Text("Salvar"))
              ],
            ),
          );
        });
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _firebaseservice.getCarsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List taskList = snapshot.data!.docs;

            return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = taskList[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String docId = document.id;
                  String carManufacturer = data["manufacturer"];
                  String carModel = data["model"];
                  String carYear = data["year"];
                  String carCategory = data["category"];

                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: ListTile(
                      title: Text(carModel),
                      subtitle: Text(carManufacturer),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      tileColor: Colors.grey[300],
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _openModalForm(docId: docId);
                            },
                            icon: Icon(Icons.settings),
                          ),
                          IconButton(
                            onPressed: () {
                              _firebaseservice.deleteTask(docId);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModalForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
