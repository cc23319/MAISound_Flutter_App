import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

AudioPlayer player = AudioPlayer();

// Audios (TESTANDO)
const alarmAudioPath = "sound_alarm.mp3";
// player.play(alarmAudioPath);

// Representa a Track
class TrackWidget extends StatelessWidget {
  final Color color = const Color.fromARGB(57, 68, 70, 94);
  final double space = 34;

  const TrackWidget({
    Key? key,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        // Ensure space is not larger than the dimensions to avoid infinity issues
        double adjustedSpace = space;
        if (width < space) adjustedSpace = width;
        if (height < space) adjustedSpace = height;

        var h = Container(width: 2, height: height, color: color);
        var v = Container(width: width, height: 2, color: color);

        return Stack(
          children: <Widget>[
            // ...List.generate(
            //   (width / adjustedSpace).round(),
            //   (index) => Positioned(left: index * adjustedSpace, child: h),
            // ),
            ...List.generate(
              (height / adjustedSpace).round(),
              (index) => Positioned(top: index * adjustedSpace, child: v),
            ),
          ],
        );
      },
    );
  }
}

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
              GestureDetector(
                onTap: () {
                  print("Container clicked");
                },
                child:
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
                    border: Border.all(
                        color: Color.fromARGB(20, 0, 0, 0), width: 2),
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
              )
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
              Expanded(
                child: TrackWidget(),
              ),
            ])));
  }
}
