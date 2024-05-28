import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
export 'package:flutterflow_ui/flutterflow_ui.dart';


class ProjectPageWidget extends StatefulWidget {
  const ProjectPageWidget({super.key});

  @override
  State<ProjectPageWidget> createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF303047),
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
                        decoration: BoxDecoration(
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
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Color(0xFF242436),
                                borderRadius: 10,
                                borderWidth: 1,
                                buttonSize: 40,
                                fillColor: Color(0xFF4B4B5B),
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('MenuBtn pressed ...');
                                },
                              ),
                            ),
                            Slider(
                              activeColor: FlutterFlowTheme.of(context).primary,
                              inactiveColor:
                                  FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 10,
                              value:  5,
                              onChanged: (newValue) {
                                newValue = double.parse(newValue.toStringAsFixed(2));
                              },
                            ),
                            FlutterFlowIconButton(
                              borderColor: Color(0xFF242436),
                              borderRadius: 10,
                              borderWidth: 1,
                              buttonSize: 40,
                              fillColor: Color(0xFF4B4B5B),
                              icon: Icon(
                                Icons.fast_rewind,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                print('RewindBtn pressed ...');
                              },
                            ),
                            FlutterFlowIconButton(
                              borderColor: Color(0xFF242436),
                              borderRadius: 10,
                              borderWidth: 1,
                              buttonSize: 40,
                              fillColor: Color(0xFF4B4B5B),
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                print('PlayBtn pressed ...');
                              },
                            ),
                            FlutterFlowIconButton(
                              borderColor: Color(0xFF242436),
                              borderRadius: 10,
                              borderWidth: 1,
                              buttonSize: 40,
                              fillColor: Color(0xFF4B4B5B),
                              icon: Icon(
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
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF1D1D26), Color(0xFF131319)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.12,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.12,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF593884),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            width: 0,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Slider(
                                                activeColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                inactiveColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                min: 0,
                                                max: 10,
                                                value: 5,
                                                onChanged: (newValue) {
                                                  newValue = double.parse(
                                                      newValue
                                                          .toStringAsFixed(2));
                                                  setState(() => {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Color(0xFF242436),
                                      borderRadius: 10,
                                      borderWidth: 1,
                                      buttonSize: 40,
                                      fillColor: Color(0xFF4B4B5B),
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        print('AddBtn pressed ...');
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
      ),
    );
  }
}
