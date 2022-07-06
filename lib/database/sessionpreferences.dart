import 'package:trackerapp/models/usermodels.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionPreferences {
  final String _userId = 'userId';

  final String _fullName = 'fullName';
  final String _userName = 'userName';
  final String _email = 'email';

  final String _loggedIn = 'loggedIn';

  final String _liveUrl = 'liveUrl';
  final String _imageSelection = 'imageSelection';
  final String _companyName = "_companyName";

  Future<void> setCompanySettings(CompanySettings settings) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_liveUrl, settings.baseUrl!);
    sharedPreferences.setString(_imageSelection, settings.imageName!);
  }

  Future<CompanySettings> getCompanySettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return CompanySettings(
        baseUrl: sharedPreferences.getString(_liveUrl),
        imageName: sharedPreferences.getString(_imageSelection));
  }

  Future<void> setLoggedInUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_userId, user.id!);

    sharedPreferences.setString(_fullName, user.fullname!);
    sharedPreferences.setString(_userName, user.username!);
    sharedPreferences.setString(_email, user.email!);
    sharedPreferences.setString(_companyName, user.companyName!);
  }

  Future<User> getLoggedInUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return User(
        id: sharedPreferences.getInt(_userId),
        fullname: sharedPreferences.getString(_fullName),
        username: sharedPreferences.getString(_userName),
        email: sharedPreferences.getString(_email),
        companyName: sharedPreferences.getString(_companyName));
  }

  void setLoggedInStatus(bool loggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_loggedIn, loggedIn);
  }

  Future<bool?> getLoggedInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_loggedIn);
  }
}
