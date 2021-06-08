part of 'bottom_navbar_cubit.dart';

class BottomNavbarState extends Equatable {
  final BottomNavbarItem selectedItem;

  const BottomNavbarState({required this.selectedItem});

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [selectedItem];
}
