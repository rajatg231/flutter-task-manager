const String baseURL = "http://localhost:8080/api/v1/";

const Map<String, String> headers = {"Content-Type": "application/json"};

class Globals {
  static late String userID;

  static setUserID(String value) {
    userID = value; // add the setter method to set the value of userID
  }

  static getUserID() {
    return userID;
  }
}
