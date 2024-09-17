import 'package:flutter/material.dart';
import 'package:maisound/classes/instrument.dart';

class TimelineWidget extends StatefulWidget {
  final Instrument instrument;

  TimelineWidget({required this.instrument});

  @override
  _TimelineWidgetState createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  final List<Track> _tracks = [];
  static const double _gridSize = 50.0; // Define the grid size

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleSingleTap,
      onDoubleTap: _handleDoubleTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(30, 0, 0, 0),
        ),
        child: Stack(
          children: [
            ..._tracks.map((track) => Positioned(
                  left: track.position.dx,
                  top: track.position.dy,
                  child: Draggable(
                    feedback: _buildTrack(track),
                    child: _buildTrack(track),
                    onDragUpdate: (details) {
                      setState(() {
                        track.position = _snapToGrid(details.globalPosition);
                      });
                    },
                    onDragEnd: (details) {
                      setState(() {
                        track.position = _snapToGrid(details.offset);
                      });
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _handleSingleTap() {
    setState(() {
      // Add a new track at the tap position
      _tracks.add(
        Track(
          position: Offset(50.0,
              10.0), // You might need to calculate this based on the tap position
          instrument: widget.instrument,
        ),
      );
    });
  }

  void _handleDoubleTap() {
    // Implement navigation to inside the instrument
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              InstrumentDetailScreen(instrument: widget.instrument)),
    );
  }

  Widget _buildTrack(Track track) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          widget.instrument.name, // Display the instrument's name
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Offset _snapToGrid(Offset position) {
    return Offset(
      (_gridSize * (position.dx / _gridSize).roundToDouble())
          .clamp(0.0, double.infinity),
      (_gridSize * (position.dy / _gridSize).roundToDouble())
          .clamp(0.0, double.infinity),
    );
  }
}

class Track {
  Offset position;
  final Instrument instrument;

  Track({required this.position, required this.instrument});
}

class InstrumentDetailScreen extends StatelessWidget {
  final Instrument instrument;

  InstrumentDetailScreen({required this.instrument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instrument Details'),
      ),
      body: Center(
        child: Text('Details for ${instrument.name}'),
      ),
    );
  }
}
