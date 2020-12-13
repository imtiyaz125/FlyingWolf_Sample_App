class RecommendedRequest {
  int limit;
  String status;
  String cursor;

  RecommendedRequest({this.limit, this.status,this.cursor});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map["limit"] = limit;
    map["status"] = status;
    if (cursor != null) map["cursor"] = cursor;
    return map;
  }
}
