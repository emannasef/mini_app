import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:it_roots_task/core/helpers/location_helper.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> with WidgetsBindingObserver {
  MapCubit() : super(MapInitial()) {
    WidgetsBinding.instance.addObserver(this);
  }

  static MapCubit get(context) => BlocProvider.of(context);

  late GoogleMapController mapController;
  late LatLng _initialPosition;
  final Set<Marker> _markers = {};

  LatLng get getInitialPosition => _initialPosition;
  Set<Marker> get getMarkers => _markers;


  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }


  void onInitMap()async{
    if(await isConnectedToNetwork()){
      _initMap();
    }else{
      emit(MapError());
    }
  }

  void onSetMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void _initMap() async {
    emit(MapLoading());
    try {
      _initialPosition = await LocationHelper.getCurrentLocation();
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _initialPosition,
          infoWindow: const InfoWindow(title: "You are here"),
        ),
      );
      emit(MapLoaded());
    } catch (error) {
      emit(MapError());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onInitMap();
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
