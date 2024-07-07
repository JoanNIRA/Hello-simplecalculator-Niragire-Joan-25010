import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class BatteryService with ChangeNotifier {
  final Battery _battery = Battery();
  Timer? _timer;

  void initialize(BuildContext context) {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      if (state == BatteryState.charging) {
        _startMonitoringBatteryLevel(context);
      } else {
        _stopMonitoringBatteryLevel();
      }
    });
  }

  void _startMonitoringBatteryLevel(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      int batteryLevel = await _battery.batteryLevel;
      if (batteryLevel == 80) {
        _showNotification(context);
        _stopMonitoringBatteryLevel();
      }
    });
  }

  void _stopMonitoringBatteryLevel() {
    _timer?.cancel();
  }

  void _showNotification(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Battery level reached 80%')),
    );

    // Play a sound
    final player = AudioCache();
    await player.play('notification.mp3');
  }
}
