part of starlight_dart_socket_io;

extension SocketEmitterExt on StarlightSocketEmitter {
  void emit(String name, dynamic data) {
    if (completer != null) {
      completer!.future.then((value) {
        completer = null;
        _send(json.encode({name: data}));
      }).catchError((_) {
        ///ToDo::
      });
      return;
    }

    _send(json.encode({name: data}));
  }

  void _send(String data) {
    try {
      scheduleMicrotask(() {
        completer = Completer();
        for (final starlightSocket in clients()) {
          starlightSocket.socket.writeln(data);
        }
        completer?.complete();
      });
    } catch (e) {}
  }

  void close() {
    for (final element in clients()) {
      element.close();
    }
  }
}
