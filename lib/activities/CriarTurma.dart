import 'package:app_teste/help/DadosUsuarioFire.dart';
import 'package:app_teste/model/Turma.dart';
import 'package:app_teste/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CriarTurma extends StatefulWidget {

  Usuario usuario;

  CriarTurma(this.usuario);

  @override
  _CriarTurmaState createState() => _CriarTurmaState();
}

class _CriarTurmaState extends State<CriarTurma> {
  var _nomeTurma = TextEditingController();
  var _senhaTurma = TextEditingController();

  String _valuePeriodo;
  String _valueCurso;
  String _valueModulo;
  
  Usuario usuario;

  List<String> _dropdownPeriodo = ["Manhã", "Tarde", "Noite"];
  List<String> _dropdownCurso = ["Ads", "Projetos", "Mecatrônica"];
  List<String> _dropdownModulo = ["1", "2", "3", "4", "5", "6"];

  void verificarCamposCriarTurma() {
    String nome = _nomeTurma.text;
    String senha = _senhaTurma.text;

    bool verificar = verificarCampos(nome, senha);

    if (verificar == true) {
      Turma turma = Turma();
      turma.nomeTurma = nome;
      turma.senha = senha;
      turma.periodo = _valuePeriodo;
      turma.curso = _valueCurso;
      turma.modulo = _valueModulo;
      turma.usuario = usuario;
      turma.registrarTurmaFireBase();
      Navigator.pop(context);
    }
  }


  bool verificarCampos(String nome, String senha) {
    if (nome.isNotEmpty) {
      if (senha.isNotEmpty) {
        if (_valuePeriodo != null) {
          if (_valueCurso != null) {
            if (_valueModulo != null) {
              return true;
            } else {
              msg("Informar o módulo é obrigatório!");
            }
          } else {
            msg("Informar o período é obrigatório!");
          }
        } else {
          msg("Informar o período é obrigatório!");
        }
      } else {
        msg("Campo senha vazio!");
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

  @override
  void initState() {
    super.initState();
    verificarDadosUsuario();
    }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Criar turma"),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  verificarCamposCriarTurma();
                },
                icon: Icon(Icons.done),
              )
            ],
          ),
          body: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 320,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _nomeTurma,
                          decoration: InputDecoration(
                              hintText: "Ex: Cálculo I",
                              labelText: "Nome da turma"),
                        ),
                        TextField(
                          controller: _senhaTurma,
                          decoration: InputDecoration(
                              hintText: "Ex: 1589",
                              labelText: "Digite uma senha: "),
                        ),
                      ],
                    ),
                  ),
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
                    },
                    hint: Text("Selecione o período"),
                  ),
                  DropdownButton(
                    value: _valueCurso,
                    items: _dropdownCurso
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        _valueCurso = value;
                      });
                    },
                    hint: Text("Selecione o curso   "),
                  ),
                  DropdownButton(
                    value: _valueModulo,
                    items: _dropdownModulo
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        _valueModulo = value;
                      });
                    },
                    hint: Text("Selecione o módulo"),
                  )
                ],
              ),
            ),
          ),
        );
      }
    
      void verificarDadosUsuario() {
        usuario = widget.usuario;
        if(usuario == null){
          print("Buscar dados");
        }
      }
}
