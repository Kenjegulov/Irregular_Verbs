import 'package:flutter/material.dart';

class Verbs extends StatefulWidget {
  const Verbs({super.key});

  @override
  State<Verbs> createState() => _VerbsState();
}

class _VerbsState extends State<Verbs> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.green,
          child: ListTile(
            title: const Text("Infinitive: Verb"),
            subtitle: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Past Simple: 1'),
                Text('Past Participle: 2'),
              ],
            ),
            onTap: () {
              // Действие при нажатии на глагол
            },
          ),
        );
      },
    );
  }
}