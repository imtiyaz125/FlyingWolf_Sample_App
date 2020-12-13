import 'package:bluestack_assignment/Utility/SharedPreferenceHelper.dart';
import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/bloc/AuthBloc.dart';
import 'package:bluestack_assignment/bloc/HomeBloc.dart';
import 'package:bluestack_assignment/bloc/ProfileBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/LoginScreen.dart';
import 'data/DependencyInjections.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjections();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SharedPrefHelper.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(builder: (context) => HomeBloc()),
        BlocProvider<ProfileBloc>(builder: (context) => ProfileBloc()),
        BlocProvider<AuthBloc>(builder: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: StringConstants.APP_NAME,
        theme: ThemeData(fontFamily: "Montserrat", primaryColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}

