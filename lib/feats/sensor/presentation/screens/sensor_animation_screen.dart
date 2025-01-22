import 'package:flutter/material.dart';
import 'package:sensor_animation/feats/sensor/presentation/providers/sensor_provider.dart';
import 'package:sensor_animation/feats/sensor/presentation/widgets/sensor_animation.dart';

class SensorAnimationScreen extends StatelessWidget {
  const SensorAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Animation'),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SensorAnimation(
        sensor: SensorType.accelerometer,
        layers: [
          Layer(
            sensitivity: 1,
            image: const AssetImage('assets/image/desert.jpg'),
            preventCrop: true,
          ),
          Layer(
            sensitivity: 7,
            image: const AssetImage('assets/gif/sun.gif'),
            imageHeight: 200,
            imageWidth: 200,
            offset: const Offset(100, -500),
            opacity: 0.7,
          ),
          Layer(
            sensitivity: 3,
            image: const AssetImage('assets/image/plant.png'),
            imageHeight: 150,
            imageWidth: 100,
            opacity: 0.6,
            offset: const Offset(200, 100),
          ),
          Layer(
            sensitivity: 3,
            image: const AssetImage('assets/image/plant.png'),
            imageHeight: 150,
            imageWidth: 100,
            opacity: 0.8,
            offset: const Offset(0, 100),
          ),
          Layer(
              sensitivity: 13,
              image: const AssetImage('assets/image/fox.png'),
              imageHeight: 150,
              offset: const Offset(0, 200),
              imageFit: BoxFit.fitHeight),
          Layer(
            sensitivity: 3,
            image: const AssetImage('assets/image/plant.png'),
            imageHeight: 150,
            imageWidth: 100,
            offset: const Offset(200, 400),
          ),
          Layer(
            sensitivity: 3,
            image: const AssetImage('assets/image/plant.png'),
            imageHeight: 150,
            imageWidth: 100,
            offset: const Offset(-200, 400),
          ),
        ],
        child: const Center(
          child: Text(
            '화면을 기울여보세요',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
