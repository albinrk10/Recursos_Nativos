import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final useInitialLocation = ref.watch(userLocationProvider);
    // final watchUserLocation = ref.watch(watchLocationProvider);

    return Scaffold(
      body: useInitialLocation.when(
        data: ((data) => MapAndControls(latitude: data.$1, longitude: data.$2)),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(
          child: Text('Ubicando usuario...'),
        ),
      ),
    );
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;
  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(initialLat: latitude, initialLong: longitude),

        //! Boton para salir
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        //! Ir  a la posicion del usuario actual
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.location_searching),
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .goToLocation(latitude, longitude);
            },
          ),
        ),
        //! Seguir usuario
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            icon:  Icon(
              mapControllerState.followUser
                  ? Icons.directions_run
                  : Icons.accessibility_new_outlined,
              ),
            onPressed: () {
               ref
                  .read(mapControllerProvider.notifier)
                  .toggleFollowUser();
            },
          ),
        ),
        //! Crear marcador
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.pin_drop),
            onPressed: () {
              ref
                  .read(mapControllerProvider.notifier)
                  .addMarkerCurrentPosition();
            },
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLong;

  const _MapView({required this.initialLat, required this.initialLong});

  @override
  __MapViewState createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {

    final  mapController = ref.watch(mapControllerProvider);

    return GoogleMap(
     markers: mapController.markersSet,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLat, widget.initialLong), zoom: 12),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
      
      onLongPress: (latLng) {
        ref.read(mapControllerProvider.notifier).addMaker(latLng.latitude, latLng.longitude , 'Nuevo marcador');
        
      },
    );
  }
}
