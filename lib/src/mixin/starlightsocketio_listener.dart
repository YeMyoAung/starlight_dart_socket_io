part of starlight_dart_socket_io;

mixin _StarlightSocketIoListener on StarlightSocketIoBase {
  void _starlightSocketIoBaselistener(
    String name,
    OnStarlightSocketIo onStarlightSocketIo,
  ) {
    switch (name) {
      case _connection:
        _subscription = _serverSocket
            .map((socket) => StarlightSocket._(socket, () => _join))
            .listen((starlightsocket) {
          scheduleMicrotask(() {
            if (!_clients.contains(starlightsocket)) {
              _clients.add(starlightsocket);
            }
            onStarlightSocketIo(starlightsocket);
          });
        });
        break;
      default:
    }
  }
}
