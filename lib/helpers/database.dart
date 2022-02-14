import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sigav_app/models/session.dart';

class SigavDB {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'sigavDatabase.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE session(id INTEGER PRIMARY KEY, token TEXT, name TEXT, type TEXT, userId TEXT)");

        return;
      },
      version: 1,
    );
  }

  Future<int> createSession(Session session) async {
    int sessionId = 0;
    Database _db = await database();
    await _db
        .insert('session', session.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      sessionId = value;
    });
    return sessionId;
  }

  Future<void> deleteSession() async {
    Database _db = await database();
    await _db.delete('session');
    return;
  }

  Future<Session?> getSession() async {
    Database _db = await database();
    List<Map<String, dynamic>> sessionMap = await _db.query('session');
    List<Session> sessionList = List.generate(sessionMap.length, (index) {
      return Session(
        token: sessionMap[index]['token'],
        name: sessionMap[index]['name'],
        type: sessionMap[index]['type'],
        userId: sessionMap[index]['userId'],
      );
    });
    if (sessionList.isNotEmpty) {
      return sessionList[0];
    } else {
      return null;
    }
  }

  //

  //
  //
  //
  //

  // Future<int> insertTask(Task task) async {
  //   int taskId = 0;
  //   Database _db = await database();
  //   await _db
  //       .insert('tasks', task.toMap(),
  //           conflictAlgorithm: ConflictAlgorithm.replace)
  //       .then((value) {
  //     taskId = value;
  //   });
  //   return taskId;
  // }

  // Future<void> updateTaskTitle(int id, String title) async {
  //   Database _db = await database();
  //   await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  // }

  // Future<void> updateTaskDescription(int id, String description) async {
  //   Database _db = await database();
  //   await _db.rawUpdate(
  //       "UPDATE tasks SET description = '$description' WHERE id = '$id'");
  // }

  // Future<void> insertTodo(Todo todo) async {
  //   Database _db = await database();
  //   await _db.insert('todo', todo.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future<List<Task>> getTasks() async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> taskMap = await _db.query('tasks');
  //   return List.generate(taskMap.length, (index) {
  //     return Task(
  //         id: taskMap[index]['id'],
  //         title: taskMap[index]['title'],
  //         description: taskMap[index]['description']);
  //   });
  // }

  // Future<List<Todo>> getTodo(int taskId) async {
  //   Database _db = await database();
  //   List<Map<String, dynamic>> todoMap =
  //       await _db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
  //   return List.generate(todoMap.length, (index) {
  //     return Todo(
  //         id: todoMap[index]['id'],
  //         title: todoMap[index]['title'],
  //         taskId: todoMap[index]['taskId'],
  //         isDone: todoMap[index]['isDone']);
  //   });
  // }

  // Future<void> updateTodoDone(int id, int isDone) async {
  //   Database _db = await database();
  //   await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  // }

  // Future<void> deleteTask(int id) async {
  //   Database _db = await database();
  //   await _db.rawDelete("DELETE FROM tasks WHERE id = '$id'");
  //   await _db.rawDelete("DELETE FROM todo WHERE taskId = '$id'");
  // }

}
