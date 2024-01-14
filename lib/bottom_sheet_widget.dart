import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class User {
  final String userId;
  final String email;
  final String name;

  User({
    required this.userId,
    required this.email,
    required this.name,
  });
}

class MyBottomSheet extends StatefulWidget {
  final bool isSingleDaySelected;
  final DateTime? startDate;
  final DateTime? endDate;
  MyBottomSheet(this.isSingleDaySelected, this.startDate, this.endDate);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<User> allUsers = [
    User(userId: "1", email: "user1@example.com", name: "User 1"),
    User(userId: "2", email: "user2@example.com", name: "User 2"),
    // Add more users as needed
  ];

  List<User> hdrUsers = [
    User(userId: "3", email: "hdr1@example.com", name: "HDR User 1"),
    User(userId: "4", email: "hdr2@example.com", name: "HDR User 2"),
    // Add more users as needed
  ];

  List<User> techUsers = [
    User(userId: "5", email: "tech1@example.com", name: "Tech User 1"),
    User(userId: "6", email: "tech2@example.com", name: "Tech User 2"),
    // Add more users as needed
  ];

  List<User> followUpUsers = [
    User(userId: "7", email: "followup1@example.com", name: "Follow Up User 1"),
    User(userId: "8", email: "followup2@example.com", name: "Follow Up User 2"),
    // Add more users as needed
  ];

  @override
  void dispose() {
    _tabController
        ?.dispose(); // Dispose the TabController to avoid memory leaks
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'HDR'),
              Tab(text: 'Tech'),
              Tab(text: 'Follow up'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(allUsers),
                _buildTabContent(hdrUsers),
                _buildTabContent(techUsers),
                _buildTabContent(followUpUsers),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(List<User> users) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: users.length,
      itemBuilder: (context, index) {
        User user = users[index];
        return widget.isSingleDaySelected
            ? UserContainer(user: user)
            : WeekRangeSummaryContainer(
                startDate: widget.startDate,
                endDate: widget.endDate,
                allUsersCount: allUsers.length,
                hdrUsersCount: hdrUsers.length,
                techUsersCount: techUsers.length,
                followUpUsersCount: followUpUsers.length,
              );
      },
    );
  }
}

class UserContainer extends StatelessWidget {
  final User user;

  UserContainer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User ID: ${user.userId}'),
          Text('Name: ${user.name}'),
          Text('Email: ${user.email}'),
          // Add more user details as needed

          // Example: Call icon for making a call
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Handle the call action here
              print('Calling ${user.name}');
            },
          ),
        ],
      ),
    );
  }
}

class WeekRangeSummaryContainer extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final int allUsersCount;
  final int hdrUsersCount;
  final int techUsersCount;
  final int followUpUsersCount;

  WeekRangeSummaryContainer({
    this.startDate,
    this.endDate,
    required this.allUsersCount,
    required this.hdrUsersCount,
    required this.techUsersCount,
    required this.followUpUsersCount,
  });
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateTime.parse(startDate.toString());

    String formattedDate =
        DateFormat("d'${_getDaySuffix(inputDate.day)}' MMMM").format(inputDate);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              formattedDate,
              maxLines: 2,
            ),
          ),
          _buildCircularCount(allUsersCount.toString(), "All"),
          _buildCircularCount(hdrUsersCount.toString(), "HDR"),
          _buildCircularCount(techUsersCount.toString(), "Tech"),
          _buildCircularCount(followUpUsersCount.toString(), "Follow-up"),
          _buildCircularCount(totalUsersCount().toString(), "Total"),
        ],
      ),
    );
  }

  Widget _buildCircularCount(String count, String tabName) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Container(
            // width: 50.0,
            // height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                count,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(tabName),
        ],
      ),
    );
  }

  int totalUsersCount() {
    return allUsersCount + hdrUsersCount + techUsersCount + followUpUsersCount;
  }
}
