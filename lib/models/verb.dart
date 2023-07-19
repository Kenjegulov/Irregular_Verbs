class Verb {
  final String infinitive;
  final String pastSimple;
  final String pastParticiple;
  final String sound;
  final String translation;
  final bool elected;
  String? id;

  Verb(
      {this.id,
      required this.infinitive,
      required this.pastSimple,
      required this.pastParticiple,
      required this.sound,
      required this.translation,
      required this.elected});

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      infinitive: json["infinitive"],
      pastSimple: json["pastSimple"],
      pastParticiple: json["pastParticiple"],
      sound: json["sound"],
      translation: json["translation"],
      elected: json["elected"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "infinitive": infinitive,
      "pastSimple": pastSimple,
      "pastParticiple": pastParticiple,
      "sound": sound,
      "translation": translation,
      "elected": elected,
    };
  }
}
