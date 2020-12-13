import 'package:bloc/bloc.dart';
import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/Utility/Utility.dart';
import 'package:bluestack_assignment/data/Models/response/ProfileResponse.dart';
import 'package:bluestack_assignment/data/Repository/HomeRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

//create event
abstract class ProfileBlocEvent extends Equatable {
  ProfileBlocEvent([List event = const []]) : super(event);
}

class SetState extends ProfileBlocEvent {
  SetState() : super([]);
}

//create state
abstract class ProfileBlocState extends Equatable {
  ProfileBlocState([List states = const []]) : super(states);
}

class Loading extends ProfileBlocEvent {
  Loading() : super([]);
}

class Initial extends ProfileBlocEvent {
  Initial() : super([]);
}

class Error extends ProfileBlocEvent {
  final String errorMessage;
  final int errorCode;

  Error({this.errorCode, this.errorMessage}) : super([errorCode, errorMessage]);
}

/*-----------PROFILE EVENT------------------------*/
class ProfileEvent extends ProfileBlocEvent {
  ProfileEvent() : super([]);
}

class ProfileEventInitial extends ProfileBlocState {
  ProfileEventInitial() : super([]);
}

class ProfileEventLoading extends ProfileBlocState {
  ProfileEventLoading() : super([]);
}

class ProfileEventSuccess extends ProfileBlocState {
  final ProfileData response;

  ProfileEventSuccess({@required this.response}) : super([response]);
}

class ProfileEventError extends ProfileBlocState {
  final String errorMessage;
  final int errorCode;

  ProfileEventError({this.errorCode, this.errorMessage})
      : super([errorCode, errorMessage]);
}

/*--------------------------------------------*/
//bloc start
class ProfileBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  final HomeRepository repository =
      Injector.appInstance.getDependency<HomeRepository>();

  @override
  ProfileBlocState get initialState => ProfileEventInitial();

  @override
  Stream<ProfileBlocState> mapEventToState(ProfileBlocEvent event) async* {
    if (event is ProfileEvent) {
      bool isNetConnected = await Utility.checkNetwork();
      if (!isNetConnected) {
        yield ProfileEventError(
            errorCode: 2, errorMessage: StringConstants.NO_INTERNET_ERR);
      } else {
        try {
          yield ProfileEventLoading();
          final response = await repository.getMyProfile();
          if (response.success) {
            yield ProfileEventSuccess(response: response.data);
          } else {
            yield ProfileEventError(
                errorCode: response.code, errorMessage: response.message);
          }
        } catch (e) {
          yield ProfileEventError(
              errorCode: -1,
              errorMessage: StringConstants.GENERAL_NETWOR_ERROR_MESSAGE);
        }
      }
    }
  }
}
