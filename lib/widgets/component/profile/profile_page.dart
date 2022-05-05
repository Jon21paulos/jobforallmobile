import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:jobforallmobile/widgets/component/profile/profile_widget.dart';
import 'package:provider/provider.dart';
import '../../../store/auth_provider.dart';
import 'button_widget.dart';
import 'edit_profile.dart';
import 'number_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.read<AuthProvider>().profile;
    final imagenJson = profile!.user.profilePhoto;
    print(profile);

    return Scaffold(
      appBar: AppBar(
        title:Text("your profile"),
      ),
      body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: imagenJson,
              onClicked: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(profile.user.name),
            const SizedBox(height: 24),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(profile.user.detail),
          ],
      ),
    );
  }
  Widget buildName(name) => Column(
    children: [
      Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        name,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );

  Widget buildAbout(detail) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          detail,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}
