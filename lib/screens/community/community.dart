import 'package:flutter/material.dart';
import 'discussion.dart';
import 'event.dart';

class Community extends StatelessWidget {
  const Community ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
              "",
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.lightBlue[900],
                  fontWeight: FontWeight.w600,
                  fontSize: 22)
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            indicatorColor: Colors.lightBlue[900],
            labelStyle: TextStyle(fontSize: 16.0,fontFamily: 'Inter',fontWeight: FontWeight.w600),
            labelColor: Colors.lightBlue[900],//For Selected tab
            unselectedLabelColor: Color(0xFF53A7D8),
            unselectedLabelStyle: TextStyle(fontSize: 12.0,fontFamily: 'Inter',fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: 'Event',
              ),
              Tab(text: 'Discussion')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            event(),
            discussion()
          ],
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                  backgroundColor: Color(0xFFE0F0FF),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      width: 380,
                      height: 450,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('Subject Title: ',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF015C92),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5) ,
                              child:  TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the subject title';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Description: ',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF015C92),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding:EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5) ,
                              child:  TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                    border: InputBorder.none
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter event description';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue[100], // Background color
                              ),
                              onPressed: (){},
                              icon: Icon(Icons.add_a_photo_outlined,
                                color: Color(0xFF015C92),),
                              label: Text('Upload ',
                                  style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF015C92),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16))),
                          SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                              width: 120,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState() {

                                    };
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF015C92), // Background color

                                  ),
                                  child:  Text(
                                            'Report',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20)
                                        ),
                                      ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )));
            },
            child: Icon(Icons.add),
            backgroundColor: Color(0xFF015C92) ,
          )
      ),
    );
  }
}
