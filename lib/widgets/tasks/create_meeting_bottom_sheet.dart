import 'package:chatterbox/provider/task_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMeetingBottomSheet extends StatefulWidget {
  @override
  _CreateMeetingBottomSheetState createState() =>
      _CreateMeetingBottomSheetState();
}

class _CreateMeetingBottomSheetState extends State<CreateMeetingBottomSheet> {
  String? _assignedTo;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskListProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create new meeting',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),

            SizedBox(height: 20.0),

            // Row(
            //   children: [
            //     Expanded(
            //       child: OutlinedButton.icon(
            //         onPressed: () async {
            //           final TimeOfDay? picked = await showTimePicker(
            //             context: context,
            //             initialTime: TimeOfDay.now(),
            //           );
            //           if (picked != null && picked != _startTime) {
            //             setState(() {
            //               _startTime = picked;
            //             });
            //           }
            //         },
            //         icon: Icon(Icons.access_time_filled_rounded),
            //         label: Text('Start Time'),
            //       ),
            //     ),
            //
            //     const SizedBox(width: 15),
            //
            //     Expanded(
            //       child: OutlinedButton.icon(
            //         onPressed: () async {
            //           final TimeOfDay? picked = await showTimePicker(
            //             context: context,
            //             initialTime: TimeOfDay.now(),
            //           );
            //           if (picked != null && picked != _endTime) {
            //             setState(() {
            //               _endTime = picked;
            //             });
            //           }
            //         },
            //         icon: Icon(Icons.access_time_filled_rounded),
            //         label: Text('End Time'),
            //       ),
            //     ),
            //
            //   ],
            // ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _startTime ?? TimeOfDay.now(),
                      );
                      if (picked != null && picked != _startTime) {
                        setState(() {
                          _startTime = picked;
                        });
                      }
                    },
                    icon: Icon(Icons.access_time_filled_rounded),
                    label: Text(_startTime != null
                        ? 'Start: ${_startTime!.format(context)}'
                        : 'Start Time'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _endTime ?? TimeOfDay.now(),
                      );
                      if (picked != null && picked != _endTime) {
                        setState(() {
                          _endTime = picked;
                        });
                      }
                    },
                    icon: Icon(Icons.access_time_filled_rounded),
                    label: Text(_endTime != null
                        ? 'End: ${_endTime!.format(context)}'
                        : 'End Time'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                taskProvider.saveMeeting(context, _titleController.text, _startTime!.format(context),  _endTime!.format(context));
              },
              child: Text('CREATE'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
