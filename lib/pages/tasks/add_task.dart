import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/tasks/bloc/add_task_bloc.dart';
import 'package:flutter_app/etc/colors.dart';
import 'package:flutter_app/etc/dates.dart';

class AddTaskScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Tambah Tugas"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                validator: (value) {
                  var msg = value.isEmpty ? "Harap Diisi!" : null;
                  return msg;
                },
                onSaved: (value) {
                  createTaskBloc.updateTitle = value;
                },
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Tugas",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan[600])),
                  contentPadding: EdgeInsets.fromLTRB(15.0, 3.0, 3.0, 15.0),
                ),
              ),
            ),
            key: _formState,
          ),
          ListTile(
            leading: Icon(Icons.check_circle),
            title: Text("Kegiatan"),
            subtitle: StreamBuilder<Project>(
              stream: createTaskBloc.selectedProject,
              initialData: Project.getInbox(),
              builder: (context, snapshot) => Text(snapshot.data.name),
            ),
            onTap: () {
              _showProjectsDialog(createTaskBloc, context);
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Tanggal"),
            subtitle: StreamBuilder(
              stream: createTaskBloc.dueDateSelected,
              initialData: DateTime.now().millisecondsSinceEpoch,
              builder: (context, snapshot) =>
                  Text(getFormattedDate(snapshot.data)),
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text("Prioritas"),
            subtitle: StreamBuilder(
              stream: createTaskBloc.prioritySelected,
              initialData: Status.PRIORITY_4,
              builder: (context, snapshot) =>
                  Text(priorityText[snapshot.data.index]),
            ),
            onTap: () {
              _showPriorityDialog(createTaskBloc, context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send, color: Colors.white),
          backgroundColor: Colors.teal,
          onPressed: () {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              createTaskBloc.createTask().listen((value) {
                Navigator.pop(context, true);
              });
            }
          }),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      createTaskBloc.updateDueDate(picked.millisecondsSinceEpoch);
    }
  }

  Future<Status> _showPriorityDialog(
      AddTaskBloc createTaskBloc, BuildContext context) async {
    return await showDialog<Status>(
        context: context,
        builder: (BuildContext dialogContext) {
          return SimpleDialog(
            title: const Text('Prioritas'),
            children: <Widget>[
              buildContainer(context, Status.PRIORITY_1),
              buildContainer(context, Status.PRIORITY_2),
              buildContainer(context, Status.PRIORITY_3),
              buildContainer(context, Status.PRIORITY_4),
            ],
          );
        });
  }

  Future<Status> _showProjectsDialog(
      AddTaskBloc createTaskBloc, BuildContext context) async {
    return showDialog<Status>(
        context: context,
        builder: (BuildContext dialogContext) {
          return StreamBuilder(
              stream: createTaskBloc.projects,
              initialData: List<Project>(),
              builder: (context, snapshot) {
                return SimpleDialog(
                  title: const Text('Tentukan Kegiatan'),
                  children:
                      buildProjects(createTaskBloc, context, snapshot.data),
                );
              });
        });
  }

  List<Widget> buildProjects(
    AddTaskBloc createTaskBloc,
    BuildContext context,
    List<Project> projectList,
  ) {
    List<Widget> projects = List();
    projectList.forEach((project) {
      projects.add(ListTile(
        leading: Container(
          width: 12.0,
          height: 12.0,
          child: CircleAvatar(
            backgroundColor: Color(project.colorValue),
          ),
        ),
        title: Text(project.name),
        onTap: () {
          createTaskBloc.projectSelected(project);
          Navigator.pop(context);
        },
      ));
    });
    return projects;
  }

  List<Widget> buildLabels(
    AddTaskBloc createTaskBloc,
    BuildContext context,
    List<Label> labelList,
  ) {
    List<Widget> labels = List();
    labelList.forEach((label) {
      labels.add(ListTile(
        leading: Icon(Icons.label, color: Color(label.colorValue), size: 18.0),
        title: Text(label.name),
        trailing: createTaskBloc.selectedLabels.contains(label)
            ? Icon(Icons.close)
            : Container(width: 18.0, height: 18.0),
        onTap: () {
          createTaskBloc.labelAddOrRemove(label);
          Navigator.pop(context);
        },
      ));
    });
    return labels;
  }

  GestureDetector buildContainer(BuildContext context, Status status) {
    AddTaskBloc createTaskBloc = BlocProvider.of(context);
    return GestureDetector(
        onTap: () {
          createTaskBloc.updatePriority(status);
          Navigator.pop(context, status);
        },
        child: Container(
            color: status == createTaskBloc.lastPrioritySelection
                ? Colors.grey
                : Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 6.0,
                    color: priorityColor[status.index],
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: Text(priorityText[status.index],
                    style: TextStyle(fontSize: 18.0)),
              ),
            )));
  }
}
