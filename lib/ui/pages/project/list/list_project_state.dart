abstract class ListProjectState {}

class InitialListProjectState extends ListProjectState {}

class ListProjectRefreshedState extends ListProjectState {
  List<String>  dataSource;
  ListProjectRefreshedState(this.dataSource);
}

class ListProjectLoadedState extends ListProjectState {
  List<String>  dataSource;
  ListProjectLoadedState(this.dataSource);
}
