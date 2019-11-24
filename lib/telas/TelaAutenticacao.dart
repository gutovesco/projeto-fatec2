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
      body:
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
        ), 
        child: Center(
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
                  labelText: "Digite o seu e-mail: ",
                              labelStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              fontFamily: "Open Sans",
                          ),
                  
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
                  labelText: "Digite sua senha: ",
                              labelStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              fontFamily: "Open Sans",
                          ),
                ),
            ),

            SizedBox(height: 20),

             Container(
               height: 50,
               alignment: Alignment.centerLeft,
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                    stops: [0, 1],
                   colors: [
                     Color(0xFF1976D2),
                     Color(0xFF90CAF9),
                   ],
                 ),
                  borderRadius: BorderRadius.all(
                   Radius.circular(5),
                 ),
               ),
               child: SizedBox.expand(
                 child: FlatButton(
                   child: 
                  Center(
                       child: Text(
                         "Logar",
                         textAlign: TextAlign.center, 
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                           fontSize: 20,
                           fontFamily: "Open Sans",
                         ),
                         ),
                  ),   
                  onPressed: () {
                      realizarLogin();
                  }),
               ),
             ),

              SizedBox(height:20),

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
          ]),
                    ))));
                  }
}