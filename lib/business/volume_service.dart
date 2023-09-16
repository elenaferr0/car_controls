import 'dart:async';

import 'package:injectable/injectable.dart';

import '../repository/volume_repository.dart';

@singleton
class VolumeService {
  final VolumeRepository _volumeRepository;
  late double _volume;
  static const defaultVolumeDelta = 0.07;
  
  VolumeService(this._volumeRepository);

  @PostConstruct(preResolve: true)
  Future<void> init() async {
   _volumeRepository.systemVolumeListener((final double volume) {
      _volume = volume;
    });
  }

  void increaseVolume(final double value) {
    _volumeRepository.setVolume(_volume + value);
  }

  void decreaseVolume(final double value) {
    _volumeRepository.setVolume(_volume - value);
  }
  
}