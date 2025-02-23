class UsersModel {
  late final String name;
  late final String age;
  late final String uid;
  late final String address;
  late final String profession;
  late final String accnt;


  UsersModel(
      {
        required this.name,
        required this.age,
        required this.uid,
        required this.address,
        required this.profession,

        required this.accnt,
        });

  UsersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    age = json['age'] ?? '';  // Default to 0 if null
    uid = json['uid'] ?? '';  // Default to 0 if null
    address = json['address'] ?? '';
    profession = json['profession'] ?? '';

    accnt = json['accnt'] ?? '';
     // Default to 0 if null
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['age'] = age;
    _data['uid'] = uid;
    _data['address'] = address;
    _data['profession'] = profession;
    _data['accnt'] = accnt;

    return _data;
  }
}