import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';


class Comment extends StatefulWidget {
  Comment({Key? key}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8)),
              height: 200,
              width: 280,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://scontent.fogx1-1.fna.fbcdn.net/v/t1.6435-9/80389008_464366174489481_380651642795589632_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeE-ASAJ3WrGoRMsG1fMdE2qDD6YTYl6PVMMPphNiXo9UznoV1VEB_WJPVV2Ugw3wnb3YqlK7KkjgpnvwRhlyPDi&_nc_ohc=_i2Q_pptEFMAX9vJt57&_nc_ht=scontent.fogx1-1.fna&oh=00_AT_wMYgjnHaBCIcvC_CA5JRl64K7UWipmIj0BRFvjOM-Pw&oe=62759003'),
                        minRadius: 12,
                        maxRadius: 26,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Islam belhardi',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87)),
                          Text(
                            'Il ya 4 mois',
                            style: TextStyle(color: Color(0xff94959b)),
                          )
                        ],
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don',
                      trimLines: 4,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //     'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don',
                    //     style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.black87))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}