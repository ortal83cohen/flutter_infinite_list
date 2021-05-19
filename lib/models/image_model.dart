import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  const ImageModel(
      {required this.id, required this.description, required this.url});

  final String id;
  final String description;
  final String url;

  @override
  List<Object> get props => [id, description, url];
}
