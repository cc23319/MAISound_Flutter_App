import 'package:flutter/material.dart';

// Piano
class PianoWidget extends StatelessWidget {
  final int numberOfKeys;
  final double keyWidth;
  final double keyHeight;

  const PianoWidget({
    Key? key,
    required this.numberOfKeys,
    required this.keyWidth,
    required this.keyHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Teclas do piano em ordem (Começando do lá e terminando em sol sustenido)
    const keys = [
      "G#",
      "G",
      "F#",
      "F",
      "E",
      "D#",
      "D",
      "C#",
      "C",
      "B",
      "A#",
      "A",
    ];

    // Implementar oitavas
    // C5? D5? D#5?

    // Teclas brancas menores
    // As teclas brancas adjacentes a um espaço vazio (sem tecla preta) tem uma altura menor
    const smallerKeys = ["E", "F", "B", "C"];

    // Constroi uma lista com todas as teclas do piano
    return ListView.builder(
      itemCount: numberOfKeys,
      itemBuilder: (context, index) {
        // Pega o nome da nota atual
        var key = keys[index % keys.length];

        // Se é uma nota preta ou não (Caso ela contenha o simbolo do sustenido)
        bool isBlack = key.contains("#");

        // Se é uma tecla menor
        bool isSmaller = smallerKeys.contains(key);

        // A gente vai pular as teclas pretas porque a gente ja adiciona elas junto com as brancas
        if (!isBlack) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // White Key
              Container(
                // Largura da tecla
                width: keyWidth,

                // Teclas pretas são menores que as brancas
                // Teclas brancas adjacentes a espaços ausentes de tecla pretas são menores também
                height: isSmaller ? keyHeight - 20 : keyHeight,

                // Margem entre as teclas
                // margin: EdgeInsets.symmetric(vertical: 1),

                // Decoração de uma tecla
                decoration: BoxDecoration(
                  color: !isBlack ? Colors.white : Colors.black,
                  border:
                      Border.all(color: Color.fromARGB(20, 0, 0, 0), width: 2),
                ),

                // A Tecla em sí
                child: Center(
                  child: Text(
                    key, // Texto da tecla, é o nome da nota
                    style: TextStyle(
                        // Se a tecla for preta, o texto é branco, caso contrario o texto é preto
                        color: Colors.black),
                  ),
                ),
              ),

              // Adiciona a tecla preta se a atual nao for menor (não adjacente a uma tecla preta)
              Positioned(
                top: 0,
                bottom: keyHeight * 0.6, // Adjust as necessary
                left: (keyWidth * 0.8) / 2, // Adjust as necessary
                child: Container(
                  width: keyWidth * 0.8, // Adjust as necessary
                  height: keyHeight * 0.6, // Adjust as necessary
                  color: Colors.black,
                ),
              ),
            ],
          );
        } else {
          // Retorna um sizedbox vazio
          return SizedBox();
        }
      },
    );
  }
}

// Barra de cima, com botão de play e tudo mais
class ControlBar extends StatelessWidget {
  const ControlBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}

// Pagina do piano
class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPage();
}

class _TrackPage extends State<TrackPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Piano Track",

        // Tema do aplicativo (Cores etc...)
        theme:
            ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 48, 48, 71)),
        home: Scaffold(
            appBar: AppBar(title: Text('Piano Widget')),
            // Linha
            body: Row(children: [
              SizedBox(
                width: 300,
                //height: 500,
                child: PianoWidget(
                  numberOfKeys: 24, // Change the number of keys as needed
                  keyWidth: 326, // Largura da tecla branca
                  keyHeight: 80, // Altura da tecla branca
                ),
              ),
            ])));
  }
}
