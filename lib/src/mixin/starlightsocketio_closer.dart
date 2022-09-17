part of starlight_dart_socket_io;

mixin _StarlightSocketIoCloser on StarlightSocketIoBase {
  void _starlightSocketIoBasecloser() {
    _serverSocket.close();
    sockets.close();
    _subscription.cancel();
    _clients.clear();
    _join.clear();
  }
}
