import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedIndexCubit extends Cubit<int> {
  SelectedIndexCubit() : super(0);

  void updateSelectedIndex(int index) => emit(index);
}
