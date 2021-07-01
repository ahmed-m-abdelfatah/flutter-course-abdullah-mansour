import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:to_do_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:to_do_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:to_do_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // Object
  static AppCubit get(context) => BlocProvider.of(context);

  // Bottom Sheet Numbers
  int currentIndex = 0;
  List<Widget> bodyScreens = [NewTasksScreen(), DoneTasksScreen(), ArchivedTasksScreen()];
  List<String> titleScreen = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  // Database
  late Database _database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database _database, int version) {
        _database
            .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (Database _database) {
        getDataFromDatabase(_database);
        print('opened');
      },
    ).then((value) {
      _database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await _database.transaction((txn) async {
      txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")').then((value) {
        print('task inserted');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(_database);
      }).catchError((err) {
        print(err.toString());
      });
    });
  }

  void getDataFromDatabase(Database _database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppCreateDatabaseLoadingState());
    _database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({required String status, required int id}) async {
    _database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]).then((value) {
      getDataFromDatabase(_database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({required int id}) async {
    _database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(_database);
      emit(AppDeleteDatabaseState());
    });
  }

  // floating action bottom
  bool isBottomSheetShawn = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShawn = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }
}
