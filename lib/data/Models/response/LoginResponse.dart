class LoginReponse{
  bool _isUserExist=false;
  bool _isValidCredentials=false;
  String _errorMessage;

  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
  }

  bool get isUserExist => _isUserExist;

  set isUserExist(bool value) {
    _isUserExist = value;
  }

  bool get isValidCredentials => _isValidCredentials;

  set isValidCredentials(bool value) {
    _isValidCredentials = value;
  }
}