import 'package:bloc/bloc.dart';
import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/Utility/Utility.dart';
import 'package:bluestack_assignment/data/Models/request/RecommendedRequest.dart';
import 'package:bluestack_assignment/data/Models/response/ProfileResponse.dart';
import 'package:bluestack_assignment/data/Models/response/RecommendedResponse.dart';
import 'package:bluestack_assignment/data/Repository/HomeRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

//create event
abstract class HomeEvent extends Equatable {
  HomeEvent([List event = const []]) : super(event);
}

class SetState extends HomeEvent {
  SetState() : super([]);
}

//create state
abstract class HomeState extends Equatable {
  HomeState([List states = const []]) : super(states);
}

class Loading extends HomeEvent {
  Loading() : super([]);
}

class Initial extends HomeEvent {
  Initial() : super([]);
}

class Error extends HomeEvent {
  final String errorMessage;
  final int errorCode;

  Error({this.errorCode, this.errorMessage}) : super([errorCode, errorMessage]);
}

/*------Recommended Tournament Event---------*/

class RecommendedEvent extends HomeEvent {
  RecommendedRequest request;
  RecommendedEvent({@required this.request}) : super([request]);
}

class RecommendedInitial extends HomeState {
  RecommendedInitial() : super([]);
}

class RecommendedLoading extends HomeState {
  RecommendedLoading() : super([]);
}

class RecommendedSuccess extends HomeState {
  final Data response;

  RecommendedSuccess({@required this.response}) : super([response]);
}

class RecommendedError extends HomeState {
  final String errorMessage;
  final int errorCode;

  RecommendedError({this.errorCode, this.errorMessage})
      : super([errorCode, errorMessage]);
}


//bloc start
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository = Injector.appInstance.getDependency<HomeRepository>();

  @override
  HomeState get initialState => RecommendedInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is RecommendedEvent) {
      bool isNetConnected = await Utility.checkNetwork();
      if (!isNetConnected) {
        yield RecommendedError(
            errorCode: 2, errorMessage: StringConstants.NO_INTERNET_ERR);
      } else {
        try {
          yield RecommendedLoading();
          final response = await repository.getRemmendedData(event.request);
          if (response.success) {
            yield RecommendedSuccess(response: response.data);
          } else {
            yield RecommendedError(
                errorCode: response.code, errorMessage: response.message);
          }
        } catch (e) {
          yield RecommendedError(
              errorCode: -1,
              errorMessage: StringConstants.GENERAL_NETWOR_ERROR_MESSAGE);
        }
      }
    }
  }
}
