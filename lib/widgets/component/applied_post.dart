import 'package:flutter/material.dart';
import 'package:jobforallmobile/model/applied_model.dart';
import 'package:provider/provider.dart';

import '../../store/apply/delete_applier.dart';
import '../../store/auth_provider.dart';
import '../../store/apply/fetch_applier.dart';

class AppliedPost extends StatefulWidget {
  const AppliedPost({Key? key}) : super(key: key);

  @override
  State<AppliedPost> createState() => _AppliedPostState();
}

class _AppliedPostState extends State<AppliedPost> {
  @override
  void initState() {
    final user = context.read<AuthProvider>().profile?.user.JobseekerId;
    context.read<FetchApplier>().loadFromPrefs(user);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Provider.of<FetchApplier>(context,listen: true).loading? CircularProgressIndicator():
    ListView.builder(
            itemCount: context.read<FetchApplier>().applier.length,
            itemBuilder: (context,index){
              ApplierData apply = context.read<FetchApplier>().applier[index];
              return  Dismissible(
                key: UniqueKey(),
                onDismissed: (direction){
                  context.read<DeleteApplier>().deleteApplier(apply.applyId);
                },
                child: ListTile(
                  leading: Text(apply.employerId.companyName),
                  title: Text(apply.applierId.name),
                  subtitle: Text(apply.postId.title),
                ),
              );
            }
            );
  }
}
