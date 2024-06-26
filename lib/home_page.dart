import 'package:flutter/material.dart';
import 'package:sqflite_project/sqldb.dart';

class HomePage extends StatelessWidget {
  final SqlDb sql = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () async {
                int response = await sql.insertData(
                  "INSERT INTO 'notes' ('title') VALUES ('note two')",
                );
                print(response);
              },
              child: Text('Add Data'),
              color: Colors.blue,
            ),
            MaterialButton(
              onPressed: () async {
                List<Map<String, dynamic>> response = await sql.readData(
                  "SELECT * FROM 'notes'",
                );
                print(response);
              },
              child: Text('Read Data'),
              color: Colors.yellow,
            ),
            MaterialButton(
              onPressed: () async {
                var response = await sql.updateData(
                    "UPDATE 'notes' SET 'title'='note six' WHERE id=4 ");
              },
              child: Text('Edit Data'),
              color: Colors.green,
            ),
            MaterialButton(
              onPressed: () async {
                var response =
                    await sql.deleteData("DELETE FROM 'notes' WHERE id=2");
                print(response);
              },
              child: Text('Delete Data'),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
