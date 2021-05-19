import 'package:flutter_shutterstock_infinite_list/models/models.dart';

class LocalDataSource {
  Future<List<ImageModel>> fetchImages(int startIndex, int perPage) =>
      Future.value([]); // todo implement local DB

  saveImages(int startIndex, List<ImageModel> images) {
    // todo implement local DB
  }
}
