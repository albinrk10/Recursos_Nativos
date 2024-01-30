import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/provider.dart';

class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Permiso Requerido'),
      ),
      body: Center(
        child: FilledButton(
          child: const Text('Localización necesaria'),
          onPressed: () {

            ref.read( permissionsProvider.notifier )
              .requestLocationAccess();

          },
        ),
      ),
    );
  }
}