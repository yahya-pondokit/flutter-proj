import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/pages/tasks/bloc/task_bloc.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:flutter_app/pages/labels/label_db.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/home/home_bloc.dart';
import 'package:flutter_app/pages/labels/label_bloc.dart';
import 'package:flutter_app/pages/labels/label_widget.dart';
import 'package:flutter_app/pages/projects/project_bloc.dart';
import 'package:flutter_app/pages/projects/project_widget.dart';
import 'package:flutter_app/pages/home/about.dart';
import 'package:flutter_app/main.dart';

class SideDrawer extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          AppBar(automaticallyImplyLeading: false, title: Text('Options')),
          ListTile(
            onTap: () {
              homeBloc.applyFilter("Semua", Filter.byYears());
              Navigator.pop(context);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            // leading: Icon(Icons.calendar_today),
            title: Text("Semua Tugas",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () {
              homeBloc.applyFilter("Hari Ini", Filter.byToday());
              Navigator.pop(context);
            },
            // leading: Icon(Icons.calendar_today),
            title: Text("Hari Ini",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () {
              homeBloc.applyFilter("Minggu Depan", Filter.byNextWeek());
              Navigator.pop(context);
            },
            title: Text("Minggu Depan",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
          ),
          Divider(),
          ListTile(
              // leading: Icon(Icons.inbox),
              title: Text("Umum",
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              onTap: () {
                var project = Project.getInbox();
                homeBloc.applyFilter(
                    project.name, Filter.byProject(project.id));
                Navigator.pop(context);
              }),
          BlocProvider(
            bloc: ProjectBloc(ProjectDB.get()),
            child: ProjectPage(),
          ),
          Divider(),
          ListTile(
            title: Text("About",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AboutPage()));
            },
          ),
          // BlocProvider(
          //   bloc: LabelBloc(LabelDB.get()),
          //   child: LabelPage(),
          // )
        ],
      ),
    );
  }
}
