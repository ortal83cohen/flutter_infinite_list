import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shutterstock_infinite_list/pages/images_list/images.dart';

class ImagesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images')),
      body: BlocProvider(
        create: (_) => ImagesBloc()..add(ImageFetched()),
        child: ImagesList(),
      ),
    );
  }
}
