import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Formulário"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: controller,
                  title: "Nome",
                  icon: Icons.person,
                  hint: 'Type your name',
                  validator: (text) => text == null || text.isEmpty
                      ? "This field can't be null"
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  title: "E-mail",
                  icon: Icons.mail,
                  hint: 'Typpe your e-mail',
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "This field can't be null";
                    }
                    //fazer validação do email
                    if (!validator.isEmail(text)) {
                      return "Email invalido";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  title: "Password",
                  icon: Icons.lock,
                  hint: 'Type your password',
                  validator: (text) => text == null || text.isEmpty
                      ? "This field can't be null"
                      : null,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  title: "Password",
                  icon: Icons.lock,
                  hint: 'Type your password again',
                  validator: (text) => text == null || text.isEmpty
                      ? "This field can't be null"
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) {
                      return Text(controller.text);
                    }),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      formKey.currentState?.validate();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      formKey.currentState?.reset();
                    },
                    icon: const Icon(Icons.cleaning_services),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hint;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String? text)? validator;
  final void Function(String? texte)? onSaved;
  const CustomTextField(
      {Key? key,
      required this.title,
      this.icon,
      this.hint,
      this.controller,
      this.validator,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      decoration: InputDecoration(
          // label: Text("ola"),
          labelText: title,
          hintText: hint,
          prefixIcon: icon == null ? null : Icon(icon),
          border: const OutlineInputBorder()),
    );
  }
}

@immutable
class UserModel {
  final String nome;
  final String email;
  final String password;

  UserModel({
    required this.nome,
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? nome,
    String? email,
    String? password,
  }) {
    return UserModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
