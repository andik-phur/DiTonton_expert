// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  const Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
