import 'package:flutter/material.dart';
import 'package:maisound/track_page.dart';
import 'package:maisound/ui/controlbar.dart';
import 'package:maisound/ui/instrument_tracks.dart';
import 'package:maisound/ui/marker.dart';


class ProjectPageWidget extends StatefulWidget {
  const ProjectPageWidget({super.key, projectName});

  @override
  State<ProjectPageWidget> createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF303047),

      body: Column(
        children: [
          ControlBarWidget(),
          //TimestampMarker(),

          // Main content area with sidebar and expanded content
          Expanded(
              // Sidebar for instrument tracks
              child: InstrumentTracks(),
            )
        ]
      )
    );
  }

}