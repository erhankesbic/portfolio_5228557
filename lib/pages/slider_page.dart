import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

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

  Color _calculateColor() {
    return Color.lerp(Colors.blue, Colors.red, _sliderValue / 100)!;
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
          elevation: 0,
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
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
              padding: const EdgeInsets.all(AppTheme.spacingXLarge),
              child: AppWidgets.card(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Wähle eine Farbe',
                        style: AppTheme.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      AppWidgets.spacing(height: AppTheme.spacingLarge),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _calculateColor(),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          boxShadow: [
                            BoxShadow(
                              color: _calculateColor().withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      AppWidgets.spacing(height: AppTheme.spacingLarge),
                      Text(
                        'Wert: ${_sliderValue.toInt()}',
                        style: AppTheme.headlineMedium.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 100,
                        value: _sliderValue,
                        activeColor: _calculateColor(),
                        inactiveColor: _calculateColor().withOpacity(0.3),
                        onChanged: (value) {
                          setState(() {
                            _sliderValue = value.roundToDouble();
                          });
                        },
                      ),
                      AppWidgets.spacing(height: AppTheme.spacingXLarge),
                      AppWidgets.textButton(
                        label: 'Übernehmen',
                        onPressed: () => Navigator.pop(context, _sliderValue),
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
