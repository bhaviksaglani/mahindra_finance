/// user_id : "583c3ac3f38e84297c002546"
/// email : "test@test.com"
/// name : "test@test.com"
/// given_name : "Hello"
/// family_name : "Test"
/// nickname : "test"
/// last_ip : "94.121.163.63"
/// logins_count : 15
/// created_at : "2016-11-28T14:10:11.338Z"
/// updated_at : "2016-12-02T01:17:29.310Z"
/// last_login : "2016-12-02T01:17:29.310Z"
/// email_verified : true

class UserModel {
  UserModel({
    String? userId,
    String? email,
    String? name,
    String? givenName,
    String? familyName,
    String? nickname,
    String? lastIp,
    int? loginsCount,
    String? createdAt,
    String? updatedAt,
    String? lastLogin,
    bool? emailVerified,
  }) {
    _userId = userId;
    _email = email;
    _name = name;
    _givenName = givenName;
    _familyName = familyName;
    _nickname = nickname;
    _lastIp = lastIp;
    _loginsCount = loginsCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _lastLogin = lastLogin;
    _emailVerified = emailVerified;
  }

  UserModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _email = json['email'];
    _name = json['name'];
    _givenName = json['given_name'];
    _familyName = json['family_name'];
    _nickname = json['nickname'];
    _lastIp = json['last_ip'];
    _loginsCount = json['logins_count'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _lastLogin = json['last_login'];
    _emailVerified = json['email_verified'];
  }
  String? _userId;
  String? _email;
  String? _name;
  String? _givenName;
  String? _familyName;
  String? _nickname;
  String? _lastIp;
  int? _loginsCount;
  String? _createdAt;
  String? _updatedAt;
  String? _lastLogin;
  bool? _emailVerified;
  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    String? givenName,
    String? familyName,
    String? nickname,
    String? lastIp,
    int? loginsCount,
    String? createdAt,
    String? updatedAt,
    String? lastLogin,
    bool? emailVerified,
  }) =>
      UserModel(
        userId: userId ?? _userId,
        email: email ?? _email,
        name: name ?? _name,
        givenName: givenName ?? _givenName,
        familyName: familyName ?? _familyName,
        nickname: nickname ?? _nickname,
        lastIp: lastIp ?? _lastIp,
        loginsCount: loginsCount ?? _loginsCount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        lastLogin: lastLogin ?? _lastLogin,
        emailVerified: emailVerified ?? _emailVerified,
      );
  String? get userId => _userId;
  String? get email => _email;
  String? get name => _name;
  String? get givenName => _givenName;
  String? get familyName => _familyName;
  String? get nickname => _nickname;
  String? get lastIp => _lastIp;
  int? get loginsCount => _loginsCount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get lastLogin => _lastLogin;
  bool? get emailVerified => _emailVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['email'] = _email;
    map['name'] = _name;
    map['given_name'] = _givenName;
    map['family_name'] = _familyName;
    map['nickname'] = _nickname;
    map['last_ip'] = _lastIp;
    map['logins_count'] = _loginsCount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['last_login'] = _lastLogin;
    map['email_verified'] = _emailVerified;
    return map;
  }
}
