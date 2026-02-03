class DeviceKeyModel {
  String? activationKey;
  int? expiresInSeconds;
  String? expiresAt;

  DeviceKeyModel({this.activationKey, this.expiresInSeconds, this.expiresAt});

  DeviceKeyModel.fromJson(Map<String, dynamic> json) {
    activationKey = json['activationKey'];
    expiresInSeconds = json['expiresInSeconds'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activationKey'] = this.activationKey;
    data['expiresInSeconds'] = this.expiresInSeconds;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}
