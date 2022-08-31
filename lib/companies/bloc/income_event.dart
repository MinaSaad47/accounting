part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

class IncomeCreateRequested extends IncomeEvent {
  final IncomeModel income;
  final CompanyModel company;

  const IncomeCreateRequested(this.income, this.company);
  @override
  List<Object> get props => [income, company];
}

class IncomeGetRequested extends IncomeEvent {
  final int? empolyeeId, companyId;

  const IncomeGetRequested({this.empolyeeId, this.companyId});
}

class IncomeDeleteRequested extends IncomeEvent {
  final int id;

  const IncomeDeleteRequested(this.id);
}
