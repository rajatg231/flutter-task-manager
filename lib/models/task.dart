class Task {
  final int id;
  final String title;
  bool done;
  final String username;

  Task({
    required this.id,
    required this.title,
    this.done = false,
    required this.username,
  });
  Task copyWith({int? id, String? title, bool? done, String? username}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      username: username ?? this.username,
    );
  }

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['taskName'],
      done: taskMap['status'],
      username: taskMap['username'],
    );
  }

  void toggle() {
    done = !done;
  }
}
