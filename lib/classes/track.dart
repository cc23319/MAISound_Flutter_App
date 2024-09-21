import 'package:maisound/classes/instrument.dart';

class Track {
  // Instrumento associado a esta track
  late Instrument instrument;
  
  // Notas associada a esta track
  // Formato [[Name, Start, Duration] ...]
  late List<Note> notes = [];

  // Duração da track
  // A duração da track é a posição da ultima nota + seu tamanho
  double duration = 128.0;

  // Distancia entre a nota mais aguda e mais grave (Quantas notas tem entre elas)
  int lowestNoteIndex = -1;
  int highestNoteIndex = -1;
  int noteRange = -1;

  void addNote(Note note) {
    notes.add(note);
    notes.sort((a, b) => a.startTime.compareTo(b.startTime));

    int noteAsInteger = note.noteNameToInteger();
    if (lowestNoteIndex == -1 || noteAsInteger < lowestNoteIndex) {
      lowestNoteIndex = noteAsInteger;
      noteRange = highestNoteIndex - lowestNoteIndex;
    }

    if (highestNoteIndex == -1 || noteAsInteger > highestNoteIndex) {
      highestNoteIndex = noteAsInteger;
      noteRange = highestNoteIndex - lowestNoteIndex;  
    }

    double noteEnd = note.startTime + note.duration;
    if (noteEnd > duration) {
      duration = noteEnd;
    }
  }

  void removeNote(Note note) {
    notes.remove(note);
  }

  Track(Instrument inst) {
    instrument = inst;
    //notes = List.empty();
  }
}