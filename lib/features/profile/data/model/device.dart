import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:firebasestarter/features/profile/data/model/device_field.dart';

class Device  extends DatabaseItem{
  String id;
  DateTime createdAt;
  bool expired;
  bool uninstalled;
  int lastUpdatedAt;
  DeviceDetails deviceInfo;
  String token;

  Device({this.id, this.token,this.createdAt,this.expired,this.uninstalled,this.lastUpdatedAt,this.deviceInfo}):super(id);

  Device.fromDS(String id, Map<String,dynamic> data):
    id=id,
    createdAt=data[DeviceFields.createdAt]?.toDate(),
    expired=data[DeviceFields.expired],
    uninstalled=data[DeviceFields.uninstalled] ?? false,
    lastUpdatedAt=data[DeviceFields.lastUpdatedAt],
    deviceInfo=DeviceDetails.fromJson(data[DeviceFields.deviceInfo]),
    token=data[DeviceFields.token],
    super(id);
  
  Map<String,dynamic> toMap()  {
    return {
      DeviceFields.createdAt: createdAt,
      DeviceFields.deviceInfo: deviceInfo.toJson(),
      DeviceFields.expired:expired,
      DeviceFields.uninstalled:uninstalled,
      DeviceFields.lastUpdatedAt: lastUpdatedAt,
      DeviceFields.token: token,
    };
  }
}

class DeviceDetails {
  String device;
  String model;
  String osVersion;
  String platform;

  DeviceDetails({this.device, this.model, this.osVersion, this.platform});

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    device = json[DeviceDetailsFields.device];
    model = json[DeviceDetailsFields.model];
    osVersion = json[DeviceDetailsFields.osVersion];
    platform = json[DeviceDetailsFields.platform];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DeviceDetailsFields.device] = this.device;
    data[DeviceDetailsFields.model] = this.model;
    data[DeviceDetailsFields.osVersion] = this.osVersion;
    data[DeviceDetailsFields.platform] = this.platform;
    return data;
  }
}
