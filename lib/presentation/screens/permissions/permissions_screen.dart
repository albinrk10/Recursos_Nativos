import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/provider.dart';


class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView ();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final permission = ref.watch(permissionsProvider);
    return ListView(
      children: [
        CheckboxListTile(
          value: permission.cameraGranted,
          title: const Text('Camara'),
          subtitle:  Text('${permission.camera}'),
          onChanged: ( _ ){
            ref.read(permissionsProvider.notifier).requestCameraAccess();

        }),
        CheckboxListTile(
          value: permission.photoLibraryGranted,
          title: const Text('Galeria de fotos'),
          subtitle:  Text('${permission.photoLibrary}'),
          onChanged: ( _ ){
             ref.read(permissionsProvider.notifier).requestPhotoLibraryAccess();

        }),
        CheckboxListTile(
          value: permission.locationGranted,
          title: const Text('Location'),
          subtitle:  Text('${permission.location}'),
          onChanged: ( _ ){
           ref.read(permissionsProvider.notifier).requestLocationAccess();

        }),
        CheckboxListTile(
         value: permission.sensorsGranted,
          title: const Text('Sensor'),
          subtitle:  Text('${permission.sensors}'),
          onChanged: ( _ ){
           ref.read(permissionsProvider.notifier).requestSensorAccess();

        }),
        
      ],
    );
  }
}