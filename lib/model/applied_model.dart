// To parse this JSON data, do
//
//     final applierData = applierDataFromJson(jsonString);

import 'dart:convert';

List<ApplierData> applierDataFromJson(String str) => List<ApplierData>.from(json.decode(str).map((x) => ApplierData.fromJson(x)));

String applierDataToJson(List<ApplierData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApplierData {
  ApplierData({
    required this.applyId,
    required this.applierId,
    required this.employerId,
    required this.postId,
    required this.createdAt,
  });

  int applyId;
  ApplierId applierId;
  EmployerId employerId;
  PostId postId;
  DateTime createdAt;

  factory ApplierData.fromJson(Map<String, dynamic> json) => ApplierData(
    applyId: json["ApplyId"],
    applierId: ApplierId.fromJson(json["ApplierId"]),
    employerId: EmployerId.fromJson(json["EmployerId"]),
    postId: PostId.fromJson(json["PostId"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "ApplyId": applyId,
    "ApplierId": applierId.toJson(),
    "EmployerId": employerId.toJson(),
    "PostId": postId.toJson(),
    "created_at": createdAt.toIso8601String(),
  };
}

class ApplierId {
  ApplierId({
    required this.jobseekerId,
    required this.name,
    required this.adderss,
    required this.phone,
    required this.profilePhoto,
    required this.degree,
    required this.grade,
    required this.year,
    required this.tempo,
    required this.companyName,
    required this.jobTitle,
    required this.startAndEndDate,
    required this.detail,
    required this.skills,
    required this.objective,
    required this.projectTitle,
    required this.projectDescription,
    required this.achivementAndAward,
    required this.activities,
    required this.socialMedia,
    required this.user,
  });

  int jobseekerId;
  String name;
  String adderss;
  String phone;
  String profilePhoto;
  String degree;
  String grade;
  String year;
  String tempo;
  String companyName;
  String jobTitle;
  String startAndEndDate;
  String detail;
  String skills;
  String objective;
  String projectTitle;
  String projectDescription;
  String achivementAndAward;
  String activities;
  String socialMedia;
  int user;

  factory ApplierId.fromJson(Map<String, dynamic> json) => ApplierId(
    jobseekerId: json["JobseekerId"],
    name: json["name"],
    adderss: json["adderss"],
    phone: json["phone"],
    profilePhoto: json["profile_photo"],
    degree: json["degree"],
    grade: json["grade"],
    year: json["year"],
    tempo: json["tempo"],
    companyName: json["company_name"],
    jobTitle: json["job_title"],
    startAndEndDate: json["start_and_end_date"],
    detail: json["detail"],
    skills: json["skills"],
    objective: json["objective"],
    projectTitle: json["project_title"],
    projectDescription: json["project_description"],
    achivementAndAward: json["achivement_and_award"],
    activities: json["activities"],
    socialMedia: json["social_media"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "JobseekerId": jobseekerId,
    "name": name,
    "adderss": adderss,
    "phone": phone,
    "profile_photo": profilePhoto,
    "degree": degree,
    "grade": grade,
    "year": year,
    "tempo": tempo,
    "company_name": companyName,
    "job_title": jobTitle,
    "start_and_end_date": startAndEndDate,
    "detail": detail,
    "skills": skills,
    "objective": objective,
    "project_title": projectTitle,
    "project_description": projectDescription,
    "achivement_and_award": achivementAndAward,
    "activities": activities,
    "social_media": socialMedia,
    "user": user,
  };
}

class EmployerId {
  EmployerId({
    required this.employerId,
    required this.companyName,
    required this.adderss,
    required this.phone,
    required this.profilePhoto,
    required this.description,
    required this.website,
    required this.objective,
    required this.achivementAndAward,
    required this.activities,
    required this.socialMedia,
    required this.user,
  });

  int employerId;
  String companyName;
  String adderss;
  String phone;
  String profilePhoto;
  String description;
  String website;
  String objective;
  String achivementAndAward;
  String activities;
  String socialMedia;
  int user;

  factory EmployerId.fromJson(Map<String, dynamic> json) => EmployerId(
    employerId: json["EmployerId"],
    companyName: json["company_name"],
    adderss: json["adderss"],
    phone: json["phone"],
    profilePhoto: json["profile_photo"],
    description: json["description"],
    website: json["website"],
    objective: json["objective"],
    achivementAndAward: json["achivement_and_award"],
    activities: json["activities"],
    socialMedia: json["social_media"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "EmployerId": employerId,
    "company_name": companyName,
    "adderss": adderss,
    "phone": phone,
    "profile_photo": profilePhoto,
    "description": description,
    "website": website,
    "objective": objective,
    "achivement_and_award": achivementAndAward,
    "activities": activities,
    "social_media": socialMedia,
    "user": user,
  };
}

class PostId {
  PostId({
    required this.jobId,
    required this.title,
    required this.deadline,
    required this.jobtime,
    required this.jobtype,
    required this.salary,
    required this.city,
    required this.description,
    required this.user,
  });

  int jobId;
  String title;
  String deadline;
  String jobtime;
  String jobtype;
  String salary;
  String city;
  String description;
  int user;

  factory PostId.fromJson(Map<String, dynamic> json) => PostId(
    jobId: json["JobId"],
    title: json["Title"],
    deadline: json["Deadline"],
    jobtime: json["Jobtime"],
    jobtype: json["Jobtype"],
    salary: json["Salary"],
    city: json["City"],
    description: json["Description"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "JobId": jobId,
    "Title": title,
    "Deadline": deadline,
    "Jobtime": jobtime,
    "Jobtype": jobtype,
    "Salary": salary,
    "City": city,
    "Description": description,
    "user": user,
  };
}
