import 'package:flutter/material.dart';
import 'package:loja_virtual/models/model_user.dart';
import 'package:loja_virtual/pages/page_signup.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Entrar',
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (BuildContext context, Widget? child, UserModel model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text!.isEmpty || !text.contains('@')) {
                      return 'E-mail inválido!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (text) {
                    if (text!.isEmpty || text.length < 6) {
                      return 'Senha inválida.';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Insira seu e-mail para recuperação.!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Confira seu e-mail.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Esqueci minha senha',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Falha ao Entrar!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
