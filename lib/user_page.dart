import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_concepts/method_channel/linking_service.dart';

void cpuTask(dynamic message) {
  while (true) {
    double x = 0;
    for (int i = 0; i < 10000000; i++) {
      x += i * 0.5;
    }
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  void startCpuLoad() {
    Isolate.spawn(cpuTask, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
             startCpuLoad();
            },
            child: Text("Turn on Isolate"),
          ),
          ElevatedButton(
            onPressed: () async {
              final battery = await LinkingService.getBatteryLevel();
              print(battery);
            },
            child: Text("Get Battery Level"),
          ),
          ElevatedButton(
            onPressed: () {
              LinkingService.setMaxBrightness();
            },
            child: Text("Max Brightness"),
          ),
          Text("login successful"),
        ],
      ),
    );
  }
}
