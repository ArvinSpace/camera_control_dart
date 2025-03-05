import 'package:equatable/equatable.dart';

class UpnpDeviceDescription extends Equatable {
  final String address;
  final String friendlyName;
  final String modelName;
  final String uniqueDeviceName;

  const UpnpDeviceDescription({
    required this.address,
    required this.friendlyName,
    required this.modelName,
    required this.uniqueDeviceName,
  });

  @override
  List<Object?> get props => [
        address,
        friendlyName,
        modelName,
        uniqueDeviceName,
      ];
}
