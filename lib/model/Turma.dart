import 'package:app_teste/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Turma{

  String _nomeTurma;
  String _senha;
  String _periodo;
  String _curso;
  String _modulo;
  String _idTurma;
  Usuario _usuario;

  void registrarTurmaFireBase()async{

    Map<String, String> usu = Map();
    usu["nome"] = usuario.nome;
    usu["email"] = usuario.email;
    usu["imagePerfil"] = usuario.imagemPerfil;

    Map<String, Object> dados = Map();
    dados["nomeTurma"] = nomeTurma;
    dados["senha"] = senha;
    dados["periodo"] = periodo;
    dados["curso"] = curso;
    dados["modulo"] = modulo;
    dados["usuario"] = usu;

    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'salvarDadosUsuario',
    );

    await callable.call(dados);

  }


  Usuario get usuario => _usuario;

  set usuario(Usuario usuario) {
    _usuario = usuario;
  } 
    
      String get idTurma => _idTurma;
    
      set idTurma(String idTurma) {
        _idTurma = idTurma;
      }
    
      String get modulo => _modulo;
    
      void salvarFireBase(){
        
      }
    
      set modulo(String modulo) {
        _modulo = modulo;
      }
    
      String get curso => _curso;
    
      set curso(String curso) {
        _curso = curso;
      }
    
      String get periodo => _periodo;
    
      set periodo(String periodo) {
        _periodo = periodo;
      }
    
      String get senha => _senha;
    
      set senha(String senha) {
        _senha = senha;
      }
    
      String get nomeTurma => _nomeTurma;
    
      set nomeTurma(String nomeTurma) {
        _nomeTurma = nomeTurma;
      }

}