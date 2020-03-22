import 'package:flutter/material.dart';

import 'package:localization_3/models/program_model.dart';

class FavoritePrograms extends StatefulWidget {
  @override
  _FavoriteProgramsState createState() => _FavoriteProgramsState();
}

class _FavoriteProgramsState extends State<FavoritePrograms> {

  final ProgramHelper helper = ProgramHelper();
  bool isFavorite = true;
  List<Program> programs ;



 // List<Program> Programs = await helper.getAllPrograms();



  @override
  Widget build(BuildContext context) {

//    if (programs == null){
//      programs = List<Program>();
//    }

   return FutureBuilder(

        future: helper.getAllPrograms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return Scaffold(
              backgroundColor: Color(0xffeeeeee),
              appBar: AppBar(
                title: Text(
                  'Favorite Programs',
                  textAlign: TextAlign.left,
                ),
              ),
              body: ListView.builder(
                itemCount:1,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            programs[index].value,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                                    isFavorite = !isFavorite;
                                    helper.deleteProgram(programs[index].id);
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text('Remove from favorites'),
                                      Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
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
                  );
                },
              ),
            );
          }
        });
  }}
