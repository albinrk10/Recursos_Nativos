import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final canCkeckBiometrics = ref.watch(caCheckBiometricsProvider);
      final LocalAuthState = ref.watch(localAuthProvider);
     

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(onPressed: () {
              ref.read(localAuthProvider.notifier).authenticateUser();
            }, child: const Text('autenticar')),

            canCkeckBiometrics.when(
              data: (canCheck) => Text('Puede revisar biometricos $canCheck'),
               error: (error, _ ) =>  Text('Error $error'),
                loading: () => const CircularProgressIndicator(), 
            ),

            const SizedBox(height: 40),
            const Text('Estado de biometrico' , style: TextStyle(fontSize: 30),),
             Text('Estado $LocalAuthState ', style: const TextStyle(fontSize: 20),)

          ],
        )
      ),
    );
  }
}