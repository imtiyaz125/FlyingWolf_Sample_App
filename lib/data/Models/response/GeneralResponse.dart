

class GeneralResponse {
  GeneralResponse({Map<String, dynamic> json, this.message, this.code, this.success});

  bool success;
  int code;
  String message;

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    code = json["code"];
    message = json["message"];
  }
}
