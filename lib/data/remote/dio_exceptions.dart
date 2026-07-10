import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptions implements Exception {
  final String message;

  DioExceptions.fromDioError(DioException dioError)
      : message = _extractMessage(dioError) {
    debugPrint('DioExceptions created with message: $message');
  }

  static String _extractMessage(DioException error) {
    debugPrint(
        'Extracting message from DioException: ${error.type}, ${error.message}');
    // First, attempt to get the backend 'detail' field
    if (error.response?.data != null) {
      final data = error.response!.data;
      debugPrint('Error response data: $data');
      if (data is Map<String, dynamic>) {
        if (data.containsKey('detail')) {
          return data['detail'].toString();
        }
        // fallback to other backend fields
        if (data.containsKey('message')) {
          return data['message'].toString();
        }
        if (data.containsKey('error')) {
          return data['error'].toString();
        }
      }
      // if response data is a string or other type
      return data.toString();
    }
    // Next, use Dio's own error message if available
    if (error.message != null && error.message!.isNotEmpty) {
      return error.message!;
    }
    // Generic fallback
    return "An unknown error occurred. Please contact support.";
  }

  @override
  String toString() {
    debugPrint('DioExceptions toString called');
    return message;
  }
}
