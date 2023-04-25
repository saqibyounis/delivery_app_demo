class User {
  int _id;
  String _username;
  String _email;
  String _firstName;
  String _lastName;
  String _gender;
  String _image;
  String _token;

  User(this._id, this._username, this._email, this._firstName, this._lastName,
      this._gender, this._image, this._token);

  String get token => _token;

  String get image => _image;

  String get gender => _gender;

  String get lastName => _lastName;

  String get firstName => _firstName;

  String get email => _email;

  String get username => _username;

  int get id => _id;

  static User getUserFromMap(Map response) {
    return User(
        response["id"],
        response["username"],
        response["email"],
        response["firstName"],
        response["lastName"],
        response["gender"],
        response["image"],
        response["token"]);
  }
}
