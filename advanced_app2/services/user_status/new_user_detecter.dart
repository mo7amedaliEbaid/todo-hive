import 'package:hive/hive.dart';

class NewUserDetecter {

  /// Watch user status
  bool isNewUsingApp() {
    // Getting the value from the box if it's not null(if the user is old one), if it's null, the user is new one
    
    return Hive.box("locals").get('isNewUsingApp') ?? true;
    
  }
}
