import 'package:flutter/material.dart';
import 'package:home_cure/services/resources.dart';
import '../../models/security_tips.dart';
import '../../models/security_tips.dart';
import 'package:readmore/readmore.dart';

class SecurityTips extends StatelessWidget {


  Widget tipTemplate(SecurityTip tip){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20.0),
            width: 330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFE0F0FF),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFC9D9E8),
                    spreadRadius: 0,
                    blurRadius: 16,
                    offset: Offset(8, 8),
                  ),
                  BoxShadow(
                    color: Color(0xFFFFFFFF),
                    spreadRadius: 0,
                    blurRadius: 16,
                    offset: Offset(-8, -8),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    tip.tipTitle,//can replace with $reportTitle
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFF015C92),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                ),
                SizedBox(height: 5),
                ReadMoreText(
                  tip.tipDesc,
                  trimLines: 3,
                  textAlign: TextAlign.left,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  style: TextStyle(fontFamily: 'Inter',
                      color: Color(0xFF2D82B5),
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  trimExpandedText: ' Show less',
                  moreStyle: TextStyle(fontFamily: 'Inter',
                      color: Color(0xFF2D82B5),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            ) ,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            'Security Tips',
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],

      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Column(
            children : [ListView.builder(

              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Resources.securityTipsInFile().length,
                itemBuilder: (BuildContext context, int index){
              return tipTemplate(Resources.securityTipsInFile()[index]);
            })
]
          ),
        ),
      ),
    );
  }
}
