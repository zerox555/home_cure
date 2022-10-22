import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_cure/models/discussion.dart';
import 'package:readmore/readmore.dart';

import '../../models/community_event.dart';
import '../../services/resources.dart';
import 'package:intl/intl.dart';


class discussion extends StatefulWidget {
  const discussion({Key? key}) : super(key: key);

  @override
  State<discussion> createState() => _discussionState();
}

class _discussionState extends State<discussion> {
  //get shortened version for short post
  String getShortenedText(String text,int limit){
    String placeholderText=text;
    if(text.length > limit){
      placeholderText = text.substring(0,limit);
      placeholderText = '$placeholderText..';
    }

    return placeholderText;
  }

  @override
  Widget build(BuildContext context) {

    const int userCharMax = 15;
    const int titleCharMax = 25;
    const int descCharMax = 80;
    return Scaffold(
        body: Container(
          margin: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Resources.discussionPostList.length,
                    itemBuilder: (BuildContext context,int index){
                      List<DiscussionPost> discussionPostList = Resources.discussionPostList;
                      String _dayOfYear = DateFormat('yyyy-MM-dd')
                          .format(discussionPostList [index].timeOfRelease);
                      String _timeOfDay = DateFormat('HH:mm:ss')
                          .format(discussionPostList [index].timeOfRelease);
                      return Container(
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
                                  // backgroundImage: AssetImage('assets/jesse.jpg'),
                                  radius: 18.0,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getShortenedText(discussionPostList [index].userName, userCharMax), //can replace with $reportTitle
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)
                                    ),Text('${discussionPostList [index].address}', //can replace with $reportTitle
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
                                  child: Text('$_timeOfDay\n$_dayOfYear', //can replace with $time and $date
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
                            Text(getShortenedText(discussionPostList [index].eventTitle, titleCharMax), //can replace with $reportedBy
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
                      ReadMoreText(
                              discussionPostList [index].eventDesc,
                              trimLines: 2,
                              textAlign: TextAlign.left,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              style: TextStyle(fontFamily: 'Inter',
                                  color: Color(0xFF2D82B5),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                              trimExpandedText: 'Show less',
                              moreStyle: TextStyle(fontFamily: 'Inter',
                                  color: Color(0xFF2D82B5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            // if got then  display picture
                            discussionPostList[index].imageUrl!.isNotEmpty
                                ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                    File(discussionPostList[index].imageUrl!),
                                    height: 130,
                                    width: 300,
                                    fit: BoxFit.fill))
                                : Container(),
                            //Description
                            //Image
                          ],
                        ),

                      );

                    })
              ],
            ),
          ),
        )
    );
  }
}
