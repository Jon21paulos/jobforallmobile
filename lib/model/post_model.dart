// To parse this JSON data, do
//
//     final postData = postDataFromJson(jsonString);

import 'dart:convert';

PostData postDataFromJson(String str) => PostData.fromJson(json.decode(str));

String postDataToJson(PostData data) => json.encode(data.toJson());

class PostData {
  PostData({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic previous;
  List<Result> results;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.jobId,
    required this.user,
    required this.title,
    required this.deadline,
    required this.jobtime,
    required this.jobtype,
    required this.salary,
    required this.city,
    required this.description,
  });

  int jobId;
  User user;
  String title;
  String deadline;
  String jobtime;
  String jobtype;
  String salary;
  String city;
  String description;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    jobId: json["JobId"],
    user: User.fromJson(json["user"]),
    title: json["Title"],
    deadline: json["Deadline"],
    jobtime: json["Jobtime"],
    jobtype: json["Jobtype"],
    salary: json["Salary"],
    city: json["City"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "JobId": jobId,
    "user": user.toJson(),
    "Title": title,
    "Deadline": deadline,
    "Jobtime": jobtime,
    "Jobtype": jobtype,
    "Salary": salary,
    "City": city,
    "Description": description,
  };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
