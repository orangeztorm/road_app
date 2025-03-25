import 'package:road_app/cores/__cores.dart';

class CompletePotholeParam extends RequestParam {
  final String id;

  const CompletePotholeParam(this.id);

  @override
  Map<String, dynamic> toMap() {
    return {"potholeId": id};
  }

  @override
  List<Object?> get props => [id];
}
