import 'package:chatterbox/provider/task_list_provider.dart';
import 'package:chatterbox/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final dynamic project;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {

  TaskListProvider taskListProvider = TaskListProvider();

  @override
  void initState() {
    super.initState();
    taskListProvider.fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskListProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
      appBar: AppBar(
        title: Text(
          widget.project['project_id'],
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    card(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.project['title'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(widget.project['desc'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        chatCard('Frontend Team'),
                        SizedBox(width: 15),
                        chatCard('Backend Team'),
                      ],
                    ),
                    SizedBox(height: 15),

                  ],
                ),
              ),
            ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('END PROJECT'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget card(child) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black54,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }

  Widget chatCard(title) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  chatId: '${widget.project['project_id']}$title',
                ),
              ));
        },
        child: SizedBox(
          height: 100,
          child: card(Column(
            children: [
              Icon(
                CupertinoIcons.chat_bubble_2,
                size: 45,
              ),
              SizedBox(height: 10),
              Text(title),
            ],
          )),
        ),
      ),
    );
  }
}
