import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget{
  final IconData icono;
  final TextInputType type;
  final bool pass;
  final String texto;
  final TextEditingController controller;
  const TextFieldCustom({this.icono, this.type, this.pass=false, this.texto,this.controller});

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText:pass,
      decoration:InputDecoration(
        hintText: texto,
        filled:true,
        fillColor:Color.fromRGBO(233, 207, 236, 1.0),
        prefixIcon: Icon(icono,color:Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEBDCFA)),
          borderRadius: BorderRadius.circular(50)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEBDCFA)),
          borderRadius: BorderRadius.circular(50),
        )

      )
    );
  }
}