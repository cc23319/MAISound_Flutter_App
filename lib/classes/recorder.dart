import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maisound/classes/globals.dart';
import 'package:maisound/classes/instrument.dart';
import 'package:maisound/classes/track.dart';

class Recorder {

  // No track means it's being used to play the entire project
  Track? track;
  ValueNotifier<bool> playOnlyTrack = ValueNotifier<bool>(false);
  double relativeTrackPosition = 0.0;

  // Current timestamp (Could be relative to the current track or the project structure)
  ValueNotifier<double> currentTimestamp = ValueNotifier<double>(0.0); // Track relative timestamp
  ValueNotifier<double> currentProjectTimestamp = ValueNotifier<double>(0.0); // Global timestamp

  Timer? _timer;

  // Notes to be played (In order)
  // [Note, InstrumentIndex]
  List<List<dynamic>> toPlay = [];
  List<List<dynamic>> playingNotes = []; // To track currently playing notes [Note, InstrumentIndex, stopTime]

  Recorder() {
    playingCurrently.addListener(() {
      if (playingCurrently.value) {
        play();
      } else {
        stop();
      }
    });
  }

  void setTimestamp(double timestamp) {
    currentTimestamp.value = timestamp;
    currentProjectTimestamp.value = timestamp;

    if (playingCurrently.value) {
      stop();
      play();
    }
  }

  void update() {
    currentTimestamp.value += BPM / 60;
    currentProjectTimestamp.value += BPM / 60;

    // Play the notes when their start time comes
    while (toPlay.isNotEmpty && currentTimestamp.value >= toPlay[0][0].startTime) {
      List<dynamic> nextToPlay = toPlay.removeAt(0);
      Note note = nextToPlay[0];
      int instrumentIndex = nextToPlay[1];

      // Play the note
      instruments[instrumentIndex].playSound(note.noteName);

      // Calculate when to stop the note and add it to the playingNotes list
      double stopTime = note.startTime + note.duration;
      playingNotes.add([note, instrumentIndex, stopTime]);
    }

    // Stop notes whose duration has passed
    for (int i = playingNotes.length - 1; i >= 0; i--) {
      List<dynamic> playingNote = playingNotes[i];
      Note note = playingNote[0];
      int instrumentIndex = playingNote[1];
      double stopTime = playingNote[2];

      if (currentTimestamp.value >= stopTime) {
        // Stop the note
        instruments[instrumentIndex].stopSound(note.noteName);

        // Remove it from the playingNotes list
        playingNotes.removeAt(i);
      }
    }

    // if (toPlay.isEmpty && playingNotes.isEmpty) {
    //   stop();
    // }
  }

  void setTrack(Track? track, double relativeTrackPosition) {
    this.track = track;
    this.relativeTrackPosition = relativeTrackPosition;
  }

  void play() {
    stop();

    // Start playing
    // Search the notes that are going to be played

    // Single track
    if (playOnlyTrack.value && track != null) {
      List<Note> notes = track!.getNotes();
      int instrumentIndex = instruments.indexOf(track!.instrument);

      // Pega todas as notas que serão tocadas
      for (int i = 0; i < notes.length; i++) {
        Note note = notes[i];

        if (currentTimestamp.value <= note.startTime) {
          toPlay.add([note, instrumentIndex]);
        }
      }
    }
    
    // Project tracks
    if (!playOnlyTrack.value) {

    }

    // Start the timer to call update every millisecond
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      update();
    });
  }

  void stop() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }

    toPlay.clear();
    playingNotes.clear();
  }

}