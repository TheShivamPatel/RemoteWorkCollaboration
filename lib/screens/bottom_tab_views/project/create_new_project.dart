import 'package:calendar_view/calendar_view.dart';
import 'package:chatterbox/provider/task_list_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CreateNewProject extends StatefulWidget {
  CreateNewProject({super.key});

  @override
  State<CreateNewProject> createState() => _CreateNewProjectState();
}

class _CreateNewProjectState extends State<CreateNewProject> {

  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  final MultiSelectController<dynamic> _controller = MultiSelectController();

  final List<ValueItem> _selectedOptions = [
    ValueItem(label: 'shivam', value: 'Ht4X0P72JZR8WvHFcQ3UNcC6OCf2'),
    ValueItem(label: 'Anshu', value: '0dszumw9cUQAMQTrFK3uwcT8yB32'),
    ValueItem(label: 'Saransh singhal', value: '0zxQc121DWeZP2pZf8R1uHPk1YD3'),
    ValueItem(label: 'pratyush Tirole', value: 'STarhcWjK8hO3n9BwUiUeeQ8NAj1'),
    ValueItem(label: 'Kamlesh Kapse', value: 'dSjqd94dxlMaBpVfovzHmBe5Z1v2'),
  ];

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  DateTime selectedDate2 = DateTime.now();

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TaskListProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text('New Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Project Details'),
              SizedBox(height: 10),
              card(
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter the Project Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              card(
                SizedBox(
                  height: 120,
                  child: TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      hintText: 'Enter the Project Description',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              card(
                InkWell(
                  onTap: () =>  _selectDate(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 10),
                        Text('Start date :    ${DateFormat.yMMMEd().format(selectedDate)}'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              card(
                InkWell(
                  onTap: () =>  _selectDate2(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 10),
                        Text('Deadline :    ${DateFormat.yMMMEd().format(selectedDate2)}'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              MultiSelectDropDown(
                // clearIcon: Icon(Icons.remove_circle_outline),
                controller: _controller,
                onOptionSelected: (options) {
                  debugPrint(options.toString());
                },
                // options: const <ValueItem>[
                //   // ValueItem(label: 'Option 1', value: '1'),
                //   // ValueItem(label: 'Option 2', value: '2'),
                //   // ValueItem(label: 'Option 3', value: '3'),
                //   // ValueItem(label: 'Option 4', value: '4'),
                //   // ValueItem(label: 'Option 5', value: '5'),
                //   // ValueItem(label: 'Option 6', value: '6'),
                // ],
                // maxItems: 2,
                options: _selectedOptions,
                disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                dropdownHeight: 300,
                optionTextStyle: const TextStyle(fontSize: 16),
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),


              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    provider.saveProject(context, _nameController.text, _descController.text, DateFormat.yMMMEd().format(selectedDate), DateFormat.yMMMEd().format(selectedDate2), _controller.selectedOptions.length);
                  },
                  child: const Text('Create Project'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget card(Widget child) {
    return Material(
      color: Colors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: child,
      ),
    );
  }
}
