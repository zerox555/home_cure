import 'package:flutter/material.dart';

import '../../services/resources.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("faq page"),
        ),
        body: ListView.builder(
            itemCount: Resources.faqsInFile().length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                    "${Resources.faqsInFile()[index].faqNo.toString()} : ${Resources.faqsInFile()[index].question.toString()}"),
                subtitle: Text(Resources.faqsInFile()[index].answer.toString()),
              );
            }));
  }
}
