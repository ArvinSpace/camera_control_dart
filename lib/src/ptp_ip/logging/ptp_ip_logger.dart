import '../../common/logging/base_camera_control_logger.dart';
import 'topics/event_topics.dart';
import 'topics/ptp_ip_discovery_topic.dart';
import 'topics/transaction_queue_topics.dart';

class PtpIpLogger extends BaseCameraControlLogger
    with TransactionQueueLogger, EventLogger, PtpIpDiscoveryLogger {}
