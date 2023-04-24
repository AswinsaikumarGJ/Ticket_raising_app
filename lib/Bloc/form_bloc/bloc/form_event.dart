part of 'form_bloc.dart';

abstract class FormEvent extends Equatable {}

class FormLoadEvent extends FormEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FormAddedEvent extends FormEvent {
  FormsModel formsModel;
  FormAddedEvent({
    required this.formsModel,
  });

  @override
  List<Object?> get props => [formsModel];
}

class FormErrorEvent extends FormEvent {
  String? er_msg;
  @override
  // TODO: implement props
  List<Object?> get props => [er_msg];
}
