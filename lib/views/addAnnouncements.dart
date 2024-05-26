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
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Post Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
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
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Post Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Selected Image Path'),
                readOnly: true, // Make this field read-only
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the announcement
                    print('Saving...');
                    // Save the announcement
                    CollectionReference announcements =
                        FirebaseFirestore.instance.collection('announcements');
                    announcements
                        .add({
                          'title': _titleController.text,
                          'content': _contentController.text,
                          'date': _dateController.text,
                          'imageUrl': _imageController
                              .text, // Use the image URL from Firebase Storage
                        })
                        .then((value) => print('Announcement Saved'))
                        .catchError((error) =>
                            print('Failed to save announcement: $error'));
                    // Implement saving logic here
                    print("Saved");
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
