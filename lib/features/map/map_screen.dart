import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:it_roots_task/features/map/cubit/map_cubit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          final cubit = MapCubit.get(context);
          switch (state) {
            case MapLoading():
              return const Center(child: CircularProgressIndicator());
            case MapError():
              return Center(child: Text("mapError".tr()));
            case MapLoaded():
              return GoogleMap(
                onMapCreated: cubit.onSetMapController,
                initialCameraPosition: CameraPosition(
                  target: cubit.getInitialPosition,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: cubit.getMarkers,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
