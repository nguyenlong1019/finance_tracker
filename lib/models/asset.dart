import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String assetId;
  final String name;
  final int value;
  final String userId; 

  Asset({
    required this.assetId,
    required this.name,
    required this.value,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'assetId': assetId,
      'name': name,
      'value': value,
      'userId': userId, 
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      assetId: map['assetId'],
      name: map['name'],
      value: map['value'],
      userId: map['userId'],
    );
  }
}

class AssetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAsset(Asset asset) async {
    await _firestore.collection('assets').doc(asset.assetId).set(asset.toMap());
  }

  Future<List<Asset>> getAssetsByUserId(String userId) async {
    QuerySnapshot assetSnapshot = await _firestore
      .collection('assets')
      .where('userId', isEqualTo: userId)
      .get();

    return assetSnapshot.docs
      .map((doc) => Asset.fromMap(doc.data() as Map<String, dynamic>))
      .toList().reversed.toList();
  }
}

