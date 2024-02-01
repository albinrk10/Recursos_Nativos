import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userLocationAsync = ref.watch(userLocationProvider);
    final watchLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('ubicacion'),
        ),
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //!current location
              const Text(
                'ubicacion Actual',
              ),
              userLocationAsync.when(
                data: (data) => Text('$data'),
                loading: () => const CircularProgressIndicator(),
                error: (error, _ ) => Text(' $error'),
              ),

              const SizedBox(height: 30,),
              //!current location
              const Text('Seguimiento de ubicacion'),
              watchLocationAsync.when(
                data: (data) => Text('$data'),
                loading: () => const CircularProgressIndicator(),
                error: (error, _ ) => Text(' $error'),
              ),
            ],
          ),
        ));
  }
}
