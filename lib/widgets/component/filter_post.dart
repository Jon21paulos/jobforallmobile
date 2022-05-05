import 'package:flutter/material.dart';
import 'package:jobforallmobile/widgets/component/home_page.dart';
import 'package:provider/provider.dart';

import '../../store/fetch_post.dart';

class FilterPost extends StatefulWidget {
  const FilterPost({Key? key}) : super(key: key);

  @override
  State<FilterPost> createState() => _FilterPostState();
}

class _FilterPostState extends State<FilterPost> {
  final  companynameController = TextEditingController();
  final  titleController = TextEditingController();
  final  deadlineController = TextEditingController();
  final  jobtimeController = TextEditingController();
  final  jobtypeController = TextEditingController();
  final  salaryController = TextEditingController();
  final  cityController = TextEditingController();

  void filterPost(){
    context.read<FetchPost>().filterFromPosts(
        cityController.text,
        deadlineController.text,
        jobtimeController.text,
        jobtypeController.text,
        salaryController.text,
        titleController.text,
        companynameController.text,
    );

    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filter'),
      ),
      body: SingleChildScrollView(
        child: Column(
           children: [
             Row(
                children: [
                  Text('Company Name'),

                  Expanded(
                      child: TextField(
                        controller: companynameController,
                      )
                  ),
                ],
             ),
             Row(
               children: [
                 Text('Title'),
                 Expanded(
                     child: TextField(
                       controller: titleController,
                     )
                 ),
               ],
             ),
             Row(
               children: [
                 Text('Deadline'),
                 Expanded(
                     child: TextField(
                       controller: deadlineController,
                     )
                 ),
               ],
             ),
             Row(
               children: [
                 Text('JobTime'),
                 Expanded(
                     child: TextField(
                       controller: jobtimeController,
                     )
                 ),
               ],
             ),

             Row(
               children: [
                 Text('Job type'),
                 Expanded(
                     child: TextField(
                       controller: jobtypeController,
                     )
                 ),
               ],
             ),
             Row(
               children: [
                 Text('Salary'),
                 Expanded(
                     child: TextField(
                       controller: salaryController,
                     )
                 ),
               ],
             ),
             Row(
               children: [
                 Text('City'),
                 Expanded(
                     child: TextField(
                       controller: cityController,
                     )
                 ),
               ],
             ),
             ElevatedButton(
                 onPressed: (){
                    filterPost();
                 },
                 child: Text('submit')
             )
           ],

        ),
      )

    );
  }
}
