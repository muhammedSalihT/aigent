import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
  @override
  List<Object?> get props => [];
}

class ContactFormSubmitted extends ContactEvent {
  final String name;
  final String email;
  final String message;
  final String service;

  const ContactFormSubmitted({
    required this.name,
    required this.email,
    required this.message,
    required this.service,
  });

  @override
  List<Object?> get props => [name, email, message, service];
}

class ContactServiceChanged extends ContactEvent {
  final String service;
  const ContactServiceChanged(this.service);
  
  @override
  List<Object?> get props => [service];
}

class ContactFormReset extends ContactEvent {
  const ContactFormReset();
}
