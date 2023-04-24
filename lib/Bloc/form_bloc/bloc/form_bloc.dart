import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ticket_raising_app/Models/forms_model.dart';
import 'package:ticket_raising_app/Repository/forms_repository.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  final FormRepository formRepository;

  FormBloc({required this.formRepository}) : super(FormLoadingState()) {
    on(_onGetForm);
    on(_onAddForm);
  }

  _onGetForm(FormLoadEvent event, Emitter<FormsState> emit) {
    emit(FormLoadingState());

    try {
      final data = formRepository.getTicketsDetails();
      emit(FormLoadedState(formsModel: data));
    } catch (e) {
      emit(FormErrorState(er_msg: e.toString()));
    }
  }

  _onAddForm(FormAddedEvent event, Emitter<FormsState> emit) async {
    try {
      final postData = await formRepository.createTickets(event.formsModel);
      emit(FormAddedState());
      final data = formRepository.getTicketsDetails();
      emit(FormLoadedState(formsModel: data));
    } catch (e) {
      emit(FormErrorState(er_msg: e.toString()));
    }
  }
}
