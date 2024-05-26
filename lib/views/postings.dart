import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'addAnnouncements.dart'; // For formatting dates

class PostingsView extends StatefulWidget {
  const PostingsView({super.key});

  @override
  State<PostingsView> createState() => _PostingsViewState();
}

class _PostingsViewState extends State<PostingsView> {
  late Stream<QuerySnapshot> _announcementsStream;

  @override
  void initState() {
    super.initState();
    _announcementsStream =
        FirebaseFirestore.instance.collection('announcements').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Announcements')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _announcementsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  leading: Image.network(data['imageLink'] ?? ""),
                  title: Text(data['postTitle'] ?? ""),
                  subtitle: Text(data['postContent'] ?? ""),
                  // trailing: Text(data['postDate'] ?? DateTime.timestamp() ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAnnouncementForm()),
          );
        },
        tooltip: 'Save',
        child: Icon(Icons.add),
      ),
    );
  }
}
