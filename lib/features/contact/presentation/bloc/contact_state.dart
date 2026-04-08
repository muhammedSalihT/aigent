import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  final String service;
  const ContactState(this.service);
  @override
  List<Object?> get props => [service];
}

class ContactInitial extends ContactState {
  const ContactInitial({String service = 'App Development'}) : super(service);
}

class ContactLoading extends ContactState {
  const ContactLoading(super.service);
}

class ContactSuccess extends ContactState {
  const ContactSuccess({String service = 'App Development'}) : super(service);
}

class ContactFailure extends ContactState {
  final String message;
  const ContactFailure(this.message, String service) : super(service);
  @override
  List<Object?> get props => [message, service];
}
