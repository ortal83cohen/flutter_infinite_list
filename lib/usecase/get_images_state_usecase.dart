import 'package:flutter_shutterstock_infinite_list/pages/images_list/bloc/images_bloc.dart';
import 'package:flutter_shutterstock_infinite_list/repositories/shutterstock_repository.dart';

class GetImagesStateUsecase {
  final int _perPage;

  final ShutterstockRepository _shutterstockRepository;

  GetImagesStateUsecase(this._shutterstockRepository, this._perPage);

  Future<ImagesState> mapImageFetchedToState(ImagesState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == ImagesStatus.initial) {
        final posts =
            await _shutterstockRepository.fetchImages(state.page, _perPage);
        return state.copyWith(
          status: ImagesStatus.success,
          images: posts,
          hasReachedMax: false,
        );
      }
      int newPage = state.page + 1;
      final posts =
          await _shutterstockRepository.fetchImages(newPage, _perPage);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              page: newPage,
              status: ImagesStatus.success,
              images: List.of(state.images)..addAll(posts),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ImagesStatus.failure);
    }
  }
}
