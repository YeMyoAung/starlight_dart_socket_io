part of starlight_dart_socket_io;

extension _StringExt on String {
  bool toRoom() {
    final List<String> textSplit = split('.');
    if (textSplit.length != 3) return false;

    return textSplit.contains('_join') && textSplit.contains('^___');
  }
}
