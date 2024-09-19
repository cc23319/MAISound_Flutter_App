import 'package:flutter/material.dart';
import 'package:maisound/cadastro_page.dart';
import 'package:maisound/classes/globals.dart';
import 'package:maisound/track_page.dart';

class ControlBarWidget extends StatefulWidget {
  const ControlBarWidget({super.key});

  @override
  State<ControlBarWidget> createState() => _ControlBarWidget();
}

class _ControlBarWidget extends State<ControlBarWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '130');

    // Add a listener to the controller
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Texto do bpm mudou
  void _onTextChanged() {
    String text = _controller.text;

    int? value = int.tryParse(text);
    if (value != null) {
      if (value < 1) {
        _controller.text = '1';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      } else if (value > 999) {
        _controller.text = '999';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }

      BPM = value.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Placeholder buttons on the left
            Row(
              // Menu
              children: [
                FlutterFlowIconButton(
                  borderColor: const Color(0xFF242436),
                  borderRadius: 10,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: const Color(0xFF4B4B5B),
                  icon: const Icon(Icons.menu, color: Colors.white, size: 24),
                  onPressed: () {},
                ),
              ],
            ),

            // Volume slider
            SizedBox(
              width: 100, // Adjust width as per design
              child: Slider(
                activeColor: FlutterFlowTheme.of(context).primary,
                inactiveColor: FlutterFlowTheme.of(context).alternate,
                min: 0,
                max: 10,
                value: master_volume,
                onChanged: (newValue) {
                  setState(() {
                    master_volume = newValue;
                  });
                },
              ),
            ),

            // Rewind, Play/Pause, Loop buttons and time indicator
            Row(
              children: [
                // Botão de voltar
                FlutterFlowIconButton(
                  borderColor: const Color(0xFF242436),
                  borderRadius: 10,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: const Color(0xFF4B4B5B),
                  icon: const Icon(Icons.fast_rewind,
                      color: Colors.white, size: 24),
                  onPressed: () {},
                ),

                // Botão de pausar
                FlutterFlowIconButton(
                  borderColor: const Color(0xFF242436),
                  borderRadius: 10,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: const Color(0xFF4B4B5B),
                  icon: playingCurrently.value
                      ? const Icon(Icons.pause_circle,
                          color: Colors.white, size: 24)
                      : const Icon(Icons.play_circle,
                          color: Colors.white, size: 24),
                  onPressed: () {
                    setState(() {
                      playingCurrently.value = !playingCurrently.value;
                    });
                  },
                ),

                // Botão de loop
                FlutterFlowIconButton(
                  borderColor: const Color(0xFF242436),
                  borderRadius: 10,
                  borderWidth: 1,
                  buttonSize: 40,
                  fillColor: const Color(0xFF4B4B5B),
                  icon: const Icon(Icons.loop, color: Colors.white, size: 24),
                  onPressed: () {},
                ),

                // Tempo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "00:00:00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Courier",
                      ),
                    ),
                  ),
                ),

                // BPM TEXT
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Courier",
                      ),
                      child: Text('BPM')),
                ),

                // BPM
                // Tempo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 40,
                    width: 60,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove the underline
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Courier",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
