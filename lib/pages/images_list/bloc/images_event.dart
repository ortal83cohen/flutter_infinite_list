part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ImageFetched extends ImagesEvent {}
