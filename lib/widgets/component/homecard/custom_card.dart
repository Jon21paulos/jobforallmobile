import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jobforallmobile/store/apply/apply_provider.dart';
import 'package:jobforallmobile/store/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../../model/apply_post_model.dart';
import '../../../model/post_model.dart';

class CustomCard extends StatelessWidget {

  const CustomCard({Key? key, required this.post}) : super(key: key);
  final Result post;

  Future<void> apply(context,employerId,applierId, int postId) async {
    ApplyPost applyPost = ApplyPost(
        EmployerId: employerId, ApplierId: applierId, PostId:postId
    );
    var provider = Provider.of<ApplyProvider>(context, listen: false);
    await provider.apply(applyPost,context);

  }

  @override
  Widget build(BuildContext context) {
    final profile = context.read<AuthProvider>().profile;
    return Card(
      color: Colors.white54,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Image.network(post),
                const SizedBox(width: 20),

                Column(
                  children: [
                    buildImage(post.user.profilePhoto),
                    Text(post.user.user.toString(),style: Theme.of(context).textTheme.headline5,),
                    Text(post.title,style: Theme.of(context).textTheme.headline5,),
                    Text(post.description ,style: Theme.of(context).textTheme.headline6,),
                    Text(post.deadline,style: Theme.of(context).textTheme.subtitle1,),
                    Text(post.jobtime,style: Theme.of(context).textTheme.subtitle1,),
                    Text(post.jobtype,style: Theme.of(context).textTheme.subtitle1,),
                    Text(post.salary,style: Theme.of(context).textTheme.subtitle1,),
                    ElevatedButton(
                        onPressed: (){
                          apply(
                              context,
                              post.user.employerId,
                              profile!.user.JobseekerId,
                              post.jobId
                          );
                        },
                        child: Text('Apply post')
                    )
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildImage(imagePath) {
    final UriData? data = Uri.parse(imagePath).data;
    Uint8List myImage = data!.contentAsBytes();
    final image = MemoryImage(myImage);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          // child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }
}
