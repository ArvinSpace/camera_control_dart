import '../../common/discovery/discovery_handle.dart';

class PtpIpDiscoveryHandle extends DiscoveryHandle {
  final String address;

  const PtpIpDiscoveryHandle({
    required this.address,
    required super.id,
    required super.model,
  });
}
