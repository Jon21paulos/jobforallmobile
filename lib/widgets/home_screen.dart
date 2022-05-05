import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobforallmobile/widgets/component/applied_post.dart';
import 'package:jobforallmobile/widgets/component/filter_post.dart';
import 'package:jobforallmobile/widgets/component/profile/profile_page.dart';
import 'component/about_page.dart';
import 'component/drawer/navigation_drawer.dart';
import 'component/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  int index = 1;
  final screens = [
    HomePage(),
    AboutPage(),
    AppliedPost(),
    ProfilePage()
  ];

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar:  AppBar(
            title: _page==0?Text("Wellcome", style: Theme.of(context).textTheme.subtitle1):Text("selam", style: Theme.of(context).textTheme.subtitle1),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate()
                    );
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FilterPost())
                    );
                  },
                  icon: const Icon(Icons.list)
              ),
            ],
        ),
        body: screens[_page],
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.person, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            // Icon(Icons.call_split, size: 30),
            // Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.indigo,
          backgroundColor: Colors.blue,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        drawer:  NavigationDrawerWidget()
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: (){
        if(query.isEmpty){
          close(context, null);
        }
        query = '';
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Center(
      child: Text(query),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'React', 'Vue'
    ];
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
            },
          );
        }
    );
  }
  
}
