import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_const.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Flutter App', style: TextStyle(color: w)),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: onNotification,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: t,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadiusDirectional.only(topStart: Radius.circular(20)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage('https://place-hold.it/300x500'),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: b.withOpacity(.7),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Test',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0, color: r),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onNotification() {
    print('Notification Clicked');
  }
}
