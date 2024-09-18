import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// For rootBundle

class Instrument {
  // Som de cada posição da tecla
  Map<String, String> sounds = {};
  late AudioPlayer player;
  double volume = 0.5;

  // Usado na parte de UI
  String name = "Piano";
  Color color = Color.fromARGB(255, 60, 104, 248);
  

  // Track, som de cada track deste insturmento
  // Tracks: [Track 0: [NoteName, Time, Duration], Track ...]
  late List tracks;

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
    tracks = List.empty();
  }

  // Carrega os sons dos assets
  Future<void> loadSounds() async {
    // Adiciona os caminhos das notas manualmente
    sounds["C1"] = "instruments/piano/3-c.wav";
    sounds["C#1"] = "instruments/piano/3-cs.wav";
    sounds["D1"] = "instruments/piano/3-d.wav";
    sounds["D#1"] = "instruments/piano/3-ds.wav";
    sounds["E1"] = "instruments/piano/3-e.wav";
    sounds["F1"] = "instruments/piano/3-f.wav";
    sounds["F#1"] = "instruments/piano/3-fs.wav";
    sounds["G1"] = "instruments/piano/3-g.wav";
    sounds["G#1"] = "instruments/piano/3-gs.wav";
    sounds["A1"] = "instruments/piano/3-a.wav";
    sounds["A#1"] = "instruments/piano/3-as.wav";
    sounds["B1"] = "instruments/piano/3-b.wav";
    sounds["C2"] = "instruments/piano/3-c.wav";
    sounds["C#2"] = "instruments/piano/3-cs.wav";
    sounds["D2"] = "instruments/piano/3-d.wav";
    sounds["D#2"] = "instruments/piano/3-ds.wav";
    sounds["E2"] = "instruments/piano/3-e.wav";
    sounds["F2"] = "instruments/piano/3-f.wav";
    sounds["F#2"] = "instruments/piano/3-fs.wav";
    sounds["G2"] = "instruments/piano/3-g.wav";
    sounds["G#2"] = "instruments/piano/3-gs.wav";
    sounds["A2"] = "instruments/piano/3-a.wav";
    sounds["A#2"] = "instruments/piano/3-as.wav";
    sounds["B2"] = "instruments/piano/3-b.wav";
    sounds["C3"] = "instruments/piano/3-c.wav";
    sounds["C#3"] = "instruments/piano/3-cs.wav";
    sounds["D3"] = "instruments/piano/3-d.wav";
    sounds["D#3"] = "instruments/piano/3-ds.wav";
    sounds["E3"] = "instruments/piano/3-e.wav";
    sounds["F3"] = "instruments/piano/3-f.wav";
    sounds["F#3"] = "instruments/piano/3-fs.wav";
    sounds["G3"] = "instruments/piano/3-g.wav";
    sounds["G#3"] = "instruments/piano/3-gs.wav";
    sounds["A3"] = "instruments/piano/3-a.wav";
    sounds["A#3"] = "instruments/piano/3-as.wav";
    sounds["B3"] = "instruments/piano/3-b.wav";
    sounds["C4"] = "instruments/piano/4-c.wav";
    sounds["C#4"] = "instruments/piano/4-cs.wav";
    sounds["D4"] = "instruments/piano/4-d.wav";
    sounds["D#4"] = "instruments/piano/4-ds.wav";
    sounds["E4"] = "instruments/piano/4-e.wav";
    sounds["F4"] = "instruments/piano/4-f.wav";
    sounds["F#4"] = "instruments/piano/4-fs.wav";
    sounds["G4"] = "instruments/piano/4-g.wav";
    sounds["G#4"] = "instruments/piano/4-gs.wav";
    sounds["A4"] = "instruments/piano/4-a.wav";
    sounds["A#4"] = "instruments/piano/4-as.wav";
    sounds["B4"] = "instruments/piano/4-b.wav";
    sounds["C5"] = "instruments/piano/5-c.wav";
    sounds["C#5"] = "instruments/piano/5-cs.wav";
    sounds["D5"] = "instruments/piano/5-d.wav";
    sounds["D#5"] = "instruments/piano/5-ds.wav";
    sounds["E5"] = "instruments/piano/5-e.wav";
    sounds["F5"] = "instruments/piano/5-f.wav";
    sounds["F#5"] = "instruments/piano/5-fs.wav";
    sounds["G5"] = "instruments/piano/5-g.wav";
    sounds["G#5"] = "instruments/piano/5-gs.wav";
    sounds["A5"] = "instruments/piano/5-a.wav";
    sounds["A#5"] = "instruments/piano/5-as.wav";
    sounds["B5"] = "instruments/piano/5-b.wav";

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
