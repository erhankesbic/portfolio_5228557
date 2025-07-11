import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  final double initialValue;
  const SliderPage({super.key, this.initialValue = 50.0});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, _sliderValue);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Slider-Seite'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, _sliderValue);
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Wähle einen Wert',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Wert: ${_sliderValue.toInt()}',
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 100,
                        value: _sliderValue,
                        onChanged: (value) {
                          setState(() {
                            _sliderValue = value.roundToDouble();
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color.lerp(
                            Colors.blue,
                            Colors.red,
                            _sliderValue / 100,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Farbfeld',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              shadows: [
                                Shadow(
                                  blurRadius: 8,
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
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
            ),
          ),
        ),
      ),
    );
  }
}