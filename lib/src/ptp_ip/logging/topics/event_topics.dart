import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';

import '../../../common/logging/base_camera_control_logger.dart';
import '../../../common/logging/log_level.dart';
import '../../../common/logging/logger_channel.dart';
import '../../../common/logging/logger_topic.dart';

class RawEventChannel extends LoggerChannel {
  const RawEventChannel();
}

class PtpRawEventLoggerTopic extends LoggerTopic<RawEventChannel> {
  final bool dumpDataAsValidList;
  final bool dumpDataWithLineNumbers;

  const PtpRawEventLoggerTopic({
    super.level = LogLevel.info,
    this.dumpDataAsValidList = false,
    this.dumpDataWithLineNumbers = false,
  });
}

class PropertyChangedChannel extends LoggerChannel {
  const PropertyChangedChannel();
}

class PtpPropertyChangedLoggerTopic
    extends LoggerTopic<PropertyChangedChannel> {
  final List<int> propsWhitelist;
  final List<int> propsBlackList;

  const PtpPropertyChangedLoggerTopic({
    super.level = LogLevel.info,
    this.propsWhitelist = const [],
    this.propsBlackList = const [],
  });
}

mixin EventLogger on BaseCameraControlLogger {
  void logRawEvent(int eventCode, Uint8List data) {
    final config = getTopic<PtpRawEventLoggerTopic>();
    if (config != null) {
      log<RawEventChannel>(
        config.level,
        'event ${eventCode.asHex()} occured with data:${data.dumpAsHex(
          asValidList: config.dumpDataAsValidList,
          withLineNumbers: config.dumpDataWithLineNumbers,
        )}',
      );
    }
  }

  void logPropertyChangedEvent(int propertyCode, Uint8List data) {
    final config = getTopic<PtpPropertyChangedLoggerTopic>();
    if (config != null) {
      if (config.propsBlackList.contains(propertyCode)) {
        return;
      }

      if (config.propsWhitelist.isNotEmpty &&
          !config.propsWhitelist.contains(propertyCode)) {
        return;
      }

      log<PropertyChangedChannel>(
        config.level,
        'propertyChanged: ${propertyCode.asHex()} changed to:${data.dumpAsHex()}',
      );
    }
  }
}
