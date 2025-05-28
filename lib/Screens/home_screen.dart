import 'package:flutter/material.dart';
import 'package:flutter_adv/Models/mood_entry.dart';
import 'package:flutter_adv/Screens/add_entry.dart';
import 'package:flutter_adv/mood_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MoodEntry> entries = [];

  void _addEntry(MoodEntry entry) {
    setState(() {
      entries.insert(0, entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOOD JOURNAL"),
      ),
      backgroundColor: Color.fromARGB(255, 56, 23, 117),
      body: entries.isEmpty
          ? const Center(
              child: Text(
              "No mood entries yet",
              style: TextStyle(color: Colors.white),
            ))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (ctx, index) {
                MoodCard(entry: entries[index]);
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const AddEntryScreen()));
          if (result != null) _addEntry(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
