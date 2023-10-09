import 'package:flutter/material.dart';

import 'package:miappfeita/pages/register.dart';
import 'package:miappfeita/pages/todos.dart';
import 'package:miappfeita/utils/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    final username = _usernameController.value.text.toString();
    final password = _passwordController.value.text.toString();

    try {
      await Auth().login(
        username: username,
        password: password,
      );

      if (!context.mounted) {
        return;
      }

      setState(() {
        _loading = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TodosPage();
      }));
    } catch (e) {
      final message = e.toString().substring(11);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: $message'),
        ),
      );

      setState(() {
        _loading = false;
      });

      return;
    }
  }

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
                controller: _usernameController,
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
                controller: _passwordController,
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
              onPressed: _loading ? null : () => _login(context),
              child: _loading
                  ? const Text("Accediendo...")
                  : const Text("Acceder"),
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
