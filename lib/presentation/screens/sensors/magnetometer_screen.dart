import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/provider.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final magnetometer$ = ref.watch(magnetometerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MagnetometerScreen'),
      ),
      body: Center(
        child: magnetometer$.when(
            data: (value) => Text(
              value.x.toString(),
              style: const TextStyle(fontSize: 30),
            ),
            error: (error, stackTrace) => Text(
              'Error: $error',
            ),
            loading: () => const CircularProgressIndicator(),
          ),
      )
    );
  }
}