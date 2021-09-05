import 'dart:async';
import 'package:consult_cnpj_flutter_bloc/states/consult_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<String, ConsultState> {
  final Dio dio;
  HomeBloc(this.dio) : super(ConsultStateSucesso({'nome': ''}));

  @override
  Stream<ConsultState> mapEventToState(String value) async* {
    yield ConsultStateLoading();
    try {
      final response =
          await dio.get('https://www.receitaws.com.br/v1/cnpj/$value');
      if (response.data['nome'] == null) {
        yield ConsultStateFailure('CNPJ inválido!');
      } else {
        yield ConsultStateSucesso(response.data);
      }
    } catch (e) {
      yield ConsultStateFailure('Erro ao realizar consulta de CNPJ');
    }
  }
}
