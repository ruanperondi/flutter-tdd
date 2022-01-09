import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

Authentication makeRemoteAuthenticatoin() {
  return RemoteAuthentication(
    httpClient: makeHttpAdapter(),
    url: makeApiURL("login"),
  );
}
