import 'package:hive/hive.dart';

part 'doctor.g.dart';

@HiveType(typeId: 1)
class Doctor {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? profilePic;

  @HiveField(4)
  bool? favorite;

  @HiveField(5)
  String? primaryContactNo;

  @HiveField(6)
  String? rating;

  @HiveField(7)
  String? emailAddress;

  @HiveField(8)
  String? qualification;

  @HiveField(9)
  String? description;

  @HiveField(10)
  String? specialization;

  @HiveField(11)
  String? languagesKnown;

  @HiveField(12)
  bool? edit = false;

  @HiveField(13)
  String? day;

  @HiveField(14)
  String? month;

  @HiveField(15)
  String? year;

  @HiveField(16)
  String? bloodGroup;

  @HiveField(17)
  String? height;

  @HiveField(18)
  String? weight;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.favorite,
      this.primaryContactNo,
      this.rating,
      this.emailAddress,
      this.qualification,
      this.description,
      this.specialization,
      this.languagesKnown});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    favorite = json['favorite'];
    primaryContactNo = json['primary_contact_no'];
    rating = json['rating'];
    emailAddress = json['email_address'];
    qualification = json['qualification'];
    description = json['description'];
    specialization = json['specialization'];
    languagesKnown = json['languagesKnown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_pic'] = profilePic;
    data['favorite'] = favorite;
    data['primary_contact_no'] = primaryContactNo;
    data['rating'] = rating;
    data['email_address'] = emailAddress;
    data['qualification'] = qualification;
    data['description'] = description;
    data['specialization'] = specialization;
    data['languagesKnown'] = languagesKnown;
    return data;
  }
}
