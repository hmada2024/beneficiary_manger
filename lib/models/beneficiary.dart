class Beneficiary {
  final int? id;
  final String name;
  final int familySize;
  final String cardNumber;
  final int breadCount;

  Beneficiary({this.id, required this.name, required this.familySize, required this.cardNumber, required this.breadCount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'familySize': familySize,
      'cardNumber': cardNumber,
      'breadCount': breadCount,
    };
  }

  factory Beneficiary.fromMap(Map<String, dynamic> map) {
    return Beneficiary(
      id: map['id'],
      name: map['name'],
      familySize: map['familySize'],
      cardNumber: map['cardNumber'],
      breadCount: map['breadCount'],
    );
  }
}
