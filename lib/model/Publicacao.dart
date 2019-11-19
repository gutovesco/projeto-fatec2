
import 'package:app_teste/model/Usuario.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Publicacao{

  String _titulo;
  String _descricao;
  String _data;
  String _hora;
  String _urlImagem;
  Usuario _usuario;
  bool _semRestricoes;
  bool _mecatronica;
  bool _projetos;
  bool _ads;

  Future<bool> salvarFirebase() async {
    Map<String, String> usu = Map();
    usu["nome"] = usuario.nome;
    usu["email"] = usuario.email;
    usu["imagePerfil"] = usuario.imagemPerfil;

    Map<String, Object> dados = Map();
    dados["titulo"] = titulo;
    dados["descricao"] = descricao;
    dados["data"] = data;
    dados["hora"] = hora;
    dados["urlImagem"] = urlImagem;
    dados["ads"] = ads;
    dados["projetos"] = projetos;
    dados["mecatronica"] = mecatronica;
    dados["semRestricoes"] = semRestricoes;
    dados["usuario"] = usu;

    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'salvarDadosPublicacao',
    );

    var d = await callable.call(dados);
    print(d.data.toString());
  }

  Usuario get usuario => _usuario;

  set usuario(Usuario usuario) {
    _usuario = usuario;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String urlImagem) {
    _urlImagem = urlImagem;
  }

  String get hora => _hora;

  set hora(String hora) {
    _hora = hora;
  }

  String get data => _data;

  set data(String data) {
    _data = data;
  }

  String get descricao => _descricao;

  set descricao(String descricao) {
    _descricao = descricao;
  }

  String get titulo => _titulo;

  set titulo(String titulo) {
    _titulo = titulo;
  }

  bool get ads => _ads;

  set ads(bool ads) {
    _ads = ads;
  }

  bool get projetos => _projetos;

  set projetos(bool projetos) {
    _projetos = projetos;
  }

  bool get mecatronica => _mecatronica;

  set mecatronica(bool mecatronica) {
    _mecatronica = mecatronica;
  }

  bool get semRestricoes => _semRestricoes;

  set semRestricoes(bool semRestricoes) {
    _semRestricoes = semRestricoes;
  }

}