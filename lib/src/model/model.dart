part of starlight_dart_socket_io;

///Model
class StarlightSocket {
  final int id;
  final Socket socket;
  final StarlightRoomClients rooms;

  late StreamController<String> _controller;
  late StreamSubscription<String> _subscription;

  Completer? _completer;
  Completer? _roomEmitter;

  StarlightSocket._(
    this.socket,
    this.rooms,
  ) : id = DateTime.now().hashCode {
    _controller = StreamController.broadcast();
    socket.map(utf8.decode).pipe(_controller);
    on(_init, (socket) => null);
  }

  void emit(String name, dynamic data) =>
      socket.writeln(json.encode({name: data}));

  void close() {
    _controller.close();
    socket.close();
    _subscription.cancel();
  }
}
