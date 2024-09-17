import 'package:flutter/material.dart';
import 'package:maisound/classes/instrument.dart';
import 'package:maisound/track_page.dart';

class TimelineWidget extends StatefulWidget {
  final Instrument instrument;

  TimelineWidget({required this.instrument});

  @override
  _TimelineWidgetState createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  final List<Track> _tracks = [];
  static const double _gridSize = 20.0; // Define the grid size

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleSingleTap,
      onDoubleTap: _handleDoubleTap,
      child: Container(
        height: 120,
        //padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(30, 0, 0, 0),
        ),
        child: Stack(
          children: [
            ..._tracks.map((track) => Positioned(
                  left: track.position.dx,
                  top: 0, // Ensure track starts from the top
                  child: SizedBox(
                    width: track.width, // Set track width dynamically
                    height: 120, // Track height should be consistent
                    child: Draggable(
                      feedback: SizedBox.shrink(),
                      child: _buildTrack(track),
                      onDragStarted: () {
                        // Optionally handle drag start
                      },
                      onDragUpdate: (details) {
                        setState(() {
                          track.position = _calculateNewPosition(
                              details.globalPosition, context);
                        });
                      },
                      onDragEnd: (details) {
                        setState(() {
                          track.position =
                              _calculateNewPosition(details.offset, context);
                        });
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _handleSingleTap(TapDownDetails details) {
    setState(() {
      // Add a new track at the tap position
      _tracks.add(
        Track(
          position: _snapToGrid(details.localPosition),
          width: 100.0, // Set a default width for the track
          instrument: widget.instrument,
        ),
      );
    });
  }

  void _handleDoubleTap() {
    // Implement navigation to inside the instrument
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrackPage()),
    );
  }

  Widget _buildTrack(Track track) {
    return Container(
      width: track.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.blueAccent, // Track color
      ),
      child: Column(
        children: [
          Container(
            height: 30, // Height of the top bar
            color: Colors.blue, // Top bar color
            child: Center(
              child: Text(
                widget.instrument.name, // Display the instrument's name
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 11, 12, 37), // Gray square
            ),
          ),
        ],
      ),
    );
  }

  Offset _calculateNewPosition(Offset globalPosition, BuildContext context) {
    // Get the position of the timeline widget
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.globalToLocal(globalPosition);

    return Offset(
      (_gridSize * (localPosition.dx / _gridSize).roundToDouble()).clamp(
          0.0, renderBox.size.width - 100.0), // Adjust based on track width
      0.0, // Keep vertical position fixed
    );
  }

  Offset _snapToGrid(Offset position) {
    return Offset(
      (_gridSize * (position.dx / _gridSize).roundToDouble())
          .clamp(0.0, double.infinity),
      0.0, // Keep vertical position fixed
    );
  }
}

class Track {
  Offset position;
  double width; // Track width
  final Instrument instrument;

  Track({
    required this.position,
    required this.width,
    required this.instrument,
  });
}

class TrackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Page'),
      ),
      body: Center(
        child: Text('Track Page Content'),
      ),
    );
  }
}
