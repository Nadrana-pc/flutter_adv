import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_adv/Models/mood_entry.dart';
import 'package:intl/intl.dart';

class MoodCard extends StatelessWidget {
  final MoodEntry entry;
  const MoodCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Text(
          entry.emoji,
          style: TextStyle(fontSize: 28),
        ),
        title: Text(entry.note),
        subtitle: Text(DateFormat.yMMMd().format(entry.date)),
        trailing: Image.file(
          File(entry.path),
          fit: BoxFit.cover,
          width: 50,
        ),
      ),
    );
  }
}
