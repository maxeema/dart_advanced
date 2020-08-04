
import 'package:sqljocky5/connection/connection.dart';
import 'package:sqljocky5/sqljocky.dart';

import 'db.dart';

main() async {

  print('Connecting...');
  final conn = await MySqlConnection.connect(connSettings);

  try {
    print('Modifying...');
    await modify(await conn.begin());
    final results = await conn.execute('SELECT * FROM names');
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

modify(Transaction trans) async {
  try {
    // clear db
    print(' - Clearing...');
    await trans.execute("DELETE from `names`");
    //
    print(' - Filling...');
    // insert via prepared
    final prepared = await trans.prepare(
        'INSERT INTO `names` (`name`, `alias`) VALUES (?, ?)');
    await prepared.execute(['Maksim', 'Maxi']);
    await prepared.execute(['Everly', 'Eve']);
    // insert via raw query
    await await trans.insertNameAlias('Cutie', 'Love');
    // commit data
    print(' - Committing...');
    await trans.commit();
  } catch (err) {
    await trans.rollback();
    print(' - Rolled back on error: $err');
  }
}

extension TransactionExt on Transaction {
  Future<StreamedResults> insertNameAlias(String name, String alias)
      => execute("INSERT INTO `names` (`name`, `alias`) VALUES ('$name', '$alias')");
}

