import 'package:equatable/equatable.dart';
import 'package:passkey/domain/models/building/building.dart';

abstract class BuildingsState extends Equatable {
  const BuildingsState();
}

class BuildingsInitial extends BuildingsState {
  @override
  List<Object> get props => [];
}

class BuildingsLoading extends BuildingsState {
  @override
  List<Object> get props => [];
}

class BuildingsRefetch extends BuildingsState {
  @override
  List<Object> get props => [];
}

class BuildingsSuccess extends BuildingsState {
  final List<BuildingModel> buildings;
  const BuildingsSuccess({
    required this.buildings,
  });

  @override
  List<Object?> get props => [buildings];
}

class BuildingsError extends BuildingsState {
  final String message;
  const BuildingsError({required this.message});

  @override
  List<Object?> get props => [message];
}
