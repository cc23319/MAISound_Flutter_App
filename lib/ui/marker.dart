import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maisound/classes/globals.dart';

// Retorna a linha que estende do marcador
Widget getLine(_markerPosition, screenHeight) {
  // Thin line extending from marker to the bottom of the screen
  return Positioned(
    left: _markerPosition - 0.5, // Align the line with the marker's position
    top: 15, // Start just below the marker
    child: Container(
      width: 1, // Thin line
      height: screenHeight - 30, // Extend to the bottom of the screen
      color: Colors.green, // Line color (same as the marker)
    ),
  );
}

class TimestampMarker extends StatefulWidget {
  final Function(double) onPositionChanged; // Callback for position changes

  TimestampMarker({required this.onPositionChanged}); // callback

  @override
  _TimestampMarkerState createState() => _TimestampMarkerState();
}

class _TimestampMarkerState extends State<TimestampMarker> {
  // Posição do marcador
  double _markerPosition = 0.0;

  // Timer utilizado para aumentar a posição do marcador
  Timer? _timer;

  // Começa a incrementar a posição do marcador com base no BPM
  void _startIncrementing() {
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      _markerPosition += BPM / 60;
      widget.onPositionChanged(_markerPosition); // Notifica a classe pai
    });
  }

  // Para a incremnetação
  void _stopIncrementing() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  // Quando esta classe é deixada de lado para de incrementar
  @override
  void dispose() {
    _stopIncrementing();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Escuta a variavel global de tocar a musica
    playingCurrently.addListener(() {
      if (playingCurrently.value) {
        _startIncrementing();
      } else {
        _stopIncrementing();
      }
    });
  }

  void _onTap(BuildContext context, TapDownDetails details) {
    // Pega posição X relativa ao container
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    setState(() {
      _markerPosition = localPosition.dx;

      // Notifica a classe pai da mudança
      widget.onPositionChanged(_markerPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onTap(context, details),
      child: Container(
        height: 15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.4), // Mais escuro ao topo
              Colors.black.withOpacity(0.1), // Mais claro embaixo
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: _markerPosition - 10, // Offset na seta
              top: 0,
              child: Icon(
                Icons.arrow_drop_down,
                size: 20, // Tamanho da seta
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
