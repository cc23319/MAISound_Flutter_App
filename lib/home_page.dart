import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maisound/project_page.dart';
export 'package:flutterflow_ui/flutterflow_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlutterFlowIconButton(
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 80,
                          fillColor: Color.fromRGBO(18, 18, 23, 0.9),
                          hoverColor: Color.fromRGBO(18, 18, 23, 0.6),
                          hoverIconColor: Colors.white,
                          icon: FaIcon(
                            FontAwesomeIcons.bars,
                            color: FlutterFlowTheme.of(context).alternate,
                            size: 30,
                          ),
                          onPressed: () {
                            print('MenuButton pressed ...');
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'Menu',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlutterFlowIconButton(
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 80,
                          fillColor: Color.fromRGBO(18, 18, 23, 0.9),
                          hoverColor: Color.fromRGBO(18, 18, 23, 0.6),
                          hoverIconColor: Colors.white,
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            color: FlutterFlowTheme.of(context).alternate,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectPageWidget(),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'New Project',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlutterFlowIconButton(
                          borderRadius: 20,
                          borderWidth: 1,
                          buttonSize: 80,
                          fillColor: Color.fromRGBO(18, 18, 23, 0.9),
                          hoverColor: Color.fromRGBO(18, 18, 23, 0.6),
                          hoverIconColor: Colors.white,
                          icon: Icon(
                            Icons.upload_file,
                            color: FlutterFlowTheme.of(context).alternate,
                            size: 30,
                          ),
                          onPressed: () {
                            print('MenuButton pressed ...');
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'Load Project',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(width: 106)),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFF090C1E),
                    ),
                  ),
                ],
              ),
              // Use Expanded to make the container take the remaining space
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectPageWidget(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity, // Take full width
                    height: double.infinity, // Take full height
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            2,
                          ),
                          spreadRadius: 25,
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [Color(0xFF3B3B58), Color(0xFF1F1F28)],
                        stops: [0.5, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: Container(
                            width: 320,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Color(0xFF14141C),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, -1),
                              child: Container(
                                width: 320,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1D1D26),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Text(
                                    'New Project',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          fontSize: 22,
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}