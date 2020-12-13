import 'package:bluestack_assignment/Utility/StringConstants.dart';
import 'package:bluestack_assignment/bloc/BlocManager.dart';
import 'package:bluestack_assignment/bloc/ProfileBloc.dart';
import 'package:bluestack_assignment/data/Models/response/ProfileResponse.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Widget/CommonErrorWidget.dart';
import 'Widget/CommonLoadingWidget.dart';

class HomeProfileScreen extends StatefulWidget {
  @override
  _HomeProfileScreenState createState() => _HomeProfileScreenState();
}

class _HomeProfileScreenState extends State<HomeProfileScreen> {
  ProfileBloc _bloc;
  ProfileData _profileData;
  fetchProfile() {
    _bloc.dispatch(ProfileEvent());
  }
  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = BlocProvider.of<ProfileBloc>(context);
    }
    return BlocManager(
      initState: (context) {
        print("calling from build");
        fetchProfile();
      },
      child: BlocListener(
        bloc: _bloc,
        listener: (BuildContext context, ProfileBlocState state) {
          if (state is ProfileEventError) {
            print("${state.errorMessage}");
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, ProfileBlocState state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Builder(builder: (_context) {
                if (state is ProfileEventError) {
                  return Center(child: CommonErrorWidget(state.errorMessage),);
                } else if (state is ProfileEventSuccess) {
                  _profileData=state.response;
                  return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopRow(),
                        SizedBox(height: 20,),
                        _buildBottomRow()
                      ],
                    ),
                  );
                }
                return Center(child: CommonLoadingWidget());
              }),
            );
          },
        ),
      ),
    );
  }

  _buildTopRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(36)),
          child: FadeInImage(
              fit: BoxFit.fitWidth,
              height: 75,
              width: 75,
              placeholder: CacheImage(_profileData.profileUrl),
              image: CacheImage(_profileData.profileUrl)),
        ),
        SizedBox(width: 30,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                _profileData.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 20,top: 8,bottom: 8),
                child: Row(
                  children: [
                    Text(
                      _profileData.rating.toString(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(width: 10,),
                    Text(
                     StringConstants.RATING_TITLE,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  _buildBottomRow(){
    return  Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width/3.3,
            color: Colors.orange,
            child: buildStatusWidget(_profileData.tournamentPlayed.toString(),StringConstants.TOURNAMENT_PLAYED,Colors.red),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/3.3,
          color: Colors.purple,
          child: buildStatusWidget(_profileData.tournamentWon.toString(),StringConstants.TOURNAMENT_WON,Colors.red),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width/3.3,
            color: Colors.red,
            child: buildStatusWidget(_profileData.winPercentage.toString() +"%",StringConstants.WIN_PERCENTAGE,Colors.red),
          ),
        )
      ],
    );
  }


  buildStatusWidget(String count,String status,Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(count,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
        SizedBox(height: 5,),
        Text(status,textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 14),)
      ],
    ),
  );
  }

  @override
  void dispose() {
    _bloc=null;
    super.dispose();
}
}

