import 'package:flutter_shutterstock_infinite_list/models/models.dart';
import 'package:flutter_shutterstock_infinite_list/pages/images_list/images.dart';
import 'package:flutter_shutterstock_infinite_list/repositories/shutterstock_repository.dart';
import 'package:flutter_shutterstock_infinite_list/usecase/get_images_state_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'usecase_test.mocks.dart';

@GenerateMocks([ShutterstockRepository])
void main() {
  int startIndex = 1;
  int perPage = 2;
  List<ImageModel> _images = [
    ImageModel(id: "", description: "", url: ""),
    ImageModel(id: "", description: "", url: "")
  ];
  group('GetShutterstockListUsecase', () {
    test(
        'returns valid success state with images from repository if the '
        'current state is initial', () async {
      var mockShutterstockRepository = MockShutterstockRepository();
      var getShutterstockListUsecase =
          GetImagesStateUsecase(mockShutterstockRepository,perPage);

      when(mockShutterstockRepository.fetchImages(startIndex, perPage))
          .thenAnswer((_) async => _images);

      var results =
          await getShutterstockListUsecase.mapImageFetchedToState(ImagesState
            ());

      verify(mockShutterstockRepository.fetchImages(startIndex, perPage));
      expect(results, isA<ImagesState>());
      expect(results.hasReachedMax, false);
      expect(results.images, _images);
      expect(results.status, ImagesStatus.success);
    });
    test(
        'returns valid success state with hasReachedMax=true if thee are '
        'empty results from the server', () async {
      var mockShutterstockRepository = MockShutterstockRepository();
      var getShutterstockListUsecase =
          GetImagesStateUsecase(mockShutterstockRepository,perPage);

      when(mockShutterstockRepository.fetchImages(startIndex + 1, perPage))
          .thenAnswer((_) async => []);

      var results = await getShutterstockListUsecase.mapImageFetchedToState(
          ImagesState(
              status: ImagesStatus.success,
              hasReachedMax: false,
              images: _images));

      verify(mockShutterstockRepository.fetchImages(startIndex + 1, perPage));
      expect(results, isA<ImagesState>());
      expect(results.hasReachedMax, true);
      expect(results.images, _images);
      expect(results.status, ImagesStatus.success);
    });
    test(
        'returns valid success state with the added images from the server if '
        'thee are results from the server', () async {
      var mockShutterstockRepository = MockShutterstockRepository();
      var getShutterstockListUsecase =
          GetImagesStateUsecase(mockShutterstockRepository,perPage);

      when(mockShutterstockRepository.fetchImages(startIndex + 1, perPage))
          .thenAnswer((_) async => _images);

      var results = await getShutterstockListUsecase.mapImageFetchedToState(
          ImagesState(
              status: ImagesStatus.success,
              hasReachedMax: false,
              images: _images));

      verify(mockShutterstockRepository.fetchImages(startIndex + 1, perPage));
      expect(results, isA<ImagesState>());
      expect(results.hasReachedMax, false);
      expect(results.images, List.of(_images)..addAll(_images));
      expect(results.status, ImagesStatus.success);
    });
    test(
        'returns the same state without calling the Repository if '
        'hasReachedMax=true ', () async {
      var mockShutterstockRepository = MockShutterstockRepository();
      var getShutterstockListUsecase =
          GetImagesStateUsecase(mockShutterstockRepository,perPage);

      when(mockShutterstockRepository.fetchImages(startIndex, perPage))
          .thenAnswer((_) async => _images);

      var results = await getShutterstockListUsecase.mapImageFetchedToState(
          ImagesState(status: ImagesStatus.success, hasReachedMax: true));
      verifyNever(mockShutterstockRepository.fetchImages(startIndex, perPage));
      expect(results, isA<ImagesState>());
      expect(results.hasReachedMax, true);
      expect(results.images, []);
      expect(results.status, ImagesStatus.success);
    });
    test(
        'returns the same state without calling the Repository if '
            'hasReachedMax=true ', () async {
      var mockShutterstockRepository = MockShutterstockRepository();
      var getShutterstockListUsecase =
      GetImagesStateUsecase(mockShutterstockRepository,perPage);

      when(mockShutterstockRepository.fetchImages(startIndex, perPage))
          .thenAnswer((_) async => _images);

      var results = await getShutterstockListUsecase.mapImageFetchedToState(
          ImagesState(status: ImagesStatus.success, hasReachedMax: true));
      verifyNever(mockShutterstockRepository.fetchImages(startIndex, perPage));
      expect(results, isA<ImagesState>());
      expect(results.hasReachedMax, true);
      expect(results.images, []);
      expect(results.status, ImagesStatus.success);
    });
  });
}
