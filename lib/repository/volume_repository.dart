import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:volume_controller/volume_controller.dart';

@singleton
class VolumeRepository {
  final VolumeController _volumeController;

  VolumeRepository(this._volumeController);
  
  Future<double> getVolume() async {
    return _volumeController.getVolume();
  }
  
  void setVolume(final double volume) {
    _volumeController.setVolume(volume);
  }
  
  StreamSubscription<double> systemVolumeListener(final Function(double)? onData) {
    return _volumeController.listener(onData);
  }

}