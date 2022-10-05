import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'rating.g.dart';

@HiveType(typeId: 2)
class Rating extends Equatable {
  @HiveField(0)
  final double rate;
  @HiveField(1)
  final int count;
  const Rating({required this.rate, required this.count});
  @override
  List<Object?> get props => [rate, count];
}
