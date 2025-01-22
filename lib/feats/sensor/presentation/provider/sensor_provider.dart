import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

enum SensorType {
  /// 가속도계의 이산적인 읽기. 가속도계는 장치의 속도를 측정합니다. 이러한 읽기에는 중력의 영향이 포함됩니다. 간단히 말해서, 가속도계 읽기를 사용하여 장치가 특정 방향으로 이동하는지 여부를 알 수 있습니다.
  accelerometer,

  /// **[accelerometer]**와 같이, 이것은 가속도계의 이산적인 읽기이며 장치의 속도를 측정합니다. 그러나 **[accelerometer]**와 달리 이 이벤트에는 중력의 영향이 포함되지 않습니다.
  userAccelerometer,

  /// 자이로스코프의 이산적인 읽기. 자이로스코프는 3D 공간에서 장치의 회전 속도를 측정합니다.
  gyroscope,

  /// 자기계는 센서 주변의 주변 자기장을 측정하고 각 3차원 축에 대해 마이크로테슬라 ***μT*** 단위의 값을 반환합니다.
  magnetometer
}

class SensorProvider with ChangeNotifier {
  StreamSubscription<AccelerometerEvent>? _accelerometerSensorEvent;
  StreamSubscription<UserAccelerometerEvent>? _userAccelerometerSensorEvent;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSensorEvent;
  StreamSubscription<MagnetometerEvent>? _magnetometerSensorEvent;
  double _top = 0, _bottom = 0, _right = 0, _left = 0;

  double get top => _top;
  double get bottom => _bottom;
  double get right => _right;
  double get left => _left;

  void init(SensorType sensor) {
    setSensorEventListener(sensor);
  }

  void close() {
    _accelerometerSensorEvent?.cancel();
    _userAccelerometerSensorEvent?.cancel();
    _gyroscopeSensorEvent?.cancel();
    _magnetometerSensorEvent?.cancel();
  }

  void setSensorEventListener(SensorType sensor) {
    switch (sensor) {
      case SensorType.accelerometer:
        _setAcceleroMeterSensorEvent();
        break;
      case SensorType.userAccelerometer:
        _setUserAcceleroMeterSensorEvent();
        break;
      case SensorType.gyroscope:
        _setGyroscopeSensorEvent();
        break;
      case SensorType.magnetometer:
        _setMagnetometerSensorEvent();
        break;
    }
  }

  void _setAcceleroMeterSensorEvent() {
    _accelerometerSensorEvent = accelerometerEventStream().listen((event) {
      _top = event.y;
      _bottom = -event.y;
      _right = -event.x;
      _left = event.x;
      notifyListeners();
    });
  }

  void _setUserAcceleroMeterSensorEvent() {
    _userAccelerometerSensorEvent = userAccelerometerEventStream().listen((event) {
      _top = event.y;
      _bottom = -event.y;
      _right = -event.x;
      _left = event.x;
      notifyListeners();
    });
  }

  void _setGyroscopeSensorEvent() {
    _gyroscopeSensorEvent = gyroscopeEventStream().listen((event) {
      _top = event.y;
      _bottom = -event.y;
      _right = -event.x;
      _left = event.x;
      notifyListeners();
    });
  }

  void _setMagnetometerSensorEvent() {
    _magnetometerSensorEvent = magnetometerEventStream().listen((event) {
      _top = event.y;
      _bottom = -event.y;
      _right = -event.x;
      _left = event.x;
      notifyListeners();
    });
  }
}
