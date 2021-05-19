import 'package:flutter_shutterstock_infinite_list/models/models.dart';
import 'package:flutter_shutterstock_infinite_list/providers/shutterstock_api_provider.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  final _apiProvider = ShutterstockApiProvider(http.Client());

  Future<List<ImageModel>> fetchImages(int startIndex, int perPage) =>
      _apiProvider.fetchImages(startIndex, perPage);
}
