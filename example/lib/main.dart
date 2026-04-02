import 'package:flutter/material.dart';
import 'package:flutter_body_part_selector/flutter_body_part_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Body Part Selector Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BodySelectorExample(),
    );
  }
}

class BodySelectorExample extends StatefulWidget {
  const BodySelectorExample({super.key});

  @override
  State<BodySelectorExample> createState() => _BodySelectorExampleState();
}

class _BodySelectorExampleState extends State<BodySelectorExample> {
  final controller = BodyMapController();
  final transformationController = TransformationController();

  @override
  void dispose() {
    controller.dispose();
    transformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final currentMatrix = transformationController.value;
    final currentScale = currentMatrix.getMaxScaleOnAxis();
    if (currentScale < 5.0) {
      final newScale = currentScale + 0.5;
      final newMatrix = Matrix4.diagonal3Values(newScale, newScale, 1.0);
      transformationController.value = newMatrix;
    }
  }

  void _zoomOut() {
    final currentMatrix = transformationController.value;
    final currentScale = currentMatrix.getMaxScaleOnAxis();
    if (currentScale > 1.0) {
      final newScale = (currentScale - 0.5 < 1.0 ? 1.0 : currentScale - 0.5);
      final newMatrix = Matrix4.diagonal3Values(newScale, newScale, 1.0);
      transformationController.value = newMatrix;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Body Part Selector'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flip),
            onPressed: controller.toggleView,
            tooltip: 'Flip view',
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: controller.clearSelection,
            tooltip: 'Clear selection',
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Stack(
            children: [
              Column(
                children: [
                  if (controller.selectedMuscles.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.blue.shade900,
                      width: double.infinity,
                      child: Text(
                        'Selected: ${controller.selectedMuscles.length} muscle(s)',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Expanded(
                    child: InteractiveBodySvg(
                      isFront: controller.isFront,
                      selectedMuscles: controller.selectedMuscles,
                      onMuscleTap: controller.selectMuscle,
                      highlightColor: Colors.blue.withValues(alpha: 0.7),
                      enableZoom: true,
                      transformationController: transformationController,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'zoom_in',
                      onPressed: _zoomIn,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton.small(
                      heroTag: 'zoom_out',
                      onPressed: _zoomOut,
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
