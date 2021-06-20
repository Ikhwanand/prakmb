import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget{

  @override
  State createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage>{
  FirebaseMessaging fm = FirebaseMessaging();

  NotificationPageState(){
    fm.getToken().then((value) => print('token: $value'));
    fm.configure(
      onMessage: (Map<String, dynamic> msg) async{
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(msg['data']['judul']),
                subtitle: Text(msg['data']['isi']),
              ),
            ), //AllertDialog
        );
      },//ketika aplikasi di fireground
      onResume: (Map<String, dynamic> msg) async{
        print('FCM data onResume: $msg');
      }, //ketika aplikasi berjalan di background
      onLaunch: (Map<String, dynamic> msg) async{
        print('FCM data onLaunch: $msg');
      }, //ketika aplikasi tidak berjalan
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FCM'),),
    );
  }
}
