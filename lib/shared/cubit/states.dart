abstract class TodoStates {}

class TodoInitialState extends TodoStates {}

class ChangeTodoNavBarState extends TodoStates {}

class CreateDatabaseSuccessState extends TodoStates {}

class CreateDatabaseErrorState extends TodoStates {
  final String error;

  CreateDatabaseErrorState(this.error);
}

class InsertIntoDatabaseSuccessState extends TodoStates {}

class InsertIntoDatabaseErrorState extends TodoStates {
  final String error;

  InsertIntoDatabaseErrorState(this.error);
}

class GetTasksSuccessState extends TodoStates {}

class GetTasksErrorState extends TodoStates {
  final String error;

  GetTasksErrorState(this.error);
}

class ChangeDropDownValue extends TodoStates {}

class ChangeHomeTasksListSuccessState extends TodoStates {}

class ChangeHomeTasksListErrorState extends TodoStates {
  final String error;

  ChangeHomeTasksListErrorState(this.error);
}

class ChangeDropDownValueState extends TodoStates {}

class DeleteTaskItemSuccessState extends TodoStates {}

class DeleteTaskItemErrorState extends TodoStates {
  final String error;

  DeleteTaskItemErrorState(this.error);
}

class UpdateTaskItemSuccessState extends TodoStates {}

class UpdateTaskItemErrorState extends TodoStates {
  final String error;

  UpdateTaskItemErrorState(this.error);
}

class ChangeThemeModeState extends TodoStates {}
