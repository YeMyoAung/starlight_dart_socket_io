part of starlight_dart_socket_io;

mixin _StarlightSocketIoBinder on StarlightSocketIoBase {
  Future<void> _bind() async {
    _serverSocket = await ServerSocket.bind(host, port);
    _completer.complete();
  }
}
