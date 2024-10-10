import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String assetId;
  final String name;
  final int value;

  Asset({
    required this.assetId,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'assetId': assetId,
      'name': name,
      'value': value,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      assetId: map['assetId'],
      name: map['name'],
      value: map['value'],
    );
  }
}

class AssetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAsset(String userId, Asset asset) async {
    await _firestore
      .collection('users')
      .doc(userId)
      .collection('assets')
      .doc(asset.assetId)
      .set(asset.toMap());
  }

  Future<List<Asset>> getAssets(String userId) async {
    QuerySnapshot assetSnapshot = await _firestore
      .collection('users')
      .doc(userId)
      .collection('assets')
      .get();

    return assetSnapshot.docs
      .map((doc) => Asset.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
  }
}