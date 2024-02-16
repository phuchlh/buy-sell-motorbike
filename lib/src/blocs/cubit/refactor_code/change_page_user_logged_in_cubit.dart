import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/authentication_controller.dart';

class ChangePageLoggedIn extends Cubit<bool> {
  ChangePageLoggedIn() : super(false);

  void toggleMode() async {
    bool isLogged = await AuthenticationController.isLoggedUser();
    emit(isLogged);
  }
}
