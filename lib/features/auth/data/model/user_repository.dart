import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info/package_info.dart';
import 'package:firebasestarter/core/data/res/data_constants.dart';
import 'package:firebasestarter/features/notification/data/service/push_notification_service.dart';
import 'package:firebasestarter/features/profile/data/model/device.dart';
import 'package:firebasestarter/features/profile/data/model/device_field.dart';
import 'package:firebasestarter/features/profile/data/model/user.dart';
import 'package:firebasestarter/features/profile/data/model/user_field.dart';
import 'package:firebasestarter/features/profile/data/service/user_db_service.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;
  String _error;
  StreamSubscription _userListener;
  UserModel _fsUser;
  Device currentDevice;
  final PushNotificationService pnService;
  bool _loading;

  UserRepository.instance(this.pnService)
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn(scopes: ['email']) {
    _error = '';
    _loading = true;
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  String get error => _error;
  Status get status => _status;
  User get fbUser => _user;
  UserModel get user => _fsUser;
  bool get isLoading => _loading;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      _error = '';
      return true;
    } catch (e) {
      _error = e.message;
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    _fsUser = null;
    _userListener.cancel();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
      _fsUser = null;
      _user = null;
    } else {
      _user = firebaseUser;
      _saveUserRecord();
      _userListener = userDBS.streamSingle(_user.uid).listen((user) {
        _fsUser = user;
        _loading = false;
        notifyListeners();
      });
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> _saveUserRecord() async {
    if (_user == null) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    UserModel user = UserModel(
      email: _user.email,
      name: _user.displayName,
      photoUrl: _user.photoURL,
      id: _user.uid,
      registrationDate: DateTime.now().toUtc(),
      lastLoggedIn: DateTime.now().toUtc(),
      buildNumber: buildNumber,
      introSeen: false,
    );
    UserModel existing = await userDBS.getSingle(_user.uid);
    if (existing == null) {
      await userDBS.createItem(user, id: _user.uid);
      _fsUser = user;
    } else {
      await userDBS.updateData(_user.uid, {
        UserFields.lastLoggedIn: FieldValue.serverTimestamp(),
        UserFields.buildNumber: buildNumber,
      });
    }
    _saveDevice(user);
  }

  Future<void> _saveDevice(UserModel user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    DeviceDetails deviceDescription;
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceDescription = DeviceDetails(
        device: deviceInfo.device,
        model: deviceInfo.model,
        osVersion: deviceInfo.version.sdkInt.toString(),
        platform: 'android',
      );
    }
    if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceDescription = DeviceDetails(
        osVersion: deviceInfo.systemVersion,
        device: deviceInfo.name,
        model: deviceInfo.utsname.machine,
        platform: 'ios',
      );
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    final nowMS = DateTime.now().toUtc().millisecondsSinceEpoch;
    if (user.buildNumber != buildNumber) {
      userDBS.updateData(user.id, {
        UserFields.buildNumber: buildNumber,
        UserFields.lastUpdated: nowMS,
      });
    }
    userDeviceDBS.collection =
        "${AppDBConstants.usersCollection}/${user.id}/devices";
    Device exsiting = await userDeviceDBS.getSingle(deviceId);
    if (exsiting != null) {
      var token = exsiting.token ?? await pnService.init();
      await userDeviceDBS.updateData(deviceId, {
        DeviceFields.lastUpdatedAt: nowMS,
        DeviceFields.expired: false,
        DeviceFields.uninstalled: false,
        DeviceFields.token: token,
      });
      currentDevice = exsiting;
    } else {
      var token = await pnService.init();
      Device device = Device(
        createdAt: DateTime.now().toUtc(),
        deviceInfo: deviceDescription,
        token: token,
        expired: false,
        id: deviceId,
        lastUpdatedAt: nowMS,
        uninstalled: false,
      );
      await userDeviceDBS.createItem(device, id: deviceId);
      currentDevice = device;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _userListener.cancel();
    super.dispose();
  }
}
