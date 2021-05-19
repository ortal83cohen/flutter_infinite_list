import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shutterstock_infinite_list/pages/images_list/images.dart';

class ImagesList extends StatefulWidget {
  @override
  _ImagesListState createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  final _scrollController = ScrollController();
  late ImagesBloc _imagesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _imagesBloc = context.read<ImagesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
      builder: (context, state) {
        switch (state.status) {
          case ImagesStatus.failure:
            return const Center(child: Text('failed to fetch images'));
          case ImagesStatus.success:
            if (state.images.isEmpty) {
              return const Center(child: Text('no images'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.images.length
                    ? BottomLoader()
                    : ImageListItem(image: state.images[index]);
              },
              itemCount: state.images.length + (state.hasReachedMax ? 0 : 1),
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _imagesBloc.add(ImageFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
