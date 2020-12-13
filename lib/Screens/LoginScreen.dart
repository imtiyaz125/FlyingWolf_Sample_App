import 'package:bluestack_assignment/Utility/SharedPreferenceHelper.dart';
import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/Utility/Utility.dart';
import 'package:bluestack_assignment/bloc/AuthBloc.dart';
import 'package:bluestack_assignment/bloc/BlocManager.dart';
import 'package:bluestack_assignment/data/Models/request/LoginRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc _bloc;

  LoginRequest _loginRequest = LoginRequest();

  Widget _widget = SizedBox();

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = BlocProvider.of<AuthBloc>(context);
      print("calling from build");
    }
    return BlocManager(
      initState: (context) {
        print("calling from build");
        _bloc.dispatch(LoginEvent(
            request: _loginRequest
        ));
      },
      child: BlocListener(
        bloc: _bloc,
        listener: (BuildContext context, AuthState state) {
          if (state is LoginError) {
            print("${state.errorMessage}");
            Utility.showAlertDialog(context, "Message", state.errorMessage);
          } else if (state is LoginSuccess) {
            SharedPrefHelper.getBoolean(SharedPrefHelper.KEY_IS_LOGGEDIN).then((
                value) => {
              if(value)
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (BuildContext context) => HomeScreen())),
            });
            if (state.response.isValidCredentials) {
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
            }
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, AuthState state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Builder(builder: (_context) {
                if (state is LoginError) {
                  print(state.errorMessage);
                } else if (state is LoginSuccess) {
                  _widget = buildLoginWidgets(
                      context, true);
                }
                return _widget;
              }),
            );
          },
        ),
      ),
    );
  }

  Widget buildLoginWidgets(BuildContext context, bool isLoginBtnDisabled) {
    return Scaffold(
      backgroundColor: Colors.purple,
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/game_tv.png",width: MediaQuery.of(context).size.width-150,),
            SizedBox(
              height: 20,
            ),
            buildInputField(numberController, false, TextInputType.phone,
                StringConstants.NUMBER_HINT),
            SizedBox(
              height: 20,
            ),
            buildInputField(passwordController, true, TextInputType.text,
                StringConstants.PASSWORD_HINT),
            SizedBox(
              height: 30,
            ),
            buildLoginBtn(context, isLoginBtnDisabled)
          ],
        ),
      ),
    );
  }

  TextEditingController numberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  buildInputField(TextEditingController controller, bool isPassword,
      TextInputType inputType, String hint) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: inputType,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.purple),
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true)),
    );
  }

  buildLoginBtn(BuildContext context, bool isLoginBtnDisabled) {
    return InkWell(
      onTap: () {
        if (passwordController.text.isEmpty ||
            numberController.text.isEmpty) {
          Utility.showAlertDialog(context, "Message", StringConstants.ALL_FIELDS_REQUIRED_ERR);
        } else {
          _loginRequest.password = passwordController.text;
          _loginRequest.number = numberController.text;
          _bloc.dispatch(LoginEvent(
              request: _loginRequest
          ));
        }
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlueAccent
                ])),
        child: Text(
          StringConstants.LOGIN_BTN_TEXT,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
  @override
  void dispose() {
    numberController.dispose();
    passwordController.dispose();
    _bloc=null;
    super.dispose();
  }
}
