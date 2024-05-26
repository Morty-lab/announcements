import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAnnouncementForm extends StatefulWidget {
  @override
  _AddAnnouncementFormState createState() => _AddAnnouncementFormState();
}

class _AddAnnouncementFormState extends State<AddAnnouncementForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dateController = TextEditingController();
  final _imageController =
      TextEditingController(); // Controller for storing the image URL

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        // Manually specify the filename
        String fileName = 'your_custom_filename.jpg'; // Customize as neededs
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = ref.putFile(File(image.path));
        await uploadTask.whenComplete(() async {
          String downloadURL = await ref.getDownloadURL();
          setState(() {
            _imageController.text = downloadURL;
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Announcement'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icon for the back button
          onPressed: () => Navigator.of(context).pop(), // Action to pop the current route
        ),
      ),
      body: Center( // Wrap the Container with a Center widget
        child: Container(
          width: 500, // Specify the width of the Container
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Repeated for clarity
            borderRadius: BorderRadius.circular(12.0), // Apply uniform rounding
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: Offset(0, 3), // Changes position of shadow
              ),
            ], // Add padding inside the container
          ), // Add boxShadow here
          child: Form(
            key: _formKey,
            child: SingleChildScrollView( // Use SingleChildScrollView for scrolling
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Post Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _contentController,
                      maxLines: null,
                      decoration: InputDecoration(labelText: 'Post Content'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter content';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Select Image'),
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(labelText: 'Selected Image Path'),
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save the announcement
                        print('Saving...');
                        CollectionReference announcements =
                            FirebaseFirestore.instance.collection('announcements');
                        announcements.add({
                          'postTitle': _titleController.text,
                          'postContent': _contentController.text,
                          'postDate': Timestamp.now(),
                          'imageLink': _imageController.text,
                        }).then((value) => print('Announcement Saved'))
                      .catchError((error) =>
                                print('Failed to save announcement: $error'));
                        print("Saved");

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
