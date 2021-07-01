import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0, // to remove the line
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/35312200'),
            ),
            SizedBox(width: 15),
            Text(
              'Chats',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 16.0,
                color: Colors.white,
              ),
              radius: 15,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              child: Icon(
                Icons.edit,
                size: 16.0,
                color: Colors.white,
              ),
              radius: 15,
              backgroundColor: Colors.blue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 15),
                    Text(
                      'Search',
                      style: TextStyle(fontSize: 20.0),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                child: ListView.separated(
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) => SizedBox(width: 20),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true, // IS USED TO BUILD THE WHOLE LIST
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(),
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/35312200'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Mohamed Abdelfatah',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Hello There My Name Is Ahmed Mohamed Abdelfatah And Iam Civil Engineer And Programmer',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text('02:00 pm'),
                  ],
                )
              ],
            ),
          )
        ],
      );
  Widget buildStoryItem() => Container(
        width: 60,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/35312200'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 3.0,
                    end: 3.0,
                  ),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              'Ahmed Mohamed Abdelfatah',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
}
