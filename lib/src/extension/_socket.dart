part of starlight_dart_socket_io;

extension StarlightSocketExt on StarlightSocket {
  ///Receive Data From Client
  void on(String name, OnStarlightSocket onStarlightSocket) {
    _controller.stream.listen((sendData) {
      if (_completer != null) {
        _completer!.future.then((value) {
          _completer = null;
          _listener(
            name,
            onStarlightSocket,
            sendData,
          );
        }).catchError((_) {
          ///ToDo::
        });
      } else {
        _listener(
          name,
          onStarlightSocket,
          sendData,
        );
      }
    });
  }

  void _listener(
    String name,
    OnStarlightSocket callback,
    String sendData,
  ) {
    try {
      scheduleMicrotask(() {
        _completer = Completer();

        for (final chunk in sendData.split('\n')
          ..removeWhere((_) => _.isEmpty)) {
          ///Map
          ///key => one
          ///value => many
          try {
            final Map<String, dynamic> map = json.decode(chunk);

            if (map.keys.first.toRoom()) {
              if (map[map.keys.first] == _joinARoomKey) {
                ///Join
                if (rooms().containsKey(map.keys.first)) {
                  final List<StarlightSocket> sockets =
                      (rooms()[map.keys.first] as List<StarlightSocket>)
                          .toList();

                  if (sockets.contains(this)) continue;
                  sockets.add(this);
                  rooms()[map.keys.first] = sockets;
                } else {
                  rooms().addEntries({
                    MapEntry(map.keys.first, [this])
                  });
                }
                continue;
              }

              _sendDataToRoom(
                map.keys.first,
                // json.encode({map.keys.first: map[map.keys.first]}),
                chunk,
              );
              continue;
            }

            if (!map.containsKey(name)) continue;
            callback(map[name]);
          } catch (e) {
            ///
          }
        }
        _completer?.complete();
      });
    } catch (e) {
      ///
    }
  }

  void _sendDataToRoom(String room, String sendData) {
    for (final user in (rooms()[room] as List<StarlightSocket>)) {
      if (_roomEmitter != null) {
        _roomEmitter!.future.then((value) {
          _roomEmitter = null;
          _writeLn(user, sendData);
        });
      } else {
        _writeLn(user, sendData);
      }
    }
  }

  void _writeLn(StarlightSocket user, dynamic sendData) {
    scheduleMicrotask(() {
      _roomEmitter = Completer();
      user.socket.writeln(sendData);
      _roomEmitter?.complete();
    });
  }
}
