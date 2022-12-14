import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Duyurular/DuyuruMetni.dart';
import 'package:flutter_application_3/Options/status_service.dart';

class duyuru extends StatelessWidget {
  const duyuru({
    Key key,
    @required StatusService statusService,
    @required this.size,
  })  : _statusService = statusService,
        super(key: key);

  final StatusService _statusService;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      showTrackOnHover: true,
      isAlwaysShown: true,
      child: StreamBuilder<QuerySnapshot>(
        stream: _statusService.getStatus(),
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snaphot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snaphot.data.docs[index] ?? '';
                    String postValue = "${mypost['Metin']}";

                    Future<void> _showChoiseDialog(BuildContext context) {}
                    if (mypost['Duyuru Durumu'] == false) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _showChoiseDialog(context);
                          },
                          child: Container(
                            height: size.height * .2,
                            decoration: BoxDecoration(
                                color: Color(0xFFeeeee0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.50),
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                  )
                                ],
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.pushReplacement(
                                        //Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DuyuruMetniPage(
                                                  postValue: postValue,
                                                )),
                                      ),
                                      child: Text(
                                        postValue,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else{
                      mypost['Duyuru Durumu'] == false;
                      return Text("",style: TextStyle(fontSize: 1),);
                    }
                  });
        },
      ),
    );
  }
}
