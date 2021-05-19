import 'package:flutter_shutterstock_infinite_list/data_source/local_data_source.dart';
import 'package:flutter_shutterstock_infinite_list/data_source/remote_data_source.dart';
import 'package:flutter_shutterstock_infinite_list/models/models.dart';

class ShutterstockRepository {
  final RemoteDataSource _remoteRepository;

  final LocalDataSource _localRepository;

  ShutterstockRepository(this._remoteRepository, this._localRepository);

  Future<List<ImageModel>> fetchImages(int startIndex, int perPage) async {
    var localImage = await _localRepository.fetchImages(startIndex, perPage);
    if (localImage.isNotEmpty) {
      return localImage;
    }
    var remoteImage = await _remoteRepository.fetchImages(startIndex, perPage);
    _localRepository.saveImages(startIndex, remoteImage);
    return remoteImage;
  }
}
