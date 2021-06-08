import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/enums/enums.dart';

part 'bottom_navbar_state.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarState> {
  BottomNavbarCubit() : super(BottomNavbarState(selectedItem: BottomNavbarItem.feed));

  void updateSelectedItem(BottomNavbarItem item) {
    if (item != state.selectedItem) {
      emit(BottomNavbarState(selectedItem: item));
    }
  }
}
