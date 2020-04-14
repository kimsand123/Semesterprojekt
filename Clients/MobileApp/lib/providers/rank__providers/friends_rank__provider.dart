import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/rank.dart';

class FriendsRankProvider extends ChangeNotifier {
  // TODO: Replace with real data
  final List<Rank> _list = [
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0),
    Rank(playerName: 'Niklaes', rank: 875, handicap: 72.0)
  ];

  UnmodifiableListView<Rank> get rankList => UnmodifiableListView(_list);

  rankListLength() => _list.length;

  void add(Rank rank) {
    _list.add(rank);

    notifyListeners();
  }

  void remove(Rank rank) {
    _list.remove(rank);

    notifyListeners();
  }
}
