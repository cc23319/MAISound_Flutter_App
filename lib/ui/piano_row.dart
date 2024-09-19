import 'package:flutter/material.dart';
import 'package:maisound/classes/track.dart';
import 'package:maisound/ui/marker.dart';

class NoteWidget extends StatefulWidget {
  final String note;
  final bool isBlack;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final VoidCallback onReleased;

  const NoteWidget({
    required this.note,
    required this.isBlack,
    this.width = 250,
    this.height = 60,
    required this.onPressed,
    required this.onReleased,
  });

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        widget.onPressed();
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onReleased();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
        widget.onReleased();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _isPressed
              ? (widget.isBlack
                  ? Color.fromARGB(255, 29, 29, 29)
                  : Colors.white70)
              : (widget.isBlack ? Colors.black : Colors.white),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            widget.note,
            style: TextStyle(
              color: widget.isBlack ? Colors.white : Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class PianoRowWidget extends StatefulWidget {
  final Track track;
  const PianoRowWidget({super.key, required this.track});

  @override
  _PianoRowWidgetState createState() => _PianoRowWidgetState();
}

class _PianoRowWidgetState extends State<PianoRowWidget> {
  // Posição do marcador de tempo na track
  double _markerPosition = 0.0;

  void _updateMarkerPosition(double newPosition) {
    setState(() {
      _markerPosition = newPosition;
    });
  }

  // Lista de notas na vertical
  final List<Map<String, bool>> _notes = [
    {'C3': false},
    {'C#3': true},
    {'D3': false},
    {'D#3': true},
    {'E3': false},
    {'F3': false},
    {'F#3': true},
    {'G3': false},
    {'G#3': true},
    {'A3': false},
    {'A#3': true},
    {'B3': false},
  ];

  // Quando alguma nota é pressionada esta função e chamada
  void _onNotePressed(String note) {
    widget.track.instrument.playSound(note);
    print('$note pressed');
  }

  // Quando alguma nota para de ser pressionada esta função é chamada
  void _onNoteReleased(String note) {
    widget.track.instrument.stopSound(note);
    print('$note released');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Column(
          children: [
            // Marcador
            Padding(
              padding: EdgeInsets.only(left: 200),
              child: TimestampMarker(onPositionChanged: _updateMarkerPosition),
            ),

            // Layout com piano ao lado esquerdo e grid ao lado direito
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notas verticais
                  SizedBox(
                    width: 200, // Largura das teclas brancas
                    child: Stack(
                      children: [
                        // Notas Brancas
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _notes.reversed
                              .where((note) => !note.values.first)
                              .map((note) {
                            // Notas brancas que são menores que o normal
                            // Isso serve para que a GRID fique alinhada corretamente
                            double height = (note.keys.first == 'B3' ||
                                    note.keys.first == 'C3' ||
                                    note.keys.first == 'E3' ||
                                    note.keys.first == 'F3')
                                ? 60
                                : 80;
                            return NoteWidget(
                              note: note.keys.first,
                              isBlack: false,
                              height: height,

                              // Funções da nota
                              onPressed: () => _onNotePressed(note.keys.first),
                              onReleased: () =>
                                  _onNoteReleased(note.keys.first),
                            );
                          }).toList(),
                        ),

                        // Notas pretas
                        Positioned.fill(
                          child: Column(
                            children: _notes.reversed
                                .where((note) => note.values.first)
                                .map((note) {
                              // Offset com base em algumas nota branca (Algumas notas pretas tem mais espaços entre elas)
                              double topPadding =
                                  (note.keys.first.startsWith('C#') ||
                                          note.keys.first.startsWith('F#'))
                                      ? 40
                                      : 80; // Default padding
                              if (note.keys.first.startsWith('F#') ||
                                  note.keys.first.startsWith('G#') ||
                                  note.keys.first.startsWith('A#')) {
                                topPadding =
                                    40; // Adjust padding for black notes after B/E
                              }

                              return Padding(
                                padding: EdgeInsets.only(top: topPadding),
                                child: SizedBox(
                                  height: 40, // Black keys remain smaller
                                  child: NoteWidget(
                                    note: note.keys.first,
                                    isBlack: true,
                                    width:
                                        197 / 1.5, // Fixed width for black keys
                                    // Note functions
                                    onPressed: () =>
                                        _onNotePressed(note.keys.first),
                                    onReleased: () =>
                                        _onNoteReleased(note.keys.first),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Grid se extendendo a direita
                  Expanded(
                    child: Container(
                      color: Colors.transparent, // Background da grid
                      child: GridView.builder(
                        itemCount: _notes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // 1 coluna para cada grid
                          mainAxisExtent: 40,
                          //childAspectRatio: 1, // Adjust for note height
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 56, // Altura fixa para cada linha da grid
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    width: 0.5),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Add content for each grid row, if needed
                                Expanded(
                                  child: Container(
                                    color: Color.fromARGB(54, 5, 5,
                                        5), // Background color of the grid
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Linha da seta/marcador
        getLine(_markerPosition, screenHeight, 200),
      ],
    );
  }
}

class NoteGridWidget extends StatefulWidget {
  const NoteGridWidget({super.key});

  @override
  _NoteGridWidgetState createState() => _NoteGridWidgetState();
}

class _NoteGridWidgetState extends State<NoteGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: []),
    );
  }
}
