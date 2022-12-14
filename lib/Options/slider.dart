import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Options/status_service.dart';
import 'package:flutter_application_3/Options/storage_servis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';

class slider extends StatelessWidget {
  const slider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusServiceresim _statusServiceresim = StatusServiceresim();
    Size size = MediaQuery.of(context).size;
    StorageDuyuru storageDuyuru = StorageDuyuru();

    return Carousel(
        dotSize: 6.0,
        dotSpacing: 15.0,
        dotPosition: DotPosition.bottomCenter,
        images: [
        
              StreamBuilder<QuerySnapshot>(
                  stream: _statusServiceresim.getStatus(),
                  builder: (context, snaphot) {
                    return !snaphot.hasData
                        ? CircularProgressIndicator()
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemCount: snaphot.data.docs.length,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              DocumentSnapshot mypost =
                                  snaphot.data.docs[index] ?? '';

                              Future<void> _showChoiseDialog(
                                  BuildContext context) {}
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: size.width * 0.7,
                                            height: size.height * 0.3,
                                  child: FutureBuilder(
                                    future:
                                        storageDuyuru.downloadURL(mypost['image']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return Container(
                                            width: size.width * 0.7,
                                            height: size.height * 0.3,
                                            child: PhotoView(
                                              imageProvider: NetworkImage(
                                                snapshot.data,
                                              ),
                                              minScale:
                                                  PhotoViewComputedScale.contained *
                                                      1.2,
                                              maxScale:
                                                  PhotoViewComputedScale.covered *
                                                      2,
                                              enableRotation: false,
                                            ));
                                      }
                                      if (snapshot.connectionState ==
                                              ConnectionState.waiting ||
                                          !snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              );
                            });
                  }),
            ],
          );
        
  }
}
