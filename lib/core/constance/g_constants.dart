import 'package:flutter/material.dart';
import '../../features/domain/clients/model/client.dart';
import '../../features/domain/items/entity/item.dart';
import '../models/item.dart';

const kKeyEmailType = TextInputType.emailAddress;
const kKeyTextType = TextInputType.text;
const kKeyPhoneType = TextInputType.phone;
const kKeyNumberType = TextInputType.number;
const maxW = double.infinity;

// we're using this ScreenMode: is if the screen for navigation or for selecting item from the screen
// with this mode we defined what type of action we trigger when any item of widget inside the screen clicked
enum ScreenMode {
  select, // select from the screen
  navigate, // navigate to the screen
  update,
  delete,
}

class ItemScreenParams {
  final Item? _item;
  final ScreenMode _mode;

  ItemScreenParams({required item, required mode})
      : _item = item,
        _mode = mode;

  Item? get item => _item;

  ScreenMode get mode => _mode;
}

class ClientScreenParams {
  final Client? _client;
  final ScreenMode _mode;

  ClientScreenParams({required client, required mode})
      : _client = client,
        _mode = mode;

  Client? get client => _client;

  ScreenMode get mode => _mode;
}
