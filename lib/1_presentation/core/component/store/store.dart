import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class StoreSimpleInfoRow extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String address;

  const StoreSimpleInfoRow({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.network(
            profileImageUrl,
            fit: BoxFit.fill,
            width: DS.getSpace().large,
            height: DS.getSpace().large,
          ),
        ),
        DS.getSpace().hTiny,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: DS
                    .getTextStyle()
                    .paragraph2
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DS.getSpace().vXXTiny,
              Text(
                address,
                overflow: TextOverflow.ellipsis,
                style: DS.getTextStyle().caption1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
