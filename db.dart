
import 'package:sqljocky5/sqljocky.dart';

final connSettings = ConnectionSettings(
  user: "m1234567",
  password: "m1234567",
  host: "db4free.net",
  port: 3306,
  db: "mysqldbm1234567",
);

main() async {

  print('Connecting...');
  var conn = await MySqlConnection.connect(connSettings);
  try {
    final results = await conn.execute('select * from names');
    print('Getting rows...');
    await results.forEach((row) {
      print(' > ${row[0]} (${row.byName('alias')})');
    });
  } finally {
    print('Closing...');
    await conn.close();
  }
  print('Finished');

}