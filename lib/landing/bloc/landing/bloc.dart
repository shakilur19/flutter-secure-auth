import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import '../../data/landing_repository.dart';
import 'event.dart';
import 'state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final LandingRepository _repository;
  LandingBloc({required LandingRepository repository}) : _repository = repository,super(LandingState()){
    on<GetLandingNavigationEvent>(_getNavigation);
  }

  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  void _getNavigation(GetLandingNavigationEvent event,Emitter<LandingState> emit) async {
    emit(state.clone(
      status: FormzSubmissionStatus.success,
    ));
  }

  Future<LandingState> init() async {
    return state.clone();
  }
}
