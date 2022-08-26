import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/utils/config.dart';

class PendingInstJobCardDetails extends StatefulWidget {
  final id;
  final date;
  final customername;
  final finphone;
  final custphone;
  final vehreg;
  final location;
  final docno;
  final vehmodel;
  final notracker;
  final remarks;
  final finname;
  const PendingInstJobCardDetails({
    key,
    this.id,
    this.date,
    this.customername,
    this.finphone,
    this.custphone,
    this.vehreg,
    this.location,
    this.docno,
    this.vehmodel,
    this.notracker,
    this.remarks,
    this.finname,
  });

  @override
  State<PendingInstJobCardDetails> createState() =>
      _PendingInstJobCardDetailsState();
}

class _PendingInstJobCardDetailsState extends State<PendingInstJobCardDetails> {
  int? jobcardid;
  String? jobcarddate;
  String? jobcardcustomername;
  String? jobcardfinphone;
  String? jobcardcustphone;
  String? jobcardvehreg;
  String? jobcardlocation;
  String? jobcarddocno;
  String? jobcardvehmodel;
  int? jobcardnotracker;
  String? jobcardremarks;
  String? jobcardfinname;
  @override
  void initState() {
    setState(() {
      jobcardid = widget.id;
      jobcarddate = widget.date;
      jobcardcustomername = widget.customername;
      jobcardfinphone = widget.finphone;
      jobcardvehreg = widget.vehreg;
      jobcardlocation = widget.location;
      jobcarddocno = widget.docno;
      jobcardvehmodel = widget.vehmodel;
      jobcardnotracker = widget.notracker;
      jobcardremarks = widget.remarks;
      jobcardfinname = widget.finname;
      jobcardcustphone = widget.custphone;
    });

    // TODO: implement initState
    super.initState();
    print('$jobcardcustomername');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 500,
                width: 500,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.red, width: 0.5),
                      borderRadius: BorderRadius.circular(5)),
                  //Wrap with IntrinsicHeight

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text(
                                    'Job Card Details',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.red),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    "Customer :  ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    " $jobcardcustomername",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    "Vehicle Registration :  ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    "$jobcardvehreg",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "location :  $jobcardlocation",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Vehicle Model :  $jobcardvehmodel",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Customer Phone :  $jobcardcustphone ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "No of Trackers :  $jobcardnotracker",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Remarks :  $jobcardremarks",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Date :  $jobcarddate",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomRight: Radius.circular(18)),
                          color: Colors.red,
                        ),
                        width: 5,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
