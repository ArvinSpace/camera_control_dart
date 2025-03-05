import '../../../common/logging/base_camera_control_logger.dart';
import '../../../common/logging/log_level.dart';
import '../../../common/logging/logger_channel.dart';
import '../../../common/logging/logger_topic.dart';

class DiscoveryChannel extends LoggerChannel {
  const DiscoveryChannel();
}

class PtpIpDiscoveryTopic extends LoggerTopic<DiscoveryChannel> {
  const PtpIpDiscoveryTopic({super.level = LogLevel.info});
}

mixin PtpIpDiscoveryLogger on BaseCameraControlLogger {
  void logCameraAlive(String uniqueDeviceName) {
    whenTopicEnabled<PtpIpDiscoveryTopic>((topic) {
      log(topic.level, 'Camera alive: $uniqueDeviceName');
    });
  }

  void logCameraByeBye(String uniqueDeviceName) {
    whenTopicEnabled<PtpIpDiscoveryTopic>((topic) {
      log(topic.level, 'Camera byeBye: $uniqueDeviceName');
    });
  }
}
