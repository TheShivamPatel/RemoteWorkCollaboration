import 'package:flutter/material.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({super.key, this.task});

  final dynamic task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task['title']),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(task['description'], style: TextStyle(fontSize: 18),),

            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wb_twighlight, size: 25, color: Colors.red,),
                SizedBox(width: 15),
                Text(task['deadlineTime'], style: TextStyle(fontSize: 18),),
              ],
            )

          ],
        ),
      ),
    );
  }
}
