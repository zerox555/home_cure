import 'package:flutter/material.dart';

const textInputDecoration =  InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white,
            width:2.0
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.pink,
            width:2.0
        )
    )
);

const isProduction = true;
const String google_api_key = "AIzaSyC46WXNX4g10z8QcwKsLZ1zHsSInMzMWL8";
