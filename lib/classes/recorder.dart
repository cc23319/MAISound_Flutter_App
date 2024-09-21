import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maisound/classes/globals.dart';
import 'package:maisound/classes/instrument.dart';
import 'package:maisound/classes/track.dart';

class Recorder {

  // Track atual selecionada (Caso esteja no modo de tocar track individualmente, esta será tocada)
  Track? track;

  // Modo de tocar track individual
  // Caso True: Toca apenas a track selecionada
  // Caso False: Toca o projeto inteiro a partir da timestamp do projeto
  ValueNotifier<bool> playOnlyTrack = ValueNotifier<bool>(false);

  // Posição relativa da track selecionada atual
  // Esta é a posição da track em relação ao projeto inteiro
  double absoluteTrackPosition = 0.0;

  // Timestamp na track atual (É uma posição relativa)
  ValueNotifier<double> currentTimestamp = ValueNotifier<double>(0.0);

  // Timestamp no projeto inteiro (É uma posição absoluta)
  ValueNotifier<double> currentProjectTimestamp = ValueNotifier<double>(0.0);

  // Este timer serve para dar update no recorder
  Timer? _timer;

  // Notas a serem tocadas e paradas
  List<List<dynamic>> toPlay = [];
  List<List<dynamic>> playingNotes = []; // [Note, InstrumentIndex, stopTime]

  Recorder() {
    // Caso a pessoa clique no botão de play, o recorder vai começar/parar de tocar
    playingCurrently.addListener(() {
      if (playingCurrently.value) {
        play();
      } else {
        stop();
      }
    });
  }

  // Muda a timestamp do recorder
  void setTimestamp(double timestamp) {
    currentTimestamp.value = timestamp;
    currentProjectTimestamp.value = timestamp;

    // Caso a musica ainda esteja sendo tocada, para e começa a tocar ela devolta (impede alguns bugs)
    if (playingCurrently.value) {
      stop();
      play();
    }
  }

  void update() {
    // Atualiza a posição da timestamp na track e no projeto
    currentTimestamp.value += BPM / 60;
    currentProjectTimestamp.value += BPM / 60;

    // Toca as notas conforme o tempo passa
    while (toPlay.isNotEmpty && currentTimestamp.value >= toPlay[0][0].startTime) {
      // Remove nota que esta sendo tocada da lista de notas a serem tocadas
      List<dynamic> nextToPlay = toPlay.removeAt(0);
      Note note = nextToPlay[0];
      int instrumentIndex = nextToPlay[1];

      // Toca a nota
      instruments[instrumentIndex].playSound(note.noteName);

      // Calcula quando deve parar de tocar e adiciona a lista de notas a serem paradas
      double stopTime = note.startTime + note.duration;
      playingNotes.add([note, instrumentIndex, stopTime]);
    }

    // Pare de tocar as notas que passaram do tempo de duração
    for (int i = playingNotes.length - 1; i >= 0; i--) {
      List<dynamic> playingNote = playingNotes[i];
      Note note = playingNote[0];
      int instrumentIndex = playingNote[1];
      double stopTime = playingNote[2];

      if (currentTimestamp.value >= stopTime) {
        instruments[instrumentIndex].stopSound(note.noteName);
        playingNotes.removeAt(i);
      }
    }

    // if (toPlay.isEmpty && playingNotes.isEmpty) {
    //   stop();
    // }
  }

  // Defini qual é a track atualmente selecionada e sua posição absoluta no projeto
  void setTrack(Track? track, double absoluteTrackPosition) {
    this.track = track;
    this.absoluteTrackPosition = absoluteTrackPosition;
  }
  
  // Começa a tocar a musica
  void play() {
    stop();

    // Modo de track unica
    // Procura por todas as notas que serão tocadas a partir do momento atual
    if (playOnlyTrack.value && track != null) {
      List<Note> notes = track!.getNotes();
      int instrumentIndex = instruments.indexOf(track!.instrument);

      for (int i = 0; i < notes.length; i++) {
        Note note = notes[i];

        if (currentTimestamp.value <= note.startTime) {
          toPlay.add([note, instrumentIndex]);
        }
      }
    }
    
    // Modo de tocar o projeto inteiro (multiplas tracks simultaneamente)
    if (!playOnlyTrack.value) {

    }

    // Começa o update do recorder
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      update();
    });
  }

  // Para o recorder e limpa algumas listas
  void stop() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }

    toPlay.clear();
    playingNotes.clear();
  }

}