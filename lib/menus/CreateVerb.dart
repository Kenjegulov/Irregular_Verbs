import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irrefular_verbs/controllers/AddVerbController.dart';
import 'package:irrefular_verbs/services/VerbService.dart';

class AddVerb extends StatefulWidget {
  const AddVerb({super.key});

  @override
  State<AddVerb> createState() => _AddVerbState();
}

class _AddVerbState extends State<AddVerb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Verb'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: AddVerbController.infinitiveController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Error, Infinitive is empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Infinitive'),
                ),
                TextFormField(
                  controller: AddVerbController.pastSimpleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Error, Past Simple is empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Past Simple'),
                ),
                TextFormField(
                  controller: AddVerbController.pastParticipleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Error, Past Participle is empty";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Past Participle'),
                ),
                TextFormField(
                  controller: AddVerbController.soundController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Error, Sound is empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Sound'),
                ),
                TextFormField(
                  controller: AddVerbController.translationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Error, Translation is empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Translation'),
                ),
                CheckboxListTile(
                  value: AddVerbController.electedController,
                  onChanged: (v) {
                    setState(
                      () {
                        AddVerbController.electedController = v!;
                      },
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              backgroundColor: Colors.white.withOpacity(0.8),
                              title: const Text(
                                "Сиздин маалыматыныз жуктолуудо",
                                textAlign: TextAlign.center,
                              ),
                              children: [
                                CupertinoActivityIndicator(
                                  radius: 20,
                                  color: Colors.blue.withOpacity(0.8),
                                )
                              ],
                            );
                          });
                      await VerbService.add();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    } else {
                      null;
                    }
                  },
                  child: const Text('Add Verb'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
