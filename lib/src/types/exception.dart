// Created by Nejc Skerjanc, copyright © 2023 ZeroPass. All rights reserved.

class DMRTDException implements Exception {
  final String message;
  String get exceptionName => 'DMRTDException';

  DMRTDException(this.message);
  @override
  String toString() {
    return '$exceptionName: $message';
  }
}
