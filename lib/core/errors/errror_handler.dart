import 'package:dio/dio.dart';

// class Failure {
//   final errorMessage;
//   const Failure(this.errorMessage);
// }

class Failure {
  final error;
  const Failure(this.error);
  static String errorHandler(DioException error){
      switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Time Out";
      case DioExceptionType.connectionError:
        return "Connection Error";
      case DioExceptionType.cancel:
        return "Connection has been canceled";
      case DioExceptionType.receiveTimeout:
        return "receive Time Out";
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case 201: // no_connection Status code
            return "No Connection, please try Again";
          case 400: // Bad Request server Rejected request Status code
            return "Bad request";
          case 401: // Unauthorized Status code
            return "Unauthorized User";
          case 403: // server reject request Status code
            return "Server Rejected Request";
          case 404: // not_found Status code
            return "Resource Not Found";
          case 422: // API , lOGIC ERROR Status code
            return "Api Logic Error";
          case 500: //  crash in server side
            return "Server have been Crashed, please try Again";
          default:
            return "oops error occured ,please try again";
        }
      default:
        return "oops error occured ,please try again";
    }
  
  } 
  // factory ErrorHandler.fromDioException(DioException error) {
  //   switch (error.type) {
  //     case DioExceptionType.connectionTimeout:
  //       return ErrorHandler("Connection Time Out");
  //       // return "Connection Time Out";
  //     case DioExceptionType.connectionError:
  //       return ErrorHandler("Connection Error");
  //     case DioExceptionType.cancel:
  //       return ErrorHandler("Connection has been canceled");
  //     case DioExceptionType.receiveTimeout:
  //       return ErrorHandler("receive Time Out");
  //     case DioExceptionType.badResponse:
  //       switch (error.response!.statusCode) {
  //         case 201: // no_connection Status code
  //           return ErrorHandler("No Connection, please try Again");
  //         case 400: // Bad Request server Rejected request Status code
  //           return ErrorHandler("Bad request");
  //         case 401: // Unauthorized Status code
  //           return ErrorHandler("Unauthorized User");
  //         case 403: // server reject request Status code
  //           return ErrorHandler("Server Rejected Request");
  //         case 404: // not_found Status code
  //           return ErrorHandler("Resource Not Found");
  //         case 422: // API , lOGIC ERROR Status code
  //           return ErrorHandler("Api Logic Error");
  //         case 500: //  crash in server side
  //           return ErrorHandler("Server have been Crashed, please try Again");
  //         default:
  //           return ErrorHandler("oops error occured ,please try again");
  //       }
  //     default:
  //       return ErrorHandler("oops error occured ,please try again");
  //   }
  // }
}