import 'package:consult_cnpj_flutter_bloc/bloc/home_bloc.dart';
import 'package:consult_cnpj_flutter_bloc/states/consult_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final textController = TextEditingController();

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
                  context.read<HomeBloc>().add(textController.text);
                },
                child: Text('Consultar')),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<HomeBloc, ConsultState>(
              builder: (context, state) {
                var consultState = state;
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
