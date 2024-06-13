import 'package:audioplayers/audioplayers.dart';
// For rootBundle

class Instrument {
  // Som de cada posição da tecla
  Map<String, String> sounds = {};
  late AudioPlayer player;

  // Checa se um caractere é um número
  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    try {
      double.parse(s);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Pega uma string que representa uma nota de um instrumento, e normaliza ela para um padrão
  // O padrão é por exemplo C#5 ou A3
  String normalizeName(String key) {
    // String padronizada final
    String normalKey = "";

    // Se na primeira posição da tecla tem um número
    // Quer dizer que o padrão é por exemplo 6-cs -> que vira C#6
    if (isNumeric(key[0])) {
      List<String> parts = key.split("-"); // Dividi a string em duas partes
      String octave = parts[0];
      String keyName = parts[1];

      normalKey += keyName[0]; // Adiciona o nome da tecla na string normalizada

      // Tira o S do nome da tecla e troca por um #
      // Se keyName tiver tamanho 2, quer dizer que é sustenida
      if (keyName.length == 2) {
        normalKey += "#";
      }

      // Adiciona a oitava
      normalKey += octave;
    } else {
      // Caso não seja nenhuma das opções acimas, presumimos que a string já esta correta
      normalKey = key;
    }

    // Deixa em uppercase
    normalKey = normalKey.toUpperCase();

    return normalKey;
  }

  Instrument() {
    loadSounds();
    player = AudioPlayer();
  }

  // Carrega os sons dos assets
  Future<void> loadSounds() async {
    // Adiciona os caminhos das notas manualmente
    sounds["C4"] = "assets/instruments/piano/4-c.wav";
    sounds["C#4"] = "assets/instruments/piano/4-cs.wav";
    sounds["D4"] = "assets/instruments/piano/d.wav";
    // Adicione o restante das notas conforme necessário
    // sounds["D#4"] = "assets/instruments/piano/ds4.wav";
    // ...

    print(sounds);
  }

  // Toca um som de uma nota
  // Recebe como parâmetro uma string representando a tecla
  // Por exemplo "C#5" ou "c#5"
  void playSound(String key) async {
    key = key.toUpperCase();

    // Verifica se a nota existe
    if (!sounds.containsKey(key)) {
      return;
    }

    // Toca o som usando assets
    await player.play(AssetSource(sounds[key]!));
  }
}