





import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:localization_3/services/api.dart';
import 'package:localization_3/models/model.dart';
import 'package:easy_localization/easy_localization.dart';


class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  var imageIndex = 0;
  var mController = SwiperController();

  var api = Api();
  List<Help> help;

  String currentLag;
  Future<bool> getPosts(String lang) async {
    var response = await api.posts(lang);
    Localize model = Localize.fromJson(response.data);
    help = model.data.help;
    return true;
  }


  @override
  Widget build(BuildContext context) {
    currentLag = EasyLocalization.of(context).locale.languageCode;

    return  FutureBuilder(
          future: getPosts(currentLag),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: GestureDetector(onTap: (){
                    Navigator.pop(context);
                  },child: Icon(Icons.arrow_back, color: Colors.black,)),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          child: Swiper(
                            itemWidth: MediaQuery.of(context).size.width,
                            itemCount: help.length,
                            index: imageIndex,
                            controller: mController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  child: Image.network(
                                    "http://loans.neoxero.com/${help[index].image}",
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            },
                            pagination: new SwiperPagination(),
                            onIndexChanged: (index) {
                              setState(() {
                                imageIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(15),
                          child: Text(
                            help[imageIndex].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Text(help[imageIndex].content),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,left: 20 , bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffd5bc91),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: IconButton(
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  disabledColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(Icons.language),
                                  onPressed: () {

                                  }),
                            ) ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff454f63),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(

                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                          if(help.length == 3){
                                            print("reached");
                                          }
                                          mController.previous();
                                      }),
                                ),
                                SizedBox(width: 7,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff1c9a98),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_forward),
                                      onPressed: () {
                                        setState(() {
                                          mController.next();
                                        });
                                      }),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              );
            }
          });

  }
}
