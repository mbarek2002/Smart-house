import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final databaseRef = FirebaseDatabase.instance.ref();
class _HomePageState extends State<HomePage> {

  double _startValue = 0.0;
  double _endValue = 25.0;

  //////////////chambre///////////////////////////

  double startchambre = 0.0;
  double endchambre = 25.0;
  //////////////////////////////////////////
  //////////////cuisine///////////////////////////

  double startcuisine= 0.0;
  double endcuisine = 25.0;
  //////////////////////////////////////////

  /////////////bain///////////////////////////

  double startbain = 0.0;
  double endbain = 25.0;
  //////////////////////////////////////////
  bool lightLiving=false;
  bool lightChambre=true;
  bool lightCuisine=true;
  bool lightbain=true;


  final MaterialStateProperty<Color?> trackColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF213FFF);
      }
      return null;
    },
  );
  final MaterialStateProperty<Color?> overlayColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF213FFF).withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      return null;
    },
  );

  final databaseReference = FirebaseDatabase.instance.ref();

  void readData() {
    databaseReference.child("ledvert").get().then((DataSnapshot snapshot) {
      if (snapshot.exists && snapshot.value != null) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        lightLiving = data['state'] ?? false;

        int inter = data['brightness']  ?? 0;

        if(inter ==0)
         _endValue = 0;
        else if(inter == 1)
          _endValue=25.0;
        else if(inter == 2)
          _endValue = 75.0;
        else if(inter == 3)
          _endValue = 100.0;
        setState(() {

        });

        print('Light Living111 State: $lightLiving');
      } else {
        print('No data available');
      }
    }).catchError((error) {
      print('Error getting data: $error');
    });

    databaseReference.child("ledrouge").get().then((DataSnapshot snapshot) {
      if (snapshot.exists && snapshot.value != null) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        lightChambre = data['state'] ?? false;

        int inter = data['brightness']  ?? 0;

        if(inter ==0)
          endchambre = 0;
        else if(inter == 1)
          endchambre=25.0;
        else if(inter == 2)
          endchambre = 75.0;
        else if(inter == 3)
          endchambre = 100.0;

        print('Light chambre State: $lightLiving');
        print('Light chambre State: $endchambre');
      } else {
        print('No data available');
      }
    }).catchError((error) {
      print('Error getting data: $error');
    });

    databaseReference.child("ledbleu").get().then((DataSnapshot snapshot) {
      if (snapshot.exists && snapshot.value != null) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        lightCuisine = data['state'] ?? false;

        int inter = data['brightness']  ?? 0;

        if(inter ==0)
          endcuisine = 0;
        else if(inter == 1)
          endcuisine=25.0;
        else if(inter == 2)
          endcuisine = 75.0;
        else if(inter == 3)
          endcuisine = 100.0;

        print('Light cuisine State: $lightCuisine');
        print('Light cuisine State: $endcuisine');
      } else {
        print('No data available');
      }
    }).catchError((error) {
      print('Error getting data: $error');
    });

    databaseReference.child("ledjaune").get().then((DataSnapshot snapshot) {
      if (snapshot.exists && snapshot.value != null) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        lightbain = data['state'] ?? false;

        int inter = data['brightness']  ?? 0;

        if(inter ==0)
          endbain = 0;
        else if(inter == 1)
          endbain=25.0;
        else if(inter == 2)
          endbain = 75.0;
        else if(inter == 3)
          endbain = 100.0;

        print('Light cuisine State: $lightbain');
        print('Light cuisine State: $endbain');
      } else {
        print('No data available');
      }
    }).catchError((error) {
      print('Error getting data: $error');
    });

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF050A30),
        title: Center(
          child: Container(
            width: 200,
            padding: EdgeInsets.only(top:18.0,bottom: 20),
            decoration: BoxDecoration(
              color: Color(0xFF353943),
            ),
            child: Center(child: Text('Home',style: TextStyle(color: Colors.white),)),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.only(top: 20),
        color: Color(0xFF050A30),
        child: ListView(

          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Icon(Icons.lightbulb_outline,color: Colors.white,size: 100,),
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Salon',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20

                                ),),
                                Text('lumières',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15

                                ),),
                              ],

                            ),

                            Switch(
                          // This bool value toggles the switch.
                          value: lightLiving,
                          overlayColor: overlayColor,
                          trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                          onChanged: (bool value) {
                            databaseReference.child("ledvert").update({
                              'state': value
                            }).then((_) {
                              print('Record updated successfully.');
                            }).catchError((error) {
                              print('Error updating record: $error');
                            });

                            setState(() {
                              lightLiving = value;
                            });

                          },
                        )

                          ],
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 10
                    ),
                    child: Slider(
                      value: _endValue,
                      min: _startValue,
                      max: 100,
                      divisions: 4,
                      activeColor: Color(0xFF213FFF), // Set the active color to yellow
                      inactiveColor: Color(0xFF353943),
                      label: _endValue.round().toString(),
                      onChanged: lightLiving ? (double value) {
                        setState(() {
                          _endValue = value;
                        });
                        if(_endValue==0.0)
                        databaseReference.child("ledvert").update({
                          'brightness': 0,
                        }).then((_) {
                          print('Record updated successfully.');
                        }).catchError((error) {
                          print('Error updating record: $error');
                        });

                        else if(_endValue==25.0)
                          databaseReference.child("ledvert").update({
                            'brightness': 1,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });
                        else if(_endValue==75)
                          databaseReference.child("ledvert").update({
                            'brightness': 2,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(_endValue==100)
                          databaseReference.child("ledvert").update({
                            'brightness': 3,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });


                        print(_endValue);

                      } : null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height:2,
                    color: Color(0xFF353943),
                    width: MediaQuery.sizeOf(context).width-20,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Icon(Icons.lightbulb_outline,color: Colors.white,size: 100,),
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Chambre',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20

                                ),),
                                Text('lumière',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15

                                ),),
                              ],

                            ),

                            Switch(
                              // This bool value toggles the switch.
                              value: lightChambre,
                              overlayColor: overlayColor,
                              trackColor: trackColor,
                              thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                              onChanged: (bool value) {
                                databaseReference.child("ledrouge").update({
                                  'state': value
                                }).then((_) {
                                  print('Record updated successfully.');
                                }).catchError((error) {
                                  print('Error updating record: $error');
                                });

                                setState(() {
                                  lightChambre = value;
                                });

                              },
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 10
                    ),
                    child: Slider(
                      value: endchambre,
                      min: _startValue,
                      max: 100,
                      divisions: 4,
                      activeColor: Color(0xFF213FFF), // Set the active color to yellow
                      inactiveColor: Color(0xFF353943),
                      label: endchambre.round().toString(),
                      onChanged: lightChambre ? (double value) {
                        setState(() {
                          endchambre = value;
                        });
                        if(endchambre==0.0)
                          databaseReference.child("ledrouge").update({
                            'brightness': 0,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(endchambre==25.0)
                          databaseReference.child("ledrouge").update({
                            'brightness': 1,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });
                        else if(endchambre==75)
                          databaseReference.child("ledrouge").update({
                            'brightness': 2,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(endchambre==100)
                          databaseReference.child("ledrouge").update({
                            'brightness': 3,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });


                        print(endchambre);

                      } : null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height:2,
                    color: Color(0xFF353943),
                    width: MediaQuery.sizeOf(context).width-20,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Icon(Icons.lightbulb_outline,color: Colors.white,size: 100,),
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cuisine',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20

                                ),),
                                Text('lumière',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15

                                ),),
                              ],

                            ),

                            Switch(
                              // This bool value toggles the switch.
                              value: lightCuisine,
                              overlayColor: overlayColor,
                              trackColor: trackColor,
                              thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                              onChanged: (bool value) {
                                databaseReference.child("ledbleu").update({
                                  'state': value
                                }).then((_) {
                                  print('Record updated successfully.');
                                }).catchError((error) {
                                  print('Error updating record: $error');
                                });

                                setState(() {
                                  lightCuisine = value;
                                });

                              },
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 10
                    ),
                    child: Slider(
                      value: endcuisine,
                      min: _startValue,
                      max: 100,
                      divisions: 4,
                      activeColor: Color(0xFF213FFF), // Set the active color to yellow
                      inactiveColor: Color(0xFF353943),
                      label: endcuisine.round().toString(),
                      onChanged: lightCuisine ? (double value) {
                        setState(() {
                          endcuisine = value;
                        });
                        if(endcuisine==0.0)
                          databaseReference.child("ledbleu").update({
                            'brightness': 0,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(endcuisine==25.0)
                          databaseReference.child("ledbleu").update({
                            'brightness': 1,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });
                        else if(endcuisine==75)
                          databaseReference.child("ledbleu").update({
                            'brightness': 2,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(endcuisine==100)
                          databaseReference.child("ledbleu").update({
                            'brightness': 3,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });


                        print(endcuisine);

                      } : null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height:2,
                    color: Color(0xFF353943),
                    width: MediaQuery.sizeOf(context).width-20,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Icon(Icons.lightbulb_outline,color: Colors.white,size: 100,),
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Salle de bain',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20

                                ),),
                                Text('lumière',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15

                                ),),
                              ],

                            ),

                            Switch(
                              // This bool value toggles the switch.
                              value: lightbain,
                              overlayColor: overlayColor,
                              trackColor: trackColor,
                              thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                              onChanged: (bool value) {
                                databaseReference.child("ledjaune").update({
                                  'state': value
                                }).then((_) {
                                  print('Record updated successfully.');
                                }).catchError((error) {
                                  print('Error updating record: $error');
                                });

                                setState(() {
                                  lightbain = value;
                                });

                              },
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 10
                    ),
                    child: Slider(
                      value: endbain,
                      min: _startValue,
                      max: 100,
                      divisions: 4,
                      activeColor: Color(0xFF213FFF), // Set the active color to yellow
                      inactiveColor: Color(0xFF353943),
                      label: endbain.round().toString(),
                      onChanged: lightbain ? (double value) {
                        setState(() {
                          endbain = value;
                        });
                        if(endbain==0.0)
                          databaseReference.child("ledjaune").update({
                            'brightness': 0,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(endbain==25.0)
                          databaseReference.child("ledjaune").update({
                            'brightness': 1,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });
                        else if(endbain==75)
                          databaseReference.child("ledjaune").update({
                            'brightness': 2,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });

                        else if(endbain==100)
                          databaseReference.child("ledjaune").update({
                            'brightness': 3,
                          }).then((_) {
                            print('Record updated successfully.');
                          }).catchError((error) {
                            print('Error updating record: $error');
                          });


                        print(endbain);

                      } : null,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height:2,
                    color: Color(0xFF353943),
                    width: MediaQuery.sizeOf(context).width-20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
