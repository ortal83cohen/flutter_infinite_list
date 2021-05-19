import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shutterstock_infinite_list/data_source/local_data_source.dart';
import 'package:flutter_shutterstock_infinite_list/data_source/remote_data_source.dart';
import 'package:flutter_shutterstock_infinite_list/models/models.dart';
import 'package:flutter_shutterstock_infinite_list/repositories/shutterstock_repository.dart';
import 'package:flutter_shutterstock_infinite_list/usecase/get_images_state_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(const ImagesState());
  var _getShutterstockListUsecase = GetImagesStateUsecase(
      ShutterstockRepository(RemoteDataSource(), LocalDataSource()), PER_PAGE);

  @override
  Stream<Transition<ImagesEvent, ImagesState>> transformEvents(
    Stream<ImagesEvent> events,
    TransitionFunction<ImagesEvent, ImagesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ImagesState> mapEventToState(ImagesEvent event) async* {
    if (event is ImageFetched) {
      yield await _getShutterstockListUsecase.mapImageFetchedToState(state);
    }
  }
}

const int PER_PAGE = 20;
