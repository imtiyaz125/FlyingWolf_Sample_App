import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:bluestack_assignment/Utility/SharedPreferenceHelper.dart';
import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/data/Models/request/LoginRequest.dart';
import 'package:bluestack_assignment/data/Models/response/LoginResponse.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//create event
abstract class AuthEvent extends Equatable {
  AuthEvent([List event = const []]) : super(event);
}

class SetState extends AuthEvent {
  SetState() : super([]);
}

//create state
abstract class AuthState extends Equatable {
  AuthState([List states = const []]) : super(states);
}

class Loading extends AuthEvent {
  Loading() : super([]);
}

class Initial extends AuthEvent {
  Initial() : super([]);
}

class Error extends AuthEvent {
  final String errorMessage;
  final int errorCode;

  Error({this.errorCode, this.errorMessage}) : super([errorCode, errorMessage]);
}

/*-----------PROFILE EVENT------------------------*/
class LoginEvent extends AuthEvent {
  LoginRequest request;

  LoginEvent({@required this.request}) : super([request]);
}

class LoginInitial extends AuthState {
  LoginInitial() : super([]);
}

class LoginLoading extends AuthState {
  LoginLoading() : super([]);
}

class LoginSuccess extends AuthState {
  LoginReponse response;

  LoginSuccess({@required this.response}) : super([response]);
}

class LoginError extends AuthState {
  final String errorMessage;

  LoginError({this.errorMessage}) : super([errorMessage]);
}

/*--------------------------------------------*/
//bloc start
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => LoginInitial();
  HashMap staticUsers = HashMap<String, String>();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (staticUsers.isEmpty) {
      staticUsers.putIfAbsent("9898989898", () => "password12");
      staticUsers.putIfAbsent("9876543210", () => "password12");
    }
    if (event is LoginEvent) {
      try {
        yield LoginLoading();
        LoginReponse response = LoginReponse();
        bool isIgnorable=false;
        /*never executes as btn is disabled when empty*/
        if(event.request.number==null && event.request.number==null){
          isIgnorable=true;
           yield LoginSuccess(response: response);
        }else if (event.request.number.length >= 3 &&
            event.request.number.length <= 10) {
          isIgnorable=false;
          if (event.request.password.length >= 3 &&
              event.request.password.length <= 10) {
            staticUsers.forEach((key, value) {
              if (event.request.number.trim() == key &&
                  value == event.request.password.trim()) {
                response.isUserExist = true;
                response.isValidCredentials = true;
              }
            });
            if(!response.isUserExist)
              response.errorMessage=StringConstants.USER_NOT_EXIST;
          } else {
            response.isValidCredentials = false;
            response.errorMessage = StringConstants.INVALID_PASSWORD_ERR;
          }
        } else {
          response.isValidCredentials = false;
          response.errorMessage = StringConstants.INVALID_NUMBER_ERR;
        }
        if (!isIgnorable && response.isValidCredentials && response.isUserExist) {
          SharedPrefHelper.save(SharedPrefHelper.KEY_IS_LOGGEDIN,true);
          yield LoginSuccess(response: response);
        } else if(!isIgnorable ){
          yield LoginError(errorMessage: response.errorMessage);
        }
      } catch (e) {
        yield LoginError(
            errorMessage: StringConstants.GENERAL_NETWOR_ERROR_MESSAGE);
      }
    }
  }
}
