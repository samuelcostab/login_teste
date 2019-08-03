import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login-bloc.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        bloc: LoginBloc(context),
        child: Material(
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6U3gZNYtevuwqeYp_-6XoNBGCjHz_uZONIUen88TqtWdbsiP-",
                fit: BoxFit.cover),
            Container(
              color: Colors.grey[800].withOpacity(0.6),
            ),
            SingleChildScrollView(child: _LoginContent()),
          ],
        )));
  }
}

class _LoginContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);

    _buttons() {
    return Column(
      children: <Widget>[
        RaisedButton.icon(
          color: Colors.green,
          textColor: Colors.white,
          icon: Icon(Icons.phone),
          label: Text("Login com Telefone "),
          onPressed: bloc.onClickTelefone,
        ),
        RaisedButton.icon(
          color: Colors.red,
          textColor: Colors.white,
          icon: Icon(FontAwesomeIcons.google),
          label: Text("Login com Google    "),
          onPressed: bloc.onClickGoogle,
        ),
        RaisedButton.icon(
          color: Colors.blue,
          textColor: Colors.white,
          icon: Icon(FontAwesomeIcons.facebookF),
          label: Text("Login com Facebook"),
          onPressed: bloc.onClickFacebook,
        ),
      ],
    );
  }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(
            size: 72,
          ),
          Container(
            height: 120,
          ),
          StreamBuilder(
            stream: bloc.outLoading,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return AnimatedCrossFade(
                firstChild: _buttons(),
                secondChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:CircularProgressIndicator(),
                ),
                duration: Duration(milliseconds: 500),
                crossFadeState: snapshot.data ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              );
            },

          ),
          TextField(

            /*TextFormField(
          controller: _phoneNumberController,
          decoration:
              InputDecoration(labelText: 'Phone number (+x xxx-xxx-xxxx)'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Phone number (+x xxx-xxx-xxxx)';
            }
            return null;*/
            onChanged: bloc.phoneEvent.add,
            onSubmitted: (String value) => bloc.onClickTelefone(),
          )
        
        ]
      );
  }
}
