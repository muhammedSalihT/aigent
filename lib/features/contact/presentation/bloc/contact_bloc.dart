import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  // Hardcoded email destination
  static const String _destinationEmail = 'contact@aigent_softwares.com';

  ContactBloc() : super(const ContactInitial()) {
    on<ContactFormSubmitted>(_onSubmitted);
    on<ContactFormReset>(_onReset);
    on<ContactServiceChanged>(_onServiceChanged);
  }

  void _onServiceChanged(ContactServiceChanged event, Emitter<ContactState> emit) {
    emit(ContactInitial(service: event.service));
  }

  Future<void> _onSubmitted(
    ContactFormSubmitted event,
    Emitter<ContactState> emit,
  ) async {
    final currentService = state.service;
    emit(ContactLoading(currentService));
    try {
      // Simulate network delay (hardcoded CMS — would be replaced by real API)
      await Future.delayed(const Duration(seconds: 2));

      // In production: send to $_destinationEmail via email service/API
      // For now, hardcoded success
      // ignore: avoid_print
      print('Contact form sent to: $_destinationEmail');
      // ignore: avoid_print
      print('From: ${event.name} <${event.email}>');
      // ignore: avoid_print
      print('Service: ${event.service}');
      // ignore: avoid_print
      print('Message: ${event.message}');

      emit(ContactSuccess(service: currentService));
    } catch (e) {
      emit(ContactFailure('Failed to send. Please email us directly at $_destinationEmail', currentService));
    }
  }

  void _onReset(ContactFormReset event, Emitter<ContactState> emit) {
    emit(ContactInitial(service: state.service));
  }
}
