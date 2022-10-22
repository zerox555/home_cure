import 'package:flutter/material.dart';
import 'package:home_cure/services/resources.dart';

class SecurityTips extends StatelessWidget {
  const SecurityTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Tips page"),
        
      ),
      body: ListView.builder(
          itemCount:Resources.securityTipsInFile().length,
      itemBuilder: (BuildContext context,int index){
            return ListTile(
              title: Text("${Resources.securityTipsInFile()[index].tipNo.toString()} : ${Resources.securityTipsInFile()[index].tipDesc.toString()}")

            );
      }),
    );
  }
}
