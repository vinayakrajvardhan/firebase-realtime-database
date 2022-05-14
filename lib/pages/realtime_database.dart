import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FirebaseRealTimeDatabase extends StatefulWidget {
  const FirebaseRealTimeDatabase({Key? key}) : super(key: key);

  @override
  State<FirebaseRealTimeDatabase> createState() =>
      _FirebaseRealTimeDatabaseState();
}

class _FirebaseRealTimeDatabaseState extends State<FirebaseRealTimeDatabase> {
  final fb = FirebaseDatabase.instance;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final id = 'Id';
  final name = 'Name';

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref();
    return Scaffold(
      appBar: AppBar(
        title: Text('Real Time Database'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(id),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: myController,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: myController2,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                ref.child(myController.text).set(myController2.text).asStream();
                myController.clear();
                myController2.clear();
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.update({"3": "hello there"});
              },
              child: Text('Update'),
            ),
            Flexible(
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        ref.child(snapshot.key!).remove();
                      },
                      icon: Icon(Icons.delete),
                    ),
                    title: Text(snapshot.value.toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
