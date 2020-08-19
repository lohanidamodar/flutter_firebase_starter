import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:firebasestarter/core/data/res/data_constants.dart';
import 'package:firebasestarter/features/profile/data/model/device.dart';
import 'package:firebasestarter/features/profile/data/model/user.dart';

DatabaseService<UserModel> userDBS = DatabaseService<UserModel>(
    AppDBConstants.usersCollection,
    toMap: (user) => user.toMap(),
    fromDS: (id, data) => UserModel.fromDS(id, data));

UserDeviceDBService userDeviceDBS = UserDeviceDBService("devices");

class UserDeviceDBService extends DatabaseService<Device> {
  String collection;
  UserDeviceDBService(this.collection)
      : super(collection,
            fromDS: (id, data) => Device.fromDS(id, data),
            toMap: (device) => device.toMap());

  Stream<List<Device>> getAllModels() {
    return FirebaseFirestore.instance
        .collectionGroup(collection)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => fromDS(doc.id, doc.data())).toList());
  }
}
