import 'package:bluestack_assignment/data/Models/response/GeneralResponse.dart';

/// code : 200
/// success : true
/// data : {"name":"John Day","profile_url":"https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U","rating":1000,"tournament_played":100,"tournament_won":50,"win_percentage":50}

class ProfileResponse extends GeneralResponse{
  ProfileData _data;

  int get code => super.code;
  bool get success => super.success;
  ProfileData get data => _data;
  String get message => super.message;

  ProfileResponse({
      int code,
      bool success,
    ProfileData data,
  String message}){
    super.code = code;
    super.success = success;
    super.message=message;
    _data = data;
}

  ProfileResponse.fromJson(dynamic json) {
    super.code = json["code"];
    super.success = json["success"];
    _data = json["data"] != null ? ProfileData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = super.code;
    map["success"] = super.success;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// name : "John Day"
/// profile_url : "https://i.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U"
/// rating : 1000
/// tournament_played : 100
/// tournament_won : 50
/// win_percentage : 50

class ProfileData {
  String _name;
  String _profileUrl;
  int _rating;
  int _tournamentPlayed;
  int _tournamentWon;
  int _winPercentage;

  String get name => _name;
  String get profileUrl => _profileUrl;
  int get rating => _rating;
  int get tournamentPlayed => _tournamentPlayed;
  int get tournamentWon => _tournamentWon;
  int get winPercentage => _winPercentage;

  ProfileData({
      String name,
      String profileUrl,
      int rating,
      int tournamentPlayed,
      int tournamentWon,
      int winPercentage}){
    _name = name;
    _profileUrl = profileUrl;
    _rating = rating;
    _tournamentPlayed = tournamentPlayed;
    _tournamentWon = tournamentWon;
    _winPercentage = winPercentage;
}

  ProfileData.fromJson(dynamic json) {
    _name = json["name"];
    _profileUrl = json["profile_url"];
    _rating = json["rating"];
    _tournamentPlayed = json["tournament_played"];
    _tournamentWon = json["tournament_won"];
    _winPercentage = json["win_percentage"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["profile_url"] = _profileUrl;
    map["rating"] = _rating;
    map["tournament_played"] = _tournamentPlayed;
    map["tournament_won"] = _tournamentWon;
    map["win_percentage"] = _winPercentage;
    return map;
  }

}