import 'package:flutter_shutterstock_infinite_list/data_source/local_data_source.dart';
import 'package:flutter_shutterstock_infinite_list/data_source/remote_data_source.dart';
import 'package:flutter_shutterstock_infinite_list/models/models.dart';
import 'package:flutter_shutterstock_infinite_list/repositories/shutterstock_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDataSource])
void main() {
  int startIndex =1;
  int perPage =20;
  List<ImageModel> _zeroImages = [];
  List<ImageModel> _twoImages = [
    ImageModel(id: "", description: "", url: ""),
    ImageModel(id: "", description: "", url: "")
  ];
  List<ImageModel> _threeImages = [
    ImageModel(id: "", description: "", url: ""),
    ImageModel(id: "", description: "", url: ""),
    ImageModel(id: "", description: "", url: "")
  ];

  group('ShutterstockRepository', () {
    test('returns List of Images from local if available', () async {
      var remote = MockRemoteDataSource();
      var local = MockLocalDataSource();

      when(local.fetchImages(startIndex, perPage)).thenAnswer((_) async => _twoImages);
      when(remote.fetchImages(startIndex, perPage)).thenAnswer((_) async => _threeImages);

      var repository = ShutterstockRepository(remote, local);
      var results = await repository.fetchImages(startIndex,perPage);

      expect(results, isA<List<ImageModel>>());
      expect(results.length, _twoImages.length);
    });
    test(
        'returns List of Images from remote and save locally if local not available',
        () async {
      var remote = MockRemoteDataSource();
      var local = MockLocalDataSource();

      when(local.saveImages(1, _threeImages))
          .thenAnswer((realInvocation) => null);
      when(local.fetchImages(startIndex,  perPage)).thenAnswer((_) async => _zeroImages);
      when(remote.fetchImages(startIndex,  perPage)).thenAnswer((_) async => _threeImages);

      var repository = ShutterstockRepository(remote, local);
      var results = await repository.fetchImages(startIndex, perPage);

      verify(local.saveImages(startIndex, _threeImages));
      expect(results, isA<List<ImageModel>>());
      expect(results.length, _threeImages.length);
    });
  });
}
