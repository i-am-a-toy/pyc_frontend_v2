import 'package:pyc/common/enum/role.dart';

class UserResponse {
  final int id;
  final String? cellId;
  final Role role;
  final String gender;
  final String rank;
  final String name;
  final int? age;
  final DateTime? birth;
  final String? contact;
  final String? zipCode;
  final String? address;
  final String image;
  final bool isLongAbsence;

  UserResponse(
    this.id,
    this.cellId,
    this.role,
    this.gender,
    this.rank,
    this.name,
    this.age,
    this.birth,
    this.contact,
    this.zipCode,
    this.address,
    this.image,
    this.isLongAbsence,
  );

  UserResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        cellId = json['cellId'],
        role = Role.getByName(json['role']),
        gender = json['gender'],
        rank = json['rank'],
        name = json['name'],
        age = json['age'],
        birth = json['birth'] != null ? DateTime.parse(json["birth"]) : null,
        contact = json['contact'],
        zipCode = json['zipCode'],
        address = json['address'],
        image = json['image'],
        isLongAbsence = json['isLongAbsence'];

  static UserResponse init() {
    return UserResponse(
      1,
      null,
      Role.undefined,
      'NONE',
      'NONE',
      '',
      null,
      null,
      null,
      null,
      null,
      '',
      false,
    );
  }
}
