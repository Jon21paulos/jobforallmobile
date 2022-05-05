import 'package:flutter/material.dart';
import 'package:jobforallmobile/widgets/component/profile/profile_widget.dart';
import 'package:jobforallmobile/widgets/component/profile/textfield_widget.dart';
import 'package:provider/provider.dart';

import '../../../store/auth_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final profile = context.read<AuthProvider>().profile;
    final imagenJson = profile!.user.profilePhoto;

    return Scaffold(
      appBar: AppBar(
        title: Text('edit your profile'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagenJson,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: profile.user.name,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: profile.user.name,
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: profile.user.detail,
            maxLines: 5,
            onChanged: (about) {},
          ),
        ],
      ),
    );
  }
}
