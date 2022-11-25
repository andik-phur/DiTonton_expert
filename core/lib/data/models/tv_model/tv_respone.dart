import 'package:core/data/models/tv_model/tv_model.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class ResponseTv extends Equatable {
  final List<ModelTv> tvList;

  const ResponseTv({required this.tvList});

  factory ResponseTv.fromJson(Map<String, dynamic> json) => ResponseTv(
        tvList: List<ModelTv>.from((json['results'] as List)
            .map((e) => ModelTv.fromJson(e))
            .where((element) => element.backdropPath != null)),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(tvList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [
        tvList,
      ];
}
