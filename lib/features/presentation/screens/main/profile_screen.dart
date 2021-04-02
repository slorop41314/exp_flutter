import 'package:flutter/material.dart';
import 'package:new_flutter_bloc/features/presentation/widgets/profile_header_content.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.grid_on,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                leading: SizedBox(),
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: const ProfileHeaderContent(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 40,
                      child: Text('Item abc $index'),
                    );
                  },
                ),
              ),
              Container(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Item $index"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
