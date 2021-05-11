import 'package:flutter/material.dart';

import '../model/models.dart';

class TeamProvider extends ChangeNotifier {
  Team _team;

  Team get team => _team;

  set changeTeam(Team value) {
    _team = value;
    notifyListeners();
  }
}
