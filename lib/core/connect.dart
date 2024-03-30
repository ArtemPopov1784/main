import 'package:flutter/foundation.dart';
import 'package:mssql_connection/mssql_connection.dart';

void connect() async {
  try {
    MssqlConnection mssqlConnection = MssqlConnection.getInstance();
    await mssqlConnection.connect(
      ip: 'diplomEventsDB.mssql.somee.com',
      port: '1433',
      databaseName: 'diplomEventsDB',
      username: 'Artem1784Popov_SQLLogin_1',
      password: '17082004',
      timeoutInSeconds: 15,
    );
    if (kDebugMode) {
      print("OK");
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}


// workstation id=diplomEventsDB.mssql.somee.com;packet size=4096;user id=Artem1784Popov_SQLLogin_1;pwd=17082004;data source=diplomEventsDB.mssql.somee.com;persist security info=False;initial catalog=diplomEventsDB;TrustServerCertificate=True