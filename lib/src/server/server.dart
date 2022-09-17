part of starlight_dart_socket_io;

class StarlightSocketIo extends StarlightSocketIoBase
    with
        _StarlightSocketIoBinder,
        _StarlightSocketIoListener,
        _StarlightSocketIoCloser {
  ///C
  StarlightSocketIo({
    required super.host,
    required super.port,
  }) {
    _bind();
  }

  @override
  void on(String name, OnStarlightSocketIo socket) {
    if (_completer.isCompleted) {
      _starlightSocketIoBaselistener(name, socket);
      return;
    }
    _completer.future.then((value) {
      _starlightSocketIoBaselistener(name, socket);
    }).catchError((_) {
      _completer = Completer();
      _error(_);
    });
  }

  @override
  void close() {
    if (!_completer.isCompleted) {
      _completer.future.then((value) {
        _starlightSocketIoBasecloser();
      });
      return;
    }
    _starlightSocketIoBasecloser();
  }
}
