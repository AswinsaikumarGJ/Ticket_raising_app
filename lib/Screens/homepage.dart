import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ticket_raising_app/Bloc/form_bloc/bloc/form_bloc.dart';
import 'package:ticket_raising_app/Models/forms_model.dart';
import 'package:ticket_raising_app/Repository/forms_repository.dart';
import 'package:ticket_raising_app/Screens/forms.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var formatteddate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  FormRepository fr = new FormRepository();
  var fetchedata;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => FormBloc(
          formRepository: RepositoryProvider.of<FormRepository>(context))
        ..add(FormLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Raised Tickets"),
        ),
        body: BlocBuilder<FormBloc, FormsState>(
          builder: (context, state) {
            if (state is FormLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FormLoadedState) {
              return Container(
                  height: h,
                  width: w,
                  padding: EdgeInsets.all(20),
                  child: StreamBuilder<List<FormsModel>>(
                      stream: RepositoryProvider.of<FormRepository>(context)
                          .getTicketsDetails(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final tickets = snapshot.data!;
                          Logger().e(tickets);
                          return snapshot.data?.length == 0
                              ? Center(
                                  child: Text(
                                  "No Record Found",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              : ListView.builder(
                                  itemCount: tickets.length,
                                  itemBuilder: (context, index) => Container(
                                    height: h * 0.22,
                                    width: w,
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 219, 210, 210)
                                                .withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(children: [
                                      Positioned(
                                        top: h * 0.03,
                                        left: w * 0.05,
                                        child: Text(
                                            "Title : ${tickets[index].title}"),
                                      ),
                                      Positioned(
                                          top: h * 0.063,
                                          left: w * 0.05,
                                          child: Text(
                                              "Description : ${tickets[index].description}")),
                                      Positioned(
                                          top: h * 0.095,
                                          left: w * 0.05,
                                          child: Text(
                                              "Location : ${tickets[index].location}")),
                                      Positioned(
                                          top: h * 0.13,
                                          left: w * 0.05,
                                          child: Text(
                                              "Date : ${tickets[index].date}")),
                                      Positioned(
                                          top: h * 0.165,
                                          left: w * 0.05,
                                          child: Text(
                                              "Attachment : ${tickets[index].attachmentname}")),
                                    ]),
                                  ),
                                );
                        }
                        return Text('');
                      })));
            }

            return Text("");
          },
        ),
      ),
    );
  }
}
