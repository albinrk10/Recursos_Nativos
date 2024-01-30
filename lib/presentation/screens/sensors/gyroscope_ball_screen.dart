import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/provider.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gyrosCope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('GyroscopeBallScreen'),
        ),
        body: SizedBox.expand(
            child: gyrosCope$.when(
          data: (value) => MovieBall(x: value.x, y: value.y),
          error: (error, stackTrace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        )));
  }
}

class MovieBall extends StatelessWidget {
  final double x;
  final double y;
  const MovieBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currenYPos = (y * 150);
    double currentXPos = (x * 200);

    return Stack(
      alignment: Alignment.center,
      children: [
         AnimatedPositioned(
          left: (currenYPos - 25 + (screenWidth / 2)),
          top: (currentXPos - 25 + (screenHeight / 2)),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1000),
            child: const Ball()),
        
        Text(
          '''
        x: $x
        y: $y
   ''',
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}
