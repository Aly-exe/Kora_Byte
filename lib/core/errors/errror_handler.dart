import 'package:dio/dio.dart';

// class Failure {
//   final errorMessage;
//   const Failure(this.errorMessage);
// }

class ErrorHandler {
  final error;
  const ErrorHandler(this.error);
  factory ErrorHandler.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorHandler("Connection Time Out");
        // return "Connection Time Out";
      case DioExceptionType.connectionError:
        return ErrorHandler("Connection Error");
      case DioExceptionType.cancel:
        return ErrorHandler("Connection has been canceled");
      case DioExceptionType.receiveTimeout:
        return ErrorHandler("receive Time Out");
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case 201: // no_connection Status code
            return ErrorHandler("No Connection, please try Again");
          case 400: // Bad Request server Rejected request Status code
            return ErrorHandler("Bad request");
          case 401: // Unauthorized Status code
            return ErrorHandler("Unauthorized User");
          case 403: // server reject request Status code
            return ErrorHandler("Server Rejected Request");
          case 404: // not_found Status code
            return ErrorHandler("Resource Not Found");
          case 422: // API , lOGIC ERROR Status code
            return ErrorHandler("Api Logic Error");
          case 500: //  crash in server side
            return ErrorHandler("Server have been Crashed, please try Again");
          default:
            return ErrorHandler("oops error occured ,please try again");
        }
      default:
        return ErrorHandler("oops error occured ,please try again");
    }
  }
}

// class ResponseErrorHandler extends ErrorHandler{
  
//   factory ResponseErrorHandler.fromDioException(DioException error){
//     switch (error.response!.statusCode) {
//       case 201:
//         return ErrorHandler("No Connection , please Try again");
//       default:
//         return ResponseErrorHandler("");
//     }
//   }
// }