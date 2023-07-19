import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irrefular_verbs/services/VerbService.dart';
import 'package:irrefular_verbs/verbs.dart';

import 'menus/CreateVerb.dart';
import 'models/verb.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Irregular Verbs'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/d/de/Flag_of_the_United_States.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 10),
                  Text('Избранные'),
                ],
              ),
              onTap: () {
                // Действие для пункта меню 1
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.add),
                SizedBox(width: 10),
                Text('Добавить глаголы'),
              ]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddVerb()),
                );
              },
            ),
            ListTile(
              title: const Text('Пункт меню 2'),
              onTap: () {
                // Действие для пункта меню 2
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: VerbService.read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CupertinoActivityIndicator(
                radius: 25,
              ));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final List<Verb> verbs = snapshot.data!.docs
                  .map((e) => Verb.fromJson(e.data() as Map<String, dynamic>)
                    ..id = e.id)
                  .toList();
              return ListView.builder(
                itemCount: verbs.length,
                itemBuilder: (context, index) {
                  final verb = verbs[index];
                  return Card(
                    child: ListTile(
                      leading: Text(verb.infinitive),
                      title: Text(verb.pastSimple),
                      subtitle: Text(verb.pastParticiple),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: verb.elected,
                            onChanged: (v) async {
                              await VerbService.update(verb);
                            },
                          ),
                          IconButton(
                              onPressed: () async {
                                await VerbService.delete(verb);
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("Error");
            }
          },
        ),
      ),
    );
  }
}
