import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
export 'package:flutterflow_ui/flutterflow_ui.dart';

class ProjectPageWidget extends StatefulWidget {
  final String projectName;

  const ProjectPageWidget({super.key, required this.projectName});

  @override
  State<ProjectPageWidget> createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<_SoundContainer> _soundContainers = []; 
  double _volume = 2; 
  bool _isPlaying = false; 

  @override
  void initState() {
    super.initState();
    _addSoundContainer();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addSoundContainer() {
    setState(() {
      _soundContainers.add(
        _SoundContainer(
          widthFactor: 0.186,
          heightFactor: 0.12,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF303047),
        appBar: AppBar(
          title: Text(widget.projectName),
          backgroundColor: const Color(0xFF1D1D25),
        ),
        body: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
              painter: _GridPainter(),
            ),
            SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF1D1D25), Color(0xFF0E0E15)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: const Color(0xFF242436),
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: const Color(0xFF4B4B5B),
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('MenuBtn pressed ...');
                                  },
                                ),
                                Slider(
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  min: 0,
                                  max: 10,
                                  value: _volume,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _volume = newValue;
                                    });
                                  },
                                ),
                                FlutterFlowIconButton(
                                  borderColor: const Color(0xFF242436),
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: const Color(0xFF4B4B5B),
                                  icon: const Icon(
                                    Icons.fast_rewind,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('RewindBtn pressed ...');
                                  },
                                ),
                                FlutterFlowIconButton(
                                  borderColor: const Color(0xFF242436),
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: const Color(0xFF4B4B5B),
                                  icon: _isPlaying
                                      ? const Icon(
                                          Icons.pause_circle,
                                          color: Colors.white,
                                          size: 24,
                                        )
                                      : const Icon(
                                          Icons.play_circle,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      _isPlaying = !_isPlaying;
                                    });
                                    print('PlayBtn pressed ...');
                                  },
                                ),
                                FlutterFlowIconButton(
                                  borderColor: const Color(0xFF242436),
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  buttonSize: 40,
                                  fillColor: const Color(0xFF4B4B5B),
                                  icon: const Icon(
                                    Icons.loop,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    print('LoopBtn pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: 202,
                                height: 100,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1D1D26),
                                      Color(0xFF131319)
                                    ],
                                    stops: [0, 1],
                                    begin: AlignmentDirectional(0, -1),
                                    end: AlignmentDirectional(0, 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ..._soundContainers, 
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 20, 0, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: const Color(0xFF242436),
                                          borderRadius: 10,
                                          borderWidth: 1,
                                          buttonSize: 40,
                                          fillColor: const Color(0xFF4B4B5B),
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          onPressed: () {
                                            _addSoundContainer();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoundContainer extends StatefulWidget {
  final double widthFactor;
  final double heightFactor;

  const _SoundContainer({
    required this.widthFactor,
    required this.heightFactor,
  });

  @override
  _SoundContainerState createState() => _SoundContainerState();
}

class _SoundContainerState extends State<_SoundContainer> {
  double _volume = 5;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * widget.widthFactor,
          height: MediaQuery.of(context).size.height * widget.heightFactor,
          decoration: BoxDecoration(
            color: Color(0xFF593884),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Slider(
                  activeColor: FlutterFlowTheme.of(context).primary,
                  inactiveColor: FlutterFlowTheme.of(context).alternate,
                  min: 0,
                  max: 10,
                  value: _volume,
                  onChanged: (newValue) {
                    setState(() {
                      _volume = newValue; 
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 1;

    final paint2 = Paint()
      ..color = const Color.fromARGB(128, 0, 0, 0)
      ..strokeWidth = 1;

    dynamic currentPaint;
    for (int i = 0; i < 20; i++) {
      if (i % 2 == 0) {
        currentPaint = paint;
      } else {
        currentPaint = paint2;
      }

      canvas.drawLine(Offset(size.width * i / 20, 0),
          Offset(size.width * i / 20, size.height), currentPaint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
