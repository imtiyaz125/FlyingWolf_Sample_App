import 'package:bluestack_assignment/data/Providers/HomeProvider.dart';
import 'package:bluestack_assignment/data/Repository/HomeRepository.dart';
import 'package:injector/injector.dart';

import 'ApiConstants/ApiService.dart';

void setupDependencyInjections() async {
  Injector injector = Injector.appInstance;
  injector.registerSingleton<ApiService>((_) => ApiService());

  _providerDependencyInjections(injector);
  _repositoryDependencyInjections(injector);
}

/*PROVIDERS*/
void _providerDependencyInjections(Injector injector) {
  injector.registerDependency<HomeProvider>((Injector injector) {
    var api = injector.getDependency<ApiService>();
    return HomeProvider(api: api);
  });

}


/*REPOSITORY*/
void _repositoryDependencyInjections(Injector injector) {
  injector.registerDependency<HomeRepository>((Injector injector) {
    var provider = injector.getDependency<HomeProvider>();
    return HomeRepository(provider: provider);
  });
}

