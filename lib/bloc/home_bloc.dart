import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:consult_cnpj_bloc/states/consult_state.dart';

class HomeBloc {
  final _stream = StreamController<String>.broadcast();
  Sink<String> get consult => _stream.sink;
  Stream<ConsultState> get state => _stream.stream.switchMap(_consultCNPJ);

  Stream<ConsultState> _consultCNPJ(String value) async* {
    yield ConsultStateLoading();
    try {
      final response =
          await Dio().get('https://www.receitaws.com.br/v1/cnpj/$value');
      if (response.data['nome'] == null) {
        yield ConsultStateFailure('CNPJ inválido!');
      } else {
        yield ConsultStateSucesso(response.data);
      }
    } catch (e) {
      print(e);
      yield ConsultStateFailure('Erro ao realizar consulta de CNPJ');
    }
  }

  void dispose() {
    _stream.close();
  }
}
