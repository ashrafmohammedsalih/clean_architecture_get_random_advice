import 'package:get_advices/application/pages/advice/cubit/advice_cubit.dart';
import 'package:get_advices/data/datasources/advice_remote_datasource.dart';
import 'package:get_advices/data/repositories/advice_repo_imp.dart';
import 'package:get_advices/domain/repositories/advice_repo.dart';
import 'package:get_advices/domain/usecases/advice_usecases.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';



final sl =GetIt.I;

Future<void> init ()async{

//? Application Layer
  sl.registerFactory(() => AdviceCubit(advaiceUseCases: sl()));

 //? Domain Layer
 sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

 //? Data Layer
 sl.registerFactory<AdviceRepo>(() => AdviceRepoImpl(adviceRemoteDatasource: sl()));
 sl.registerFactory<AdviceRemoteDatasource>(() => AdviceRemoteDatasourceImpl(client: sl()));


 //? externs
 sl.registerFactory(() => http.Client());

 
}