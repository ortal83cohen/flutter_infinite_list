import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shutterstock_infinite_list/models/models.dart';

class ImageListItem extends StatefulWidget {
  final ImageModel image;

  const ImageListItem({Key? key, required this.image}) : super(key: key);

  @override
  _ImageListItemState createState() => _ImageListItemState();
}

class _ImageListItemState extends State<ImageListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CachedNetworkImage(imageUrl: widget.image.url);
  }
}
