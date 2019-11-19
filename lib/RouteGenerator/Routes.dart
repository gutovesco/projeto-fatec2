import 'package:app_teste/activities/CriarTurma.dart';
import 'package:app_teste/activities/MinhasPublicacoes.dart';
import 'package:app_teste/activities/MinhasTurma.dart';
import 'package:app_teste/activities/Publicar.dart';
import 'package:app_teste/telas/TelaAutenticacao.dart';
import 'package:app_teste/telas/TelaCadastrar.dart';
import 'package:app_teste/telas/TelaHome.dart';
import 'package:app_teste/telas/TelaPerfil.dart';
import 'package:flutter/material.dart';

class RouteGenerator {


  static Route<dynamic> generateRoute(RouteSettings settings, ){

    switch(settings.name){
      case "/" : return MaterialPageRoute(
        builder: (_) => Home()
      );
      case "/autenticacao" : return MaterialPageRoute(
        builder: (_) => Autenticacao()
      );
      case "/cadastro" : return MaterialPageRoute(
        builder: (_) => Cadastro()
      );
      case "/perfil" : return MaterialPageRoute(
        builder: (_) => Perfil()
      );
      case "/publicar" : return MaterialPageRoute(
        builder: (_) => Publicar()
      );
      case "/publicar" : return MaterialPageRoute(
        builder: (_) => MinhasTurmas()
      );
      case "/minhasPublicacoes" : return MaterialPageRoute(
        builder: (_) => MinhasPublicacoes()
      );
    }

    

  }

}