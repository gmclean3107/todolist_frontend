import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const ToDoApp());

class ToDoApp extends StatelessWidget {
  const ToDoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const ToDoScreen(),
      },
    );
  }
}

class ToDoScreen extends StatelessWidget {
  const ToDoScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: AddItemForm(),
          ),
        ),
      ),
    );
  }
}

class AddItemForm extends StatefulWidget {
  const AddItemForm();

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _descriptionTextController = TextEditingController();

  double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Add Item', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _descriptionTextController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: () => _addItem(_descriptionTextController.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

Future<http.Response> _addItem(String description) {
  var map = new Map<String, dynamic>();
  map['Description'] = description;
  return http.post(
    Uri.parse("http://localhost:8000/createitem"),
    body: map,
  );
}
