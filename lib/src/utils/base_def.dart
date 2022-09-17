part of starlight_dart_socket_io;

typedef OnStarlightSocketIo = Function(StarlightSocket socket);
typedef OnStarlightSocket = Function(dynamic socket);
typedef StarlightSocketIoError = Function(dynamic error);

typedef StarlightSocketClients = List<StarlightSocket> Function();
typedef StarlightRoomClients = Map<String, List<StarlightSocket>> Function();
