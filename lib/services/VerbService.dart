import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irrefular_verbs/controllers/AddVerbController.dart';
import 'package:irrefular_verbs/models/verb.dart';

class VerbService {
  static final db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> read() {
    return db.collection("verbs").snapshots();
  }

  // add data in verbs
  static Future<void> add() async {
    final verb = Verb(
        infinitive: AddVerbController.infinitiveController.text,
        pastSimple: AddVerbController.pastSimpleController.text,
        pastParticiple: AddVerbController.pastParticipleController.text,
        sound: AddVerbController.soundController.text,
        translation: AddVerbController.translationController.text,
        elected: AddVerbController.electedController);
    await db.collection("verbs").add(verb.toJson());
  }

// update data in verbs
static Future<void> update(Verb verb) async {
  await db
      .collection("verbs")
      .doc(verb.id)
      .update({"elected": !verb.elected});
}

// delete data in verbs
static Future<void> delete(Verb verb) async {
  await db.collection("verbs").doc(verb.id).delete();
}
}
