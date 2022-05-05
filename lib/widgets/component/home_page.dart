import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobforallmobile/store/fetch_post.dart';
import 'package:provider/provider.dart';
import '../../store/auth_provider.dart';
import '../../store/apply/fetch_applier.dart';
import 'homecard/custom_card.dart';
import 'homecard/custom_card_skeletal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<FetchPost>().loadFromPrefs();
    context.read<AuthProvider>().ReadProfileData(context);
    _scrollController.addListener(() {
      if(_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent){
        context.read<FetchPost>().loadFromPrefs();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        context.read<FetchPost>().initialValues();
        context.read<FetchPost>().loadFromPrefs();
      },
      child: Center(
        child: Consumer<FetchPost>(
          builder: (context,value,child){
            return value.posts.isEmpty && !value.error
                ? ListView.builder(
                itemCount: 7,

                itemBuilder: (context,index){
                  return const CustomCardSkeletal();
                })

                : value.error ?

            Text(
                'oops something went wrong. ${value.errorMessage}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1
            )
                : ListView.builder(
              controller: _scrollController,
              itemCount: value.posts.length + 1,
              itemBuilder: (context,index){
                if(index == value.posts.length ){
                  return context.read<FetchPost>().message?
                  const CupertinoActivityIndicator():
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Center(child: Text('no more data')),
                  );
                }

                final post = value.posts[index];

                return CustomCard(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}
