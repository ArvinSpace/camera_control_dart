import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

import '../../../common/logging/base_camera_control_logger.dart';
import '../../../common/logging/log_level.dart';
import '../../../common/logging/logger_channel.dart';
import '../../../common/logging/logger_topic.dart';
import '../../../eos_ptp_ip/models/ptp_packet.dart';
import '../../../eos_ptp_ip/responses/ptp_response.dart';

class TransactionQueueChannel extends LoggerChannel {
  const TransactionQueueChannel();
}

class PtpTransactionQueueTopic extends LoggerTopic<TransactionQueueChannel> {
  const PtpTransactionQueueTopic({super.level = LogLevel.info});
}

mixin TransactionQueueLogger on BaseCameraControlLogger {
  void logNextRequest(int operationCode, PtpPacket packet) {
    whenTopicEnabled<PtpTransactionQueueTopic>((topic) {
      log<TransactionQueueChannel>(
        topic.level,
        'Sending request ${operationCode.asHex(padLeft: 4)} with data: ${packet.data.dumpAsHex()}',
      );
    });
  }

  void logDataStart(PtpPacket packet) {
    whenTopicEnabled<PtpTransactionQueueTopic>((topic) {
      log<TransactionQueueChannel>(topic.level,
          'Sending dataStart packet with payload: ${packet.data.dumpAsHex()}');
    });
  }

  void logDataEnd(PtpPacket packet) {
    whenTopicEnabled<PtpTransactionQueueTopic>((topic) {
      log<TransactionQueueChannel>(topic.level,
          'Sending dataEnd packet with paylaod: ${packet.data.dumpAsHex()}');
    });
  }

  void logCompleteTransaction(PtpResponse response) {
    whenTopicEnabled<PtpTransactionQueueTopic>((topic) {
      log<TransactionQueueChannel>(
          topic.level, 'Completing transaction with response: $response');
    });
  }
}
