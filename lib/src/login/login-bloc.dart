import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:login_teste/src/home/home-widget.dart';
import 'package:login_teste/src/model/services/auth/Authentication.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  final _authentication = Authentication();


  //fluxo para o numero do celular
  final _phoneController = BehaviorSubject<String>();
  Observable<String> get phoneFlux => _phoneController.stream;
  Sink<String> get phoneEvent => _phoneController.sink;

  //fluxo para a mensagem sms
  final _smsController = BehaviorSubject<String>();
  Observable<String> get smsFlux => _smsController.stream;
  Sink<String> get smsEvent => _smsController.sink;

  //fluxo para o login
  var _controllerLoading = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get outLoading => _controllerLoading.stream;

  final BuildContext context;
  LoginBloc(this.context);

  Future<void> onClickFacebook() async {
    _controllerLoading.add(!_controllerLoading.value);
    await Future.delayed(Duration(seconds: 2));
    _controllerLoading.add(!_controllerLoading.value);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
  }

  Future<void> onClickGoogle() async {
    _controllerLoading.add(!_controllerLoading.value);
    await Future.delayed(Duration(seconds: 2));
    _controllerLoading.add(!_controllerLoading.value);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
  }

  Future<void> onClickTelefone() async {
    _controllerLoading.add(!_controllerLoading.value);

    await _authentication.verifyPhoneNumber(_phoneController.value);

    _controllerLoading.add(!_controllerLoading.value);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeWidget()));
  }

  @override
  void dispose() {
    _controllerLoading.close();
    _phoneController.close();
    _smsController.close();
  }
}
