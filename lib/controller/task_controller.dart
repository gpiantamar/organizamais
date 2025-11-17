import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task.dart';

class TaskController extends ChangeNotifier {
  List<Task> _tasks = [];
  String _filter = 'all'; // 'all', 'pending', 'completed'

  List<Task> get tasks => _tasks;
  String get filter => _filter;

  List<Task> get filteredTasks {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    // Filtrar tarefas do dia atual
    final todayTasks = _tasks.where((task) {
      final taskDate = task.createdAt;
      return taskDate.isAfter(todayStart.subtract(const Duration(seconds: 1))) &&
          taskDate.isBefore(todayEnd);
    }).toList();

    switch (_filter) {
      case 'pending':
        return todayTasks.where((task) => !task.isCompleted).toList();
      case 'completed':
        return todayTasks.where((task) => task.isCompleted).toList();
      default:
        return todayTasks;
    }
  }

  List<Task> get allTasks => _tasks;

  double get completionPercentage {
    final todayTasks = filteredTasks;
    if (todayTasks.isEmpty) return 0.0;
    final completed = todayTasks.where((task) => task.isCompleted).length;
    return (completed / todayTasks.length) * 100;
  }

  int get totalTodayTasks {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    return _tasks.where((task) {
      final taskDate = task.createdAt;
      return taskDate.isAfter(todayStart.subtract(const Duration(seconds: 1))) &&
          taskDate.isBefore(todayEnd);
    }).length;
  }

  int get completedTodayTasks {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    return _tasks.where((task) {
      final taskDate = task.createdAt;
      return taskDate.isAfter(todayStart.subtract(const Duration(seconds: 1))) &&
          taskDate.isBefore(todayEnd) &&
          task.isCompleted;
    }).length;
  }

  TaskController() {
    _loadTasks();
  }

  void setFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  Future<void> _loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getString('tasks');
      if (tasksJson != null) {
        final List<dynamic> decoded = json.decode(tasksJson);
        _tasks = decoded.map((json) => Task.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro ao carregar tarefas: $e');
    }
  }

  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = json.encode(_tasks.map((task) => task.toJson()).toList());
      await prefs.setString('tasks', tasksJson);
    } catch (e) {
      debugPrint('Erro ao salvar tarefas: $e');
    }
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      await _saveTasks();
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(
        isCompleted: !task.isCompleted,
        completedAt: !task.isCompleted ? DateTime.now() : null,
      );
      await _saveTasks();
      notifyListeners();
    }
  }

  // Estatísticas para gráfico (últimos 7 dias)
  Map<DateTime, int> get weeklyCompletionStats {
    final Map<DateTime, int> stats = {};
    final now = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final dateStart = date;
      final dateEnd = dateStart.add(const Duration(days: 1));

      final dayTasks = _tasks.where((task) {
        final taskDate = task.createdAt;
        return taskDate.isAfter(dateStart.subtract(const Duration(seconds: 1))) &&
            taskDate.isBefore(dateEnd);
      }).toList();

      final completed = dayTasks.where((task) => task.isCompleted).length;
      final total = dayTasks.length;
      final percentage = total > 0 ? (completed / total * 100).round() : 0;

      stats[date] = percentage;
    }

    return stats;
  }
}

