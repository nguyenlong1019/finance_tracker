import 'package:cloud_firestore/cloud_firestore.dart';

class Save {
  final String saveId;
  final String userId; 
  final int targetAmount; 
  final DateTime targetDate; 
  final int currentAmount;

  Save({
    required this.saveId,
    required this.userId,
    required this.targetAmount,
    required this.targetDate,
    required this.currentAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'saveId': saveId,
      'userId': userId,
      'targetAmount': targetAmount,
      'targetDate': targetDate.toIso8601String(),
      'currentAmount': currentAmount,
    };
  }

  factory Save.fromMap(Map<String, dynamic> map) {
    return Save(
      saveId: map['saveId'],
      userId: map['userId'],
      targetAmount: map['targetAmount'],
      targetDate: DateTime.parse(map['targetDate']),
      currentAmount: map['currentAmount'],
    );
  }
}

class SaveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSave(Save save) async {
    DocumentReference docRef = _firestore.collection('saves').doc();
    String autoGeneratedId = docRef.id;

    Save newSave = Save(
      saveId: autoGeneratedId,
      userId: save.userId,
      targetAmount: save.targetAmount,
      currentAmount: save.currentAmount,
      targetDate: save.targetDate,
    );

    await docRef.set(newSave.toMap());
  }

  Future<List<Save>> getSavesByUserId(String userId) async {
    QuerySnapshot saveSnapshot = await _firestore
      .collection('saves')
      .where('userId', isEqualTo: userId)
      .get();

    return saveSnapshot.docs
      .map((doc) => Save.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
  }
}
