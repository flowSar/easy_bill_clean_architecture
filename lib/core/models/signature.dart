import 'dart:io';

class Signature {
  final int _id;
  final String _path;

  Signature({id, required path})
      : _path = path,
        _id = id;

  int get id => _id;

  String get path => _path;

  File get file => File(_path);
}
