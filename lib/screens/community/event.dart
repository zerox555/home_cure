import 'package:flutter/material.dart';

class event extends StatefulWidget {
  const event({Key? key}) : super(key: key);

  @override
  State<event> createState() => _eventState();
}

class _eventState extends State<event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                width: 370,

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
                    ]), //Depend on the incidence level (or else we put this action at last first)
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Report Title and Time
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/jesse.jpg'),
                          radius: 18.0,
                        ),
                        SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Username', //can replace with $reportTitle
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF015C92),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)
                            ),Text('8,Jalan Odyssey 10', //can replace with $reportTitle
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF2D82B5),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14)
                            )
                          ],
                        ),
                        Expanded(
                          child: Text('4.40pm\n2 Oct 2022', //can replace with $time and $date
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF2D82B5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14)),
                        )
                      ],
                    ),
                    //Reported By
                    SizedBox(height: 10),
                    Text('Case Title', //can replace with $reportedBy
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF2D82B5),
                            fontWeight: FontWeight.w700
                            ,
                            fontSize: 16)
                    ),
                    SizedBox(height: 5),
                    //can replace with $textDescription
                    Text('Welcome to ANYTIME GYM, there is a promotion here for this month only quickly sign up!!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF2D82B5),
                          fontWeight: FontWeight.w500
                          ,
                          fontSize: 14),

                    ),
                    SizedBox(height: 10),
                    // if got then  display picture
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'Image/B-and-E.png',
                        height: 130,
                        width: 300,
                        fit: BoxFit.fill,
                      ),
                    )
                    //Description
                    //Image
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
