import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobforallmobile/model/profile_model.dart';
import 'package:jobforallmobile/store/auth_provider.dart';
import 'package:jobforallmobile/widgets/signin_screen.dart';
import 'package:jobforallmobile/widgets/wellcome_screen.dart';
import 'package:provider/provider.dart';
import '../model/signup_model.dart';
import 'component/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  int currentStep = 0;
  bool isPasswordNotVisible = true;

  final userName = TextEditingController();
  final Email = TextEditingController();
  final Password = TextEditingController();
  final Password2 = TextEditingController();

  final Name = TextEditingController();
  final Adderss = TextEditingController();
  final Phone = TextEditingController();
  final Profile_photo = TextEditingController();
  final Degree = TextEditingController();
  final Grade = TextEditingController();
  final Year = TextEditingController();
  final Tempo = TextEditingController();
  final Company_name = TextEditingController();
  final Job_title = TextEditingController();
  final Start_and_end_date = TextEditingController();
  final Detail = TextEditingController();
  final Skills = TextEditingController();
  final Objective = TextEditingController();
  final Project_title = TextEditingController();
  final Project_description = TextEditingController();
  final Achivement_and_award = TextEditingController();
  final Activities = TextEditingController();
  final Social_media = TextEditingController();
  
  void changeVisibility(){
    setState(() {
      isPasswordNotVisible = !isPasswordNotVisible;
    });
  }

  File? _image;
  String? base64Image;
  Future choiceImage() async{
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
    print("hello jon$_image");
    final byte = _image?.readAsBytesSync();
    setState(() {
      base64Image =  "http://data:image/jpg;base64,"+base64Encode(byte!);
    });
  }


  Future<void> _registration() async {
    String username = userName.text.trim();
    String email = Email.text.trim();
    String password = Password.text.trim();
    String password2 = Password2.text.trim();

    SignUpBody signUpBody = SignUpBody(
        username: username, email: email, password: password, password2: password2);

    var provider = Provider.of<AuthProvider>(context, listen: false);
    await provider.signup(signUpBody,context);
  }

  Future<void> _profile() async {
    String name = Name.text.trim();
    String adderss = Adderss.text.trim();
    String phone = Phone.text.trim();
    String profile_photo = Profile_photo.text.trim();
    String degree = Degree.text.trim();
    String grade = Grade.text.trim();
    String year = Year.text.trim();
    String tempo = Tempo.text.trim();
    String company_name = Company_name.text.trim();
    String job_title = Job_title.text.trim();
    String start_and_end_date = Start_and_end_date.text.trim();
    String detail = Detail.text.trim();
    String skills = Skills.text.trim();
    String objective = Objective.text.trim();
    String project_title = Project_title.text.trim();
    String project_description = Project_description.text.trim();
    String achivement_and_award = Achivement_and_award.text.trim();
    String activities = Activities.text.trim();
    String social_media = Social_media.text.trim();


    var provider = Provider.of<AuthProvider>(context, listen: false);

    ProfileBody profileBody = ProfileBody(
        user: provider.id,name: name,adderss: adderss,
        phone: phone, profile_photo: profile_photo,degree: degree,
        grade: grade,year: year,tempo: tempo,company_name: company_name,
        job_title:job_title,start_and_end_date: start_and_end_date,detail: detail,
        skills: skills,objective: objective,project_title: project_title,project_description: project_description,
        achivement_and_award: achivement_and_award,activities: activities,social_media: social_media
    );

    await provider.EditProfileData(profileBody,context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text("sign in"),
        ),
        body: Form(
          key: _formKey,
          child: Stepper(
              type: StepperType.vertical,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: (){
                final isLastStep = currentStep == getSteps().length - 1;

                if(isLastStep ){
                  // _profile();
                  print("your profile filled successfuly");
                }else{
                    setState(() {
                      currentStep += 1;
                    });
                  }
                  if(currentStep == 1){
                    if(_formKey.currentState!.validate()){
                      print("success");
                      // _registration();
                    }else{
                      setState(() {
                        currentStep -= 1;
                      });
                    }
                  }
              },
              // onStepTapped: (step)=>setState(() {
              //   currentStep = step;
              // }),
              onStepCancel: (){
                currentStep == 0?null:()=>
                    setState(() =>currentStep -= 1);
              },
              controlsBuilder: ( BuildContext context, ControlsDetails controls){
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      provider.loading?
                      CircularProgressIndicator():
                      Expanded(
                          child: ElevatedButton(
                            onPressed:  controls.onStepContinue,
                            child: Text( isLastStep ? 'Confirm': 'Next'),
                          )
                      ),
                      const SizedBox(width: 12,),
                      // if(currentStep != 0)
                      //   Expanded(
                      //       child: ElevatedButton(
                      //         onPressed: controls.onStepCancel,
                      //         child: Text('Back'),
                      //       )
                      //   )
                    ],
                  ),
                );
              },

            ),
        )
    );
  }
  List<Step> getSteps()=>[
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep>=0,
      title: Text('Account'),
      content: Column(
        children: [
          customNameTextField(userName,context),
          SizedBox(height: 10,),
          customEmailTextField(Email, context),
          SizedBox(height: 10,),
          customPasswordTextField(Password, context, isPasswordNotVisible, changeVisibility),
          SizedBox(height: 10,),
          customConfirmPasswordTextField(Password, Password2, context, isPasswordNotVisible, changeVisibility)
        ],
      ),
    ),
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep>=1,
      title: Text('Personal Information'),
      content: Column(
        children: [
          TextFormField(
            controller: Name,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: Adderss,
            decoration: InputDecoration(labelText: 'Adderss'),
          ),
          TextFormField(
            controller: Phone,
            decoration: InputDecoration(labelText: 'Phone'),
          ),
          // TextFormField(
          //   controller: Profile_photo,
          //   decoration: InputDecoration(labelText: 'Profile_photo'),
          // ),
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              choiceImage();
            },
          ),
          Container(
            child: base64Image==null?CircularProgressIndicator(): Image.network(base64Image!),
          )
        ],
      ),
    ),
    Step(
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep>=2,
      title: Text('Expriance'),
      content: Column(
        children: [
          TextFormField(
            controller: Company_name,
            decoration: InputDecoration(labelText: 'Company_name'),
          ),
          TextFormField(
            controller: Job_title,
            decoration: InputDecoration(labelText: 'Job_title'),
          ),
          TextFormField(
            controller: Start_and_end_date,
            decoration: InputDecoration(labelText: 'Start_and_end_date'),
          ),
          TextFormField(
            controller: Detail,
            decoration: InputDecoration(labelText: 'Detail'),
          ),
          TextFormField(
            controller: Skills,
            decoration: InputDecoration(labelText: 'Skills'),
          ),
        ],
      ),
    ),
    Step(
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep>=3,
      title: Text('About'),
      content: Column(
        children: [

          TextFormField(
            controller: Objective,
            decoration: InputDecoration(labelText: 'Objective'),
          ),
          TextFormField(
            controller: Project_title,
            decoration: InputDecoration(labelText: 'Project_title'),
          ),
          TextFormField(
            controller: Project_description,
            decoration: InputDecoration(labelText: 'Project_description'),
          ),
          TextFormField(
            controller: Achivement_and_award,
            decoration: InputDecoration(labelText: 'Achivement_and_award'),
          ),
          TextFormField(
            controller: Activities,
            decoration: InputDecoration(labelText: 'Activities'),
          ),
          TextFormField(
            controller: Social_media,
            decoration: InputDecoration(labelText: 'Social Media'),
          ),
        ],
      ),
    ),
    Step(
      isActive: currentStep>=4,
      title: Text('Complete'),
      content: Container(
        child: Text("you set all things"),
      ),
    ),
  ];
}
