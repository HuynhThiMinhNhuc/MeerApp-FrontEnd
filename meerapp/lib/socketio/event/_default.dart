class EventHandler<T extends Function> {
  late List<T> list;
  EventHandler() {
    list = List.empty();
  }

  void addListener(T callback) {
    list.add(callback);
  }

  void removeListener(T callback) {
    list.remove(callback);
  }

  void invoke(dynamic args) {
    for (var element in list) {
      element(args);
    }
  }
}
