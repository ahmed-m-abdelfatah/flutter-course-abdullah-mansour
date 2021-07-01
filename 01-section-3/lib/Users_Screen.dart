import 'package:flutter/material.dart';

class userModel {
  final int id;
  final String name;
  final String phone;

  userModel({@required this.id, @required this.name, @required this.phone});
}

class UsersScreen extends StatelessWidget {
  List<userModel> users = [
    userModel(id: 1, phone: '01000000000', name: 'Ahmed Mohamed Abdelfatah'),
    userModel(id: 2, phone: '01066660000000', name: 'Ahmed Mohamed Abdelfatah'),
    userModel(id: 3, phone: '01000000', name: 'Ahmed Mohamed Abdelfatah'),
    userModel(id: 4, phone: '0100879646510000000', name: 'Ahmed Mohamed Abdelfatah'),
    userModel(id: 5, phone: '010086165130561105416586235682503179646510000000', name: 'Ahmed Mohamed Abdelfatah'),
    userModel(id: 6, phone: '0100879646510000000', name: 'Ahmed Mohamed Abdelfatah'),
    userModel(id: 7, phone: '0100879646510000000', name: 'Ahmed Mohamed Abdelfatah'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(userModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                '${user.id}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${user.phone}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
