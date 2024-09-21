import 'package:maisound/classes/instrument.dart';

class Track {
  // Instrumento associado a esta track
  late Instrument instrument;
  
  // Notas associada a esta track
  // Formato [[Name, Start, Duration] ...]
  late List<Note> notes = [];

  // Quando a track começa no projeto
  double startTime = 0.0;

  // Duração da track
  // A duração da track é a posição da ultima nota + seu tamanho
  double duration = 128.0;

  // Distancia entre a nota mais aguda e mais grave (Quantas notas tem entre elas)
  int lowestNoteIndex = -1;
  int highestNoteIndex = -1;
  int noteRange = -1;

  // Retorna as notas em ordem
  List<Note> getNotes() {
    return notes;
  }

  void addNote(Note note) {
    notes.add(note);

    // As notas são organizadas em ordem temporal
    notes.sort((a, b) => a.startTime.compareTo(b.startTime));

    // Converte uma nota em um numero inteiro
    // Procura pela nota mais alta, mais baixa e mais distante (a partir do ponto de inicio)
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