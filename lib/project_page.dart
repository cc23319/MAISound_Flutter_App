import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
export 'package:flutterflow_ui/flutterflow_ui.dart';

class ProjectPageWidget extends StatefulWidget {
  const ProjectPageWidget({super.key});

  @override
  State<ProjectPageWidget> createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _soundContainers = [];

  @override
  void initState() {
    super.initState();
    // Inicializa com um container
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
          widthFactor: 0.186, // Largura do container em relação à tela
          heightFactor: 0.12, // Altura do container em relação à tela
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
        body: SafeArea(
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
                                value: 5,
                                onChanged: (newValue) {
                                  //newValue = double.parse(newValue.toStringAsFixed(2));
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
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
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
                                colors: [Color(0xFF1D1D26), Color(0xFF131319)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Usa um SizedBox para controlar o tamanho do Slider
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.186,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06, // Ajusta a altura aqui
                                    child: Slider(
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      inactiveColor:
                                          FlutterFlowTheme.of(context).alternate,
                                      min: 0,
                                      max: 10,
                                      value: 5,
                                      onChanged: (newValue) {
                                        //newValue = double.parse(newValue.toStringAsFixed(2));
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
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
                                  // Exibe os containers adicionados dinamicamente
                                  ..._soundContainers,
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
      ),
    );
  }
}

class _SoundContainer extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;

  const _SoundContainer({
    required this.widthFactor,
    required this.heightFactor,
  });

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
  width: MediaQuery.of(context).size.width * widthFactor,
  height: MediaQuery.of(context).size.height * heightFactor,
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
          value: 5,
          onChanged: (newValue) {
            //newValue = double.parse(newValue.toStringAsFixed(2));
          },
        ),
      ),
    ],
  ),
)
      ),
    );
  }
}