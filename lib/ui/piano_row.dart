import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maisound/classes/globals.dart';
import 'package:maisound/classes/instrument.dart';
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

  // Quantas repartições (Snap to grid) existem horizontalmente
  // 1 = 1 repartição a cada 1 minuto
  double snap_step = 32;

  // Usado para calcular a posição inicial relativa do mouse ao arrastar notas horizontalmente
  double? initialMouseOffsetX;
  double? initialNoteDuration;
  double lastNoteDuration = 64;

  // Notes that are being played currently
  List<Note> playing_notes = [];
  void _updateMarkerPosition(double newPosition) {
    // Play music
    if (playingCurrently.value) {
      for(var i = 0; i < widget.track.notes.length; i++){
        Note current_note = widget.track.notes[i];

        if (playing_notes.contains(current_note)) {
          if (_markerPosition < current_note.startTime || _markerPosition > current_note.startTime + current_note.duration) {
            playing_notes.remove(current_note);
            widget.track.instrument.stopSound(current_note.noteName);
          }
        } else {
          if (_markerPosition > current_note.startTime && _markerPosition < current_note.startTime + current_note.duration) {
            playing_notes.add(current_note);
            widget.track.instrument.playSound(current_note.noteName);
          }
        }
      }
    }

    setState(() {
      _markerPosition = newPosition;
    });
  }

  // Lista de notas na vertical
  final List<Map<String, bool>> _notes = [
    {'C4': false},
    {'C#4': true},
    {'D4': false},
    {'D#4': true},
    {'E4': false},
    {'F4': false},
    {'F#4': true},
    {'G4': false},
    {'G#4': true},
    {'A4': false},
    {'A#4': true},
    {'B4': false},
    {'C5': false},
    {'C#5': true},
    {'D5': false},
    {'D#5': true},
    {'E5': false},
    {'F5': false},
    {'F#5': true},
    {'G5': false},
    {'G#5': true},
    {'A5': false},
    {'A#5': true},
    {'B5': false},
  ];

  // Quando alguma nota é pressionada esta função e chamada
  void _onNotePressed(String note) {
    widget.track.instrument.playSound(note);
    //print('$note pressed');
  }

  // Quando alguma nota para de ser pressionada esta função é chamada
  void _onNoteReleased(String note) {
    widget.track.instrument.stopSound(note);
    //print('$note released');
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
                            double height = (note.keys.first[0] == 'B' ||
                                    note.keys.first[0] == 'C' ||
                                    note.keys.first[0] == 'E' ||
                                    note.keys.first[0] == 'F')
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
                              double topPadding = 80;
                                  // (note.keys.first.startsWith('C#') ||
                                  //         note.keys.first.startsWith('F#'))
                                  //     ? 40
                                  //     : 80; // Default padding
                              if (note.keys.first.startsWith('F#') ||
                                  note.keys.first.startsWith('G#') ||

                                  note.keys.first.startsWith('C#')) {
                                topPadding =
                                    40; // Adjust padding for black notes after B/E
                              }

                              // HACK
                              // The first black key top to bottom, has a smaller padding
                              if (note.keys.first == "A#5") {
                                topPadding = 40;
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
                    child: Stack(
                      children: [
                        
                        // The grid itself
                        Container(
                          color: Colors.transparent, // Background of the grid
                          child: GridView.builder(
                            itemCount: _notes.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // 1 column for each grid
                              mainAxisExtent: 40,
                            ),
                            itemBuilder: (context, index) {
                              return DragTarget<Note>(
                                onWillAccept: (data) {
                                  // Optionally highlight the grid when dragging over it
                                  return true;
                                },
                                onAccept: (Note draggedNote) {
                                  // Update note position to the new grid row
                                  setState(() {
                                    draggedNote.noteName = _notes[_notes.length - index - 1].keys.first;
                                  });
                                },
                                builder: (context, candidateData, rejectedData) {
                                  return GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      double clickXPosition = details.localPosition.dx;

                                      // Converte posição do mouse em posição de grid
                                      clickXPosition = (clickXPosition / snap_step).floor() * snap_step;

                                      // The note being pressed
                                      String notePressed = _notes[_notes.length - index - 1].keys.first;

                                      // Play the note
                                      if (!playingCurrently.value) {
                                        _onNotePressed(notePressed);
                                      }

                                      // Add a note to the track
                                      widget.track.notes.add(Note(
                                        noteName: notePressed, 
                                        startTime: clickXPosition, 
                                        duration: lastNoteDuration, // Example duration for now
                                      ));
                                      setState(() {}); // Rebuild the widget to reflect the new note
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      // The note being released
                                      String noteReleased = _notes[_notes.length - index - 1].keys.first;
                                      _onNoteReleased(noteReleased);
                                    },
                                    child: Container(
                                      height: 56, // Fixed height for each grid row
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: const Color.fromARGB(255, 0, 0, 0),
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: Color.fromARGB(54, 5, 5, 5), // Background color of the grid
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // Vertical grid lines overlaid using the CustomPainter
                        Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(
                              painter: VerticalGridPainter(stepGrid: snap_step),
                            ),
                          ),
                        ),

                        // Display the notes as draggable rectangles on top of the grid
                        ...widget.track.notes.map((note) {
                          // Reverse the vertical positioning for correct display
                          int noteIndex = _notes.indexWhere((n) => n.keys.first == note.noteName);
                          double topPosition = (_notes.length - noteIndex - 1) * 40; // Reverse index for correct position

                          return Positioned(
                            left: note.startTime, // Horizontal position based on startTime
                            top: topPosition.toDouble(), // Corrected vertical position
                            child: Listener(
                            onPointerDown: (PointerDownEvent event) {
                              // Botao direito (deletar nota)
                              if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
                                widget.track.notes.remove(note);
                                setState(() {});
                              }
                            },
                            child: GestureDetector(
                              onPanStart: (details) {
                                setState(() {
                                  double clickXPosition = details.globalPosition.dx;
                                  double noteXPosition = note.startTime; // The current X position of the note
                                  
                                  // Calculate the offset between the click position and the note's startTime
                                  initialMouseOffsetX = clickXPosition - noteXPosition;
                                });
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  double clickYPosition = details.globalPosition.dy;
                                  int mouseGridY = (clickYPosition / 40).floor();

                                  double clickXPosition = details.globalPosition.dx;
                                  // double mouseGridX = (clickXPosition / (snap_step)).floor() * (snap_step);

                                  // Apply the offset and snap to grid
                                  double adjustedMouseX = clickXPosition - initialMouseOffsetX!;
                                  double mouseGridX = (adjustedMouseX / snap_step).floor() * snap_step;

                                  // Update the horizontal position
                                  // Snap to grid

                                  //note.startTime += details.delta.dx;
                                  note.startTime = mouseGridX;

                                  // Out of bounds
                                  note.startTime = max(note.startTime, 0);

                                  // Calculate the new row based on vertical dragging
                                  int newNoteIndex = (_notes.length + 2) - mouseGridY;//(_notes.length - 1) - mouseGridY;

                                  // Ensure the new index is within valid bounds
                                  if (newNoteIndex >= 0 && newNoteIndex < _notes.length) {
                                    String newNoteName = _notes[newNoteIndex].keys.first;

                                    // Toca um som quando o indice muda
                                    if (note.noteName != newNoteName) {
                                      widget.track.instrument.playSound(newNoteName);

                                      // Para o som anterior
                                      widget.track.instrument.stopSound(note.noteName, fadeOutDuration: const Duration(milliseconds: 5));
                                    }

                                    note.noteName = newNoteName;
                                  }
                                });
                              },
                              onPanEnd: (details) {
                                // When the dragging ends, update the note's final position
                                setState(() {
                                  // Ensure the note's final position is within the grid bounds
                                  if (note.startTime < 0) {
                                    note.startTime = 0;
                                  }
                                });
                              },

                              
                              child: MouseRegion(
                                
                                onHover: (event) {
                                  // Change cursor when near the edges
                                  if (event.localPosition.dx <= 10 || event.localPosition.dx >= note.duration - 10) {
                                    // Show resize cursor
                                    SystemMouseCursors.resizeLeftRight;
                                  } else {
                                    // Default cursor
                                    SystemMouseCursors.click;
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 50, 168, 50),
                                        border: Border.all(color: Color.fromARGB(255, 71, 201, 71), width: 2)
                                      ),
                                      width: note.duration.toDouble(),
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          note.noteName,
                                          style: TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    ),
                                    // Left resize handle
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onPanStart: (details) {
                                          setState(() {
                                            double clickXPosition = details.globalPosition.dx;
                                            double noteXPosition = note.startTime; // The current X position of the note
                                            
                                            // Calculate the offset between the click position and the note's startTime
                                            initialMouseOffsetX = clickXPosition - noteXPosition;
                                          });
                                        },
                              
                                        onPanUpdate: (details) {
                                          setState(() {
                                            double clickXPosition = details.globalPosition.dx;

                                            // Apply the offset and snap to grid
                                            double adjustedMouseX = clickXPosition - initialMouseOffsetX!;
                                            double mouseGridX = (adjustedMouseX / snap_step).floor() * snap_step;
                                            
                                            // Adjust startTime and duration when resizing from the left
                                            double difference = note.startTime - mouseGridX;

                                            if (mouseGridX >= note.startTime + note.duration) {
                                              return;
                                            }

                                            if (mouseGridX < 0) {
                                              return;
                                            }


                                            note.startTime = mouseGridX;
                                            note.duration += difference;

                                            if (note.duration < snap_step) {
                                              note.duration = snap_step; // Minimum duration limit
                                            }
                                            
                                          });
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.resizeLeftRight,
                                          child: Container(
                                            width: 10, // Handle width
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Right resize handle
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onPanStart: (details) {
                                          setState(() {
                                            double clickXPosition = details.globalPosition.dx;
                                            double noteXPosition = note.startTime; // The current X position of the note
                                            
                                            // Calculate the offset between the click position and the note's startTime
                                            initialMouseOffsetX = clickXPosition - noteXPosition;

                                            // Save initial note duration
                                            initialNoteDuration = note.duration;
                                          });
                                        },

                                        onPanUpdate: (details) {
                                          setState(() {
                                            double clickXPosition = details.globalPosition.dx;
                                            
                                            // Apply the offset and snap to grid
                                            double adjustedMouseX = clickXPosition - initialMouseOffsetX!;
                                            double mouseGridX = (adjustedMouseX / snap_step).floor() * snap_step;

                                            // Initial duration position
                                            note.duration = initialNoteDuration! + (mouseGridX - note.startTime);

                                            if (note.duration < snap_step) {
                                              note.duration = snap_step; // Minimum duration limit
                                            }
                                            
                                            // Save last note duration
                                            lastNoteDuration = note.duration;
                                          });
                                        },
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.resizeLeftRight,
                                          child: Container(
                                            width: 10, // Handle width
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              )
                              
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //     color: Color.fromARGB(255, 50, 168, 50),
                              //     border: Border.all(color: Color.fromARGB(255, 71, 201, 71), width: 2)
                              //   ),

                              //   width: note.duration.toDouble(), // Duration represented as width
                              //   height: 40, // Fixed height for each note
                              //   //color: Colors.blue.withOpacity(0.6), // Color for the note rectangle
                              //   child: Center(
                              //     child: Text(
                              //       note.noteName,
                              //       style: TextStyle(color: Colors.white, fontSize: 10),
                              //     ),
                              //   ),
                              // ),
                            ),
                            )
                          );
                        }).toList(),
                      ],
                    ),
                  )
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

class VerticalGridPainter extends CustomPainter {
  final double stepGrid; // The value for the vertical grid steps

  VerticalGridPainter({required this.stepGrid});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1) // Vertical grid color
      ..strokeWidth = 1; // Width of the grid lines

    final paint2 = Paint()
      ..color = Colors.black.withOpacity(0.4) // Vertical grid color
      ..strokeWidth = 1;

    // Draw vertical lines based on step_grid value
    for (double x = stepGrid; x < size.width; x += stepGrid) {
      canvas.drawLine(
        Offset(x, 0), // Starting point of the line (x, y)
        Offset(x, size.height), // Ending point of the line (x, y)
        paint,
      );
    }

    // Draw vertical line further apart
    double bigStepGrid = stepGrid * 16;
    for (double x = bigStepGrid; x < size.width; x += bigStepGrid) {
      canvas.drawLine(
        Offset(x, 0), // Starting point of the line (x, y)
        Offset(x, size.height), // Ending point of the line (x, y)
        paint2,
      );
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint in case the step grid changes
  }
}