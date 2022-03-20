// ignore_for_file: deprecated_member_use, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool VezDoO = true; //o primeiro jogador é o O!
List<String> blocos = ['', '', '', '', '', '', '', '', ''];

var EstiloTexto = const TextStyle(color: Colors.white, fontSize: 30);

int placarO = 0;
int placarX = 0;
int caixasPreenchidas = 0;

class _HomePageState extends State<HomePage> {
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Jogador X',
                          style: EstiloTexto,
                        ),
                        Text(
                          placarX.toString(),
                          style: EstiloTexto,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Jogador O',
                          style: EstiloTexto,
                        ),
                        Text(
                          placarO.toString(),
                          style: EstiloTexto,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: 450,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _clicar(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Center(
                          child: Text(
                            blocos[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _clicar(int index) {
    setState(() {
      if (VezDoO && blocos[index] == '') {
        blocos[index] = 'o';
        caixasPreenchidas += 1;
      } else if (!VezDoO && blocos[index] == '') {
        blocos[index] = 'x';
        caixasPreenchidas += 1;
      }
      VezDoO = !VezDoO;
      _checarVencedor();
    });
  }

  void _checarVencedor() {
    if (blocos[0] == blocos[1] && blocos[0] == blocos[2] && blocos[0] != '') {
      _mostraVencedor(blocos[0]);
    }
    if (blocos[3] == blocos[4] && blocos[3] == blocos[5] && blocos[3] != '') {
      _mostraVencedor(blocos[3]);
    }
    if (blocos[6] == blocos[7] && blocos[6] == blocos[8] && blocos[6] != '') {
      _mostraVencedor(blocos[6]);
    }
    if (blocos[0] == blocos[3] && blocos[0] == blocos[6] && blocos[0] != '') {
      _mostraVencedor(blocos[0]);
    }
    if (blocos[1] == blocos[4] && blocos[1] == blocos[7] && blocos[1] != '') {
      _mostraVencedor(blocos[1]);
    }
    if (blocos[2] == blocos[5] && blocos[2] == blocos[8] && blocos[2] != '') {
      _mostraVencedor(blocos[2]);
    }
    if (blocos[6] == blocos[4] && blocos[6] == blocos[2] && blocos[6] != '') {
      _mostraVencedor(blocos[6]);
    }
    if (blocos[0] == blocos[4] && blocos[0] == blocos[8] && blocos[0] != '') {
      _mostraVencedor(blocos[0]);
    } else if (caixasPreenchidas == 9) {
      _mostraEmpate();
    }
  }

  void _mostraVencedor(String Vencedor) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('O VENCEDOR É: ' + Vencedor + '!'),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue[100],
                onPressed: () {
                  _limpaTabuleiro();
                  Navigator.of(context).pop();
                },
                child: const Text('Jogue de novo!'),
              ),
            ],
          );
        });

    if (Vencedor == 'o') {
      placarO += 1;
    } else if (Vencedor == 'x') {
      placarX += 1;
    }
    _limpaTabuleiro();
  }

  void _mostraEmpate() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('DEU VÉIA'),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue[100],
                onPressed: () {
                  _limpaTabuleiro();
                  Navigator.of(context).pop();
                },
                child: const Text('Jogue de novo!'),
              ),
            ],
          );
        });
  }

  void _limpaTabuleiro() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        blocos[i] = "";
      }
    });
    caixasPreenchidas = 0;
  }
}
