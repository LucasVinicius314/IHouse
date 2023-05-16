import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../components/header_widget.dart';
import '../../constants/theme_helper.dart';
import '../../routes/routes.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    Key _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login),
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: Column(children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    125, 217, 253, 0.575),
                                                blurRadius: 20.0,
                                                offset: Offset(0, 10))
                                          ]),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            202,
                                                            202,
                                                            202)))),
                                            child: TextField(
                                                controller: _emailController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Usuário ou E-mail",
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0))),
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextField(
                                                controller: _passwordController,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Senha",
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0))),
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          )
                                        ],
                                      ),
                                    )
                                  ])),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Entrar'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.ROUTE_Home);
                                    login(_emailController.text,
                                        _passwordController.text);
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Não possui um cadastro? "),
                                  TextSpan(
                                    text: 'Criar',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.ROUTE_Register);
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> login(String email, String password) async {
  Uri getUserDataUrl = Uri.parse('https://localhost:7185/api/Users/$email');
  final response = await http.get(getUserDataUrl);

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Usuário não cadastrado');
  }
}
