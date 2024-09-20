import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:maisound/classes/globals.dart';
// For rootBundle


class Note {
  String noteName;
  double startTime;
  double duration;

  Note({
    required this.noteName,
    required this.startTime,
    required this.duration
  });

  @override
  String toString() {
    return "Note: $noteName, Start Time: $startTime, Duration: $duration";
  }
}


class Instrument {
  Map<String, String> sounds = {};
  Map<String, AudioPlayer> activePlayers = {}; // Store active players for each note
  Map<String, bool> isFadingOut = {}; // Track whether a fade-out is in progress for each note
  double volume = 0.5;
  String name = "Piano";
  Color color = Color.fromARGB(255, 60, 104, 248);
  int maxSimultaneousNotes = 10; // Limit the number of notes played at the same time
  List<String> activeNotesOrder = []; // Track order of active notes
  
  Instrument() {
    loadSounds();
  }

  void playSound(String key) async {
    key = key.toUpperCase();

    // Verifica se a nota existe
    if (!sounds.containsKey(key)) {
      return;
    }

    // Se já há notas ativas, para a mais antiga
    if (activePlayers.length >= maxSimultaneousNotes) {
      String oldestNote = activeNotesOrder.removeAt(0); // Remove o mais antigo
      stopSound(oldestNote); // Para a nota mais antiga
    }

    // Stop the current note if it's being played to allow quick repetitions
    if (activePlayers.containsKey(key)) {
      stopSound(key);
    }

    // Cria um novo AudioPlayer para tocar o som
    AudioPlayer notePlayer = AudioPlayer();
    
    // Define o volume inicial
    notePlayer.setVolume(volume * master_volume);

    // Toca o som usando assets
    await notePlayer.play(AssetSource(sounds[key]!));
    
    // Armazena o player no map
    activePlayers[key] = notePlayer;
    activeNotesOrder.add(key); // Adiciona à lista de notas ativas
    isFadingOut[key] = false;

    // Libera o recurso do player após o término da reprodução
    notePlayer.onPlayerComplete.listen((event) {
      activePlayers.remove(key); // Remove o player do map quando terminar
      activeNotesOrder.remove(key); // Remove a nota ativa
      isFadingOut.remove(key); // Remove o flag de fade-out
      notePlayer.dispose();
    });
  }

  // Para todos os sons
  void fullStopAllSounds() {
    for (String key in activePlayers.keys.toList()) {
      stopSound(key);
    }
  }

  void stopSound(String key, {Duration fadeOutDuration = const Duration(milliseconds: 250)}) async {
    key = key.toUpperCase();

    // Check if there's a player playing this note
    if (activePlayers.containsKey(key)) {
      AudioPlayer notePlayer = activePlayers[key]!;

      // If a fade-out is already in progress, do not start another
      if (isFadingOut[key] == true) {
        return;
      }

      // Mark that fade-out is in progress
      isFadingOut[key] = true;

      // Gradually reduce the volume
      await fadeOut(notePlayer, fadeOutDuration, key);

      // If the fade-out was not interrupted, stop the player
      if (isFadingOut[key] == true) {
        await notePlayer.stop();
        activePlayers.remove(key);
        activeNotesOrder.remove(key);
        isFadingOut.remove(key);
        notePlayer.dispose();
      }
    }
  }

  Future<void> fadeOut(AudioPlayer player, Duration duration, String key) async {
    double initialVolume = player.volume;
    int steps = 20; // Number of steps for fading out
    double volumeStep = initialVolume / steps;
    int stepDuration = (duration.inMilliseconds / steps).round();

    for (int i = 0; i < steps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration));

      // If fade-out was interrupted, exit early
      if (isFadingOut[key] == false) {
        return;
      }

      // Calculate new volume
      double newVolume = initialVolume - (i + 1) * volumeStep;
      if (newVolume < 0) newVolume = 0;

      // Set the new volume
      try {
        await player.setVolume(newVolume);
      } catch (e) {
        print(e); // If setting volume fails, exit the loop
      }
    }
  }


  // Carrega os sons dos assets (mesmo método que você já tem)
  Future<void> loadSounds() async {
    // Adiciona os caminhos das notas manualmente
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
  }

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

  String normalizeName(String key) {
    String normalKey = "";
    if (isNumeric(key[0])) {
      List<String> parts = key.split("-");
      String octave = parts[0];
      String keyName = parts[1];

      normalKey += keyName[0];
      if (keyName.length == 2) {
        normalKey += "#";
      }
      normalKey += octave;
    } else {
      normalKey = key;
    }

    return normalKey.toUpperCase();
  }
}
