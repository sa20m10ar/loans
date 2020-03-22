import 'package:flutter/material.dart';
import 'package:localization_3/models/program_model.dart';

class Programs extends StatefulWidget {
  @override
  _ProgramsState createState() => _ProgramsState();
}

class _ProgramsState extends State<Programs> {

  bool isFavorite = false;
  Program currentProg;
  final ProgramHelper helper = ProgramHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        title: Text(
          'Compatible Programs',
          textAlign: TextAlign.left,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Program 1',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = true;
                            currentProg = Program(1, 'Program 1');
                            helper.insertProgram(currentProg);
                          });
                        },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text('Add to favorites'),
                              Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          width: 160,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffe0e0e0),
                                    blurRadius: 0.2,
                                    offset: Offset(0.2, 0.2),
                                    spreadRadius: 1.0)
                              ]),
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            height: 250,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
            ),
          )
        ],
      ),
    );
  }
}
