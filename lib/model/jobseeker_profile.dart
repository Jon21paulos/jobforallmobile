// To parse this JSON data, do
//
//     final jobseekerProfile = jobseekerProfileFromJson(jsonString);

import 'dart:convert';

JobseekerProfile jobseekerProfileFromJson(String str) => JobseekerProfile.fromJson(json.decode(str));

String jobseekerProfileToJson(JobseekerProfile data) => json.encode(data.toJson());

class JobseekerProfile {
  JobseekerProfile({
    required this.user,
  });

  UserJ user;

  factory JobseekerProfile.fromJson(Map<String, dynamic> json) => JobseekerProfile(
    user: UserJ.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class UserJ {
  UserJ({
    required this.user,
    required this.JobseekerId,
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
  });

  int user;
  int JobseekerId;
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

  factory UserJ.fromJson(Map<String, dynamic> json) => UserJ(
    user: json["user"],
    JobseekerId: json["JobseekerId"],
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
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "JobseekerId":JobseekerId,
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
  };
}
