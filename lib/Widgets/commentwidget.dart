import 'package:flutter/material.dart';
import 'package:projet_fin_etude/Models/comment.dart';
import 'package:readmore/readmore.dart';

class CommentWidget extends StatefulWidget {
  final List comments;
  const CommentWidget({Key? key , required this.comments}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.comments.length,
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
                      const CircleAvatar(
                        backgroundImage: AssetImage('Assets/images/user.png'),
                        minRadius: 12,
                        maxRadius: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(widget.comments[index].username,
                              style: const TextStyle(
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
                    const SizedBox(
                      height: 10,
                    ),
                     ReadMoreText(
                      widget.comments[index].content,
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
