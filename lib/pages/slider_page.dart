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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _sliderValue);
        return false;
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Wert: ${_sliderValue.toInt()}',
                style: const TextStyle(fontSize: 20),
              ),
              Slider(
                min: 0,
                max: 100,
                value: _sliderValue,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                color: Color.lerp(
                  Colors.blue,
                  Colors.red,
                  _sliderValue / 100,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Farbfeld',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}