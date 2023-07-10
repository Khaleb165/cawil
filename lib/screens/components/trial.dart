import 'package:flutter/material.dart';

class TrialPageForBus extends StatelessWidget {
  const TrialPageForBus({super.key});

  @override
  Widget build(BuildContext context) {

    final Map<String, String> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Card(
      child: Column(
        children: [
          Text('Current Location: ${arguments['currentLocation']}'),
          Text('Destination: ${arguments['destination']}'),
        ],
      ),
    );
  }
}
