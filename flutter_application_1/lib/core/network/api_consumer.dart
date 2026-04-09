abstract class ApiConsumer {

Future<dynamic> get( String path, {
  
  Object? data,
  Map<String,dynamic>? queryparameter,
   bool isformdata=false,
});
  

Future<dynamic> post( String path,  {
  Object? data,
  Map<String,dynamic>? queryparameter,
  bool isformdata=false,
  });


Future<dynamic> patch(   String path, {
  Object? data,
  Map<String,dynamic>? queryparameter,
   bool isformdata=false,
  });

Future<dynamic> delete(  String path, {
   Object? data,
  Map<String,dynamic>? queryparameter,
 bool isformdata=false,
});

} 