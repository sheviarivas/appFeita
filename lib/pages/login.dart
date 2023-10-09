import 'package:flutter/material.dart';

import 'package:miappfeita/pages/register.dart';
import 'package:miappfeita/pages/todos.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de usuario',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nombre de usuario requerido';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Contraseña requerida';
                  }

                  return null;
                },
              ),
            ),
            ElevatedButton(
              child: const Text("Acceder"),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TodosPage();
                }));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                child: const Text("Registrar usuario"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
