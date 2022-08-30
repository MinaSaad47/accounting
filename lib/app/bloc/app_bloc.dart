import 'package:accounting/common/cached_repository.dart';
import 'package:bloc/bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final CachedRepository _cachedRepository;
  AppBloc({required CachedRepository cachedRepository})
      : _cachedRepository = cachedRepository,
        super(AppInitial()) {
    on<AppLoggedout>(_onAppLoggedout);
  }

  Future _onAppLoggedout(AppLoggedout event, Emitter<AppState> emit) async {
    _cachedRepository.token = null;
    emit(AppLogout());
  }
}
