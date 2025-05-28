import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_adv/Models/mood_entry.dart';
import 'package:image_picker/image_picker.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _noteController = TextEditingController();
  String _selectedEmoji = "😊";
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picker_file = await picker.pickImage(source: ImageSource.gallery);
    if (picker_file != null) {
      setState(() {
        _image = File(picker_file.path);
      });
    }
  }

  void _saveEntry() {
    if (_image == null || _noteController.text.isEmpty) return;
    final entry = MoodEntry(
        emoji: _selectedEmoji,
        note: _noteController.text,
        date: DateTime.now(),
        path: _image!.path);
    Navigator.of(context).pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 23, 117),
      appBar: AppBar(
        title: const Text(
          "What's your mood today ? ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["😊", "😢", "😠", "😌", "😴"]
                    .map((e) => GestureDetector(
                          onTap: () => setState(() {
                            _selectedEmoji = e;
                          }),
                          child: Container(
                            width: 70,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(204, 158, 129, 226),
                                      Color.fromARGB(0, 97, 23, 193),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              e,
                              textScaleFactor: 1.5,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ))
                    .toList()),
            const SizedBox(
              height: 30,
            ),
            TextField(
                controller: _noteController,
                maxLines: 5,
                decoration: const InputDecoration(
                  label: Text(
                    'Note',
                    style: TextStyle(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 30,
            ),
            _image == null
                ? const Text(
                    "No image selected",
                    style: TextStyle(color: Colors.white),
                  )
                : Image.file(
                    _image!,
                    height: 100,
                  ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
                icon: const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
                label: const Text(
                  "Pick Image",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _pickImage),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: _saveEntry,
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ))
          ]),
        ),
      ),
    );
  }
}
