part of 'images_bloc.dart';

enum ImagesStatus { initial, success, failure }

class ImagesState extends Equatable {
  const ImagesState(
      {this.status = ImagesStatus.initial,
      this.images = const <ImageModel>[],
      this.hasReachedMax = false,
      this.page = START_FIRST_PAGE});

  final ImagesStatus status;
  final List<ImageModel> images;
  final bool hasReachedMax;
  final int page;

  ImagesState copyWith({
    ImagesStatus? status,
    List<ImageModel>? images,
    bool? hasReachedMax,
    int? page,
  }) {
    return ImagesState(
      page: page ?? this.page,
      status: status ?? this.status,
      images: images ?? this.images,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ImageState { status: $status, hasReachedMax: $hasReachedMax, 
    images: ${images.length} page: $page }''';
  }

  @override
  List<Object> get props => [status, images, hasReachedMax, page];
}

const int START_FIRST_PAGE = 1;
