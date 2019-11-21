import 'package:app_teste/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

   

class _CadastroState extends State<Cadastro> {


  String _valuePeriodo;
  var tipousuario = false;
  List<String> _dropdownPeriodo = [
    "Aluno",
    "Professor",
    "Coordenador",
    "Diretor"
  ];
  var _nomeController = TextEditingController();
  var _emailController = TextEditingController();
  var _senhaController = TextEditingController();
  var _confSenhaController = TextEditingController();

  FirebaseAuth fireAuth = FirebaseAuth.instance;

  void iniciarCadastro() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    String confSenha = _confSenhaController.text;

    bool verificar = verificarCampos(nome, email, senha, confSenha);

    if (verificar == true) {
      Usuario usuario = Usuario();
      usuario.senha = senha;
      usuario.email = email;
      usuario.nome = nome;
      cadastrarFirebase(usuario);
    }
  }

  bool verificarCampos(
      String nome, String email, String senha, String confSenha) {
    if (nome.isNotEmpty) {
      if (email.isNotEmpty) {
        if (senha.isNotEmpty) {
          if (confSenha.isNotEmpty) {
            if (senha == confSenha) {
              return true;
            } else {
              msg("Erro! Digite sua senha novamente!");
            }
          } else {
            msg("Campo confirmar senha vazio!");
          }
        } else {
          msg("Campo senha vazio!");
        }
      } else {
        msg("Campo e-mail vazio!");
      }
    } else {
      msg("Campo nome vazio!");
    }
    return false;
  }

  void msg(String msgErro) {
    Toast.show(msgErro, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void cadastrarFirebase(Usuario usuario) {
    fireAuth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((snapshot) async {
      usuario.idUsuario = snapshot.uid;
      usuario.tipoUsuario = "V";
      usuario.cadastrarFireBase();

      Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
    }).catchError((snapshot) {
      msg("Ihhhhhhhh");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizando cadastro", 
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Big Shoulders Display",),
        
          
        
      ),),
      body: Container(
        padding: EdgeInsets.only(
          top: 0,
          left: 40,
          right: 40,
        ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: 320,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                          hintText: "Ex: João",
                          labelText: "Digite o seu nome: ", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          fontFamily: "Big Shoulders Display",
                          ),),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "Ex: joao@hotmail.com",
                          labelText: "Digite o seu e-mail", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          fontFamily: "Big Shoulders Display",
                          ),),
                    ),
                    TextField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Ex: J12345(mínimo 6 dígitos)",
                          labelText: "Digite sua senha: ",
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          fontFamily: "Big Shoulders Display",
                          ),
                          
                          ),
                    ),
                    TextField(
                      controller: _confSenhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Ex: J12345(mínimo 6 dígitos)",
                          labelText: "Digite novamente sua senha: ", 
                          labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          fontFamily: "Big Shoulders Display",
                          ),),
                    ),

                  SizedBox(height: 20),

                    DropdownButton(
                      value: _valuePeriodo,
                      items: _dropdownPeriodo
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (String value) {
                        setState(() {
                          _valuePeriodo = value;

                        });
                           if(value == "Professor" || value == "Coorderandor"){
                             setState(() {
                               tipousuario = true;
                             });
                          }

                          else{
                           setState(() {
                             tipousuario = false;
                           }); 
                          }
                      },

                      
                      hint: Text("Tipo de usuário",       
                       style: TextStyle(
                       fontWeight: FontWeight.w400,
                       color: Colors.black87,
                       fontSize: 25,
                       fontFamily: "Big Shoulders Display", 
                       ),),
                    ),
                    Visibility(
                      visible: tipousuario,
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "Digite a senha de acesso", 
                              labelStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                              fontFamily: "Big Shoulders Display",
                          ),),
                      keyboardType: TextInputType.number,
                      obscureText: true
                              ),),

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
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text(
                         "Cadastrar",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                           fontSize: 25,
                           fontFamily: "Big Shoulders Display",
                         ),
                         ),
                     ],
                   ),
                  onPressed: () {
                      iniciarCadastro();
                  }),
               ),
                   
             ),
                   ] )
             ),

                  ],
                ),
              )
      ),
      ),
        );
  }
}
