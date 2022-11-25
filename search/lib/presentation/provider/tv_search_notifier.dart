// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/usecase/search_tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final TvSearch searchTv;
  TvSearchNotifier({required this.searchTv});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Television> _searchResultTv = [];
  List<Television> get searchResultTv => _searchResultTv;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await searchTv.execute(query);
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (success) {
      _searchResultTv = success;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
