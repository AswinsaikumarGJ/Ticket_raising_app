import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_raising_app/Bloc/form_bloc/bloc/form_bloc.dart';
import 'package:ticket_raising_app/Models/forms_model.dart';
import 'package:ticket_raising_app/Repository/forms_repository.dart';
import 'package:ticket_raising_app/Widgets/custom_button.dart';
import 'package:ticket_raising_app/Widgets/custom_textformfield.dart';

class FormsPage extends StatefulWidget {
  const FormsPage({Key? key}) : super(key: key);

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  var formatteddate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController datecontroller = new TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController attachmentcontroller = TextEditingController();
  TextEditingController attachmentcontrollername = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FormRepository fr = new FormRepository();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      datecontroller.text = formatteddate;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => FormBloc(
          formRepository: RepositoryProvider.of<FormRepository>(context)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Ticket Forms Page"),
        ),
        body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Title',
                      readonly: false,
                      controller: titlecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Description',
                      readonly: false,
                      controller: descriptioncontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Location',
                      readonly: false,
                      controller: locationcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Date',
                      readonly: true,
                      controller: datecontroller,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Attachment',
                      readonly: true,
                      iconwant: true,
                      controller: attachmentcontrollername,
                      onPressed: () {
                        fr.filePicker(
                            filefetch: attachmentcontroller,
                            file: attachmentcontrollername);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the field';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,   
                    ),
                    addFormButton(h, w, context)
                  ],
                ),
              )),
        ),
      ),
    );
  }

  addFormButton(double h, double w, BuildContext context) {
    return BlocListener<FormBloc, FormsState>(
      listener: (context, state) {
        if (state is FormAddedState) {
          final snackBar = SnackBar(
            content: Text("Successfully Posted"),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
        }
      },
      child: BlocBuilder<FormBloc, FormsState>(builder: (context, state) {
        return CustomButton(
            h: h * 0.07,
            w: w * 0.4,
            buttonname: 'Submit',
            onPressed: () {
              if (titlecontroller != null &&
                  descriptioncontroller != null &&
                  locationcontroller != null &&
                  attachmentcontroller != null) {
                if (_formKey.currentState!.validate()) {
                  final form = FormsModel(
                    title: titlecontroller.text,
                    description: descriptioncontroller.text,
                    location: locationcontroller.text,
                    date: datecontroller.text,
                    attachment: attachmentcontroller.text,
                    attachmentname: attachmentcontrollername.text,
                  );
                  context
                      .read<FormBloc>()
                      .add(FormAddedEvent(formsModel: form));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please fill all the fields"),
                  duration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue,
                ));
              }
            });
      }),
    );
  }
}
