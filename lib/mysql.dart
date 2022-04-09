import 'package:mysql1/mysql1.dart';

class MySql {
  static const _host = "10.0.2.2";
  static const _user = "root";
  static const _password = "root";
  static const _port = 3306;
  final _db = "flutter_infinite_list";
  MySqlConnection? connection;

  MySql() {
    getConnection();
    Future.delayed(Duration(seconds: 3), () {
      connection != null
          ? print("connection success") //debug
          : print("connection failed"); //debug
    });
  }

  Future<void> getConnection() async {
    final settings = ConnectionSettings(
        host: _host, port: _port, user: _user, password: _password, db: _db);
    connection = await MySqlConnection.connect(settings);
  }
}
