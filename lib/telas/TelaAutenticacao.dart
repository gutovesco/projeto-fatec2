import 'package:app_teste/telas/TelaCadastrar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Autenticacao extends StatefulWidget {
  @override
  _AutenticacaoState createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {

  FirebaseAuth fireAuth = FirebaseAuth.instance;

  var _emailController = TextEditingController();
  var _senhaController = TextEditingController();

  void realizarLogin() async {
    await fireAuth.signInWithEmailAndPassword(email: _emailController.text, password: _senhaController.text)
    .then((snapshot) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
    }).catchError(
      (){
        print("Erro");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Autenticação"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              height: 190,
              width: 190,
              child: Image.asset("imagens/logo-fatec.png"),
            ),
            Container(
              width: 320,
              child: Column(
                children: <Widget>[
                TextField(
                  controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Ex: joao@hotmail.com", 
                  labelText: "Digite o seu e-mail: "
                  ),
              ),
                TextField(
                controller: _senhaController,
                obscureText: true,
                strutStyle: StrutStyle(
                ),
                maxLength: 16,
                decoration: InputDecoration(
                  hintText: "Ex: J12345(mínimo 6 dígitos)", 
                  labelText: "Digite sua senha: "
                ),
            ),
            RaisedButton(
              child: Text("Entrar"),
              onPressed: (){
                realizarLogin();
                              },
                            )
                                ],
                              ),
                            ) ,
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                                height: 60,
                                child: Text("Não tem uma conta? Clique aqui!"),
                              ),
                              onTap: () async {
                                bool cadastro = await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Cadastro()
                                ));
                                if(cadastro == true){
                                  Navigator.pop(context);
                                }
                
                              },
                            )
                          ],
                        ),
                        ),
                      ),
                    );
                  }
}