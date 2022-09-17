part of starlight_dart_socket_io;

class StarlightSocketEmitter {
  Completer? completer;

  final StarlightSocketClients clients;
  StarlightSocketEmitter._({
    required this.clients,
  });
}
