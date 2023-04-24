part of 'form_bloc.dart';

abstract class FormsState extends Equatable {
  const FormsState();
}

class FormLoadingState extends FormsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FormLoadedState extends FormsState {
  Stream<List<FormsModel>> formsModel;
  FormLoadedState({
    required this.formsModel,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [formsModel];
}

class FormAddedState extends FormsState {
  @override
  List<Object?> get props => [];
}

class FormErrorState extends FormsState {
  String? er_msg;
  FormErrorState({
    this.er_msg,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [er_msg];
}
