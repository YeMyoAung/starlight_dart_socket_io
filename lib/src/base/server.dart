part of starlight_dart_socket_io;

dynamic _error(dynamic error) =>
    log("Error is $error", name: "StarlightSocketIoBase");

abstract class StarlightSocketIoBase {
  final String host;
  final int port;
  final StarlightSocketIoError onError;
  Completer<void> _completer = Completer();

  bool get isCreated => _completer.isCompleted;

  final List<StarlightSocket> _clients = [];

  int get users => _clients.length;

  final Map<String, List<StarlightSocket>> _join = {};

  List<String> get rooms => _join.keys.toList();

  late StarlightSocketEmitter sockets;
  late ServerSocket _serverSocket;
  late StreamSubscription<StarlightSocket> _subscription;

  StarlightSocketIoBase({
    required this.host,
    required this.port,
    this.onError = _error,
  }) {
    sockets = StarlightSocketEmitter._(
      clients: () => _clients,
    );
  }

  ///Who connect to server
  void on(String name, OnStarlightSocketIo socket);

  void close();
}
