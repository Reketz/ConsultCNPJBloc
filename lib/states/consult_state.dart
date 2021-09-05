abstract class ConsultState {}

class ConsultStateSucesso implements ConsultState {
  final Map data;

  ConsultStateSucesso(this.data);
}

class ConsultStateLoading implements ConsultState {}

class ConsultStateFailure implements ConsultState {
  final String message;

  ConsultStateFailure(this.message);
}
