class ProfileBody{
  int user;
  String name;
  String adderss;
  String phone;
  String profile_photo;
  String degree;
  String grade;
  String year;
  String tempo;
  String company_name;
  String job_title;
  String start_and_end_date;
  String detail;
  String skills;
  String objective;
  String project_title;
  String project_description;
  String achivement_and_award;
  String activities;
  String social_media;

  ProfileBody({
    required this.user,
    required this.name,
    required this.adderss,
    required this.phone,
    required this.profile_photo,
    required this.degree,
    required this.grade,
    required this.year,
    required this.tempo,
    required this.company_name,
    required this.job_title,
    required this.start_and_end_date,
    required this.detail,
    required this.skills,
    required this.objective,
    required this.project_title,
    required this.project_description,
    required this.achivement_and_award,
    required this.activities,
    required this.social_media,

  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user"] = user;
    data["name"] = name;
    data["adderss"] = adderss;
    data["phone"] = phone;
    data["profile_photo"] = profile_photo;
    data["degree"] = degree;
    data["grade"] = grade;
    data["year"] = year;
    data["tempo"] = tempo;
    data["company_name"] = company_name;
    data["job_title"] = job_title;
    data["start_and_end_date"] = start_and_end_date;
    data["detail"] = detail;
    data["skills"] = skills;
    data["objective"] = objective;
    data["project_title"] = project_title;
    data["project_description"] = project_description;
    data["achivement_and_award"] = achivement_and_award;
    data["activities"] = activities;
    data["social_media"] = social_media;

    return data;
  }
}