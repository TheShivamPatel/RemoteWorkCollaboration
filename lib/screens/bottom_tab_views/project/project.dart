import 'package:chatterbox/screens/bottom_tab_views/project/create_new_project.dart';
import 'package:chatterbox/screens/bottom_tab_views/project/project_detail_screen.dart';
import 'package:chatterbox/screens/chat_screen.dart';
import 'package:chatterbox/screens/confrense_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../provider/task_list_provider.dart';

class ProjectManagerView extends StatefulWidget {
  const ProjectManagerView({super.key});

  @override
  State<ProjectManagerView> createState() => _ProjectManagerViewState();
}

class _ProjectManagerViewState extends State<ProjectManagerView> {
  TaskListProvider listProvider = TaskListProvider();

  @override
  void initState() {
    super.initState();
    listProvider.fetchProject();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: listProvider.isLoadingStream,
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return CircularProgressIndicator();
        } else {
          return buildMeetingList();
        }
      },
    );
  }

  Widget buildMeetingList() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateNewProject(),
                  ));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
              size: 20,
            ),
            label: Text('New Project',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: listProvider.project.length,
              itemBuilder: (context, index) {
                DocumentSnapshot meeting = listProvider.project[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailScreen(
                              project: meeting,
                            ),
                          ));
                    },
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(meeting['title'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${meeting['start date']}   -----   ${meeting['end_date']}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87)),
                            const SizedBox(height: 15),
                            Divider(),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset('assets/images/people.png',
                                    width: 60),
                                const SizedBox(width: 5),
                                Text('+${meeting['team_member']}'),
                                Spacer(),
                                Text(
                                  meeting['status'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: meeting['status'] == 'completed'
                                        ? Colors.green
                                        : Colors.red.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
