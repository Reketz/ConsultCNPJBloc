import 'package:consult_cnpj_bloc/bloc/home_bloc.dart';
import 'package:consult_cnpj_bloc/states/consult_state.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final textController = TextEditingController();
  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CNPJ'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Digite o CNPJ'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  homeBloc.consult.add(textController.text);
                },
                child: Text('Consultar')),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<ConsultState>(
              stream: homeBloc.state,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                var consultState = snapshot.data;
                if (consultState is ConsultStateLoading) {
                  return Expanded(
                    child: Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (consultState is ConsultStateFailure) {
                  return Text(
                    '${consultState.message}',
                    style: TextStyle(color: Colors.red),
                  );
                }
                consultState = consultState as ConsultStateSucesso;
                return Text('${consultState.data['nome']}');
              },
            )
          ],
        ),
      ),
    );
  }
}
