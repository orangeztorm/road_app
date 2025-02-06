import 'package:road_app/cores/__cores.dart';
import 'package:flutter/material.dart';

class InAppNotification extends StatefulWidget {
  const InAppNotification({
    super.key,
    required this.message,
    required this.title,
  });

  final String message;
  final String title;

  @override
  State<InAppNotification> createState() => _InAppNotificationState();
}

class _InAppNotificationState extends State<InAppNotification> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: sw(100),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.kcWhite,
            border: Border.all(
              color: AppColor.kcGrey600,
              width: 1.4,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(sr(100)),
                child: const ImageWidget(
                  imageUrl: Images.beamLogo,
                  imageTypes: ImageTypes.asset,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      widget.title,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                      widget.message,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getData() {
    // final GetTransactionCubit getTransactionCubit = getIt();
    // final accountType = getTransactionCubit.state.accountType;
    // getTransactionCubit.reset();
    // getTransactionCubit.onAccountTypeChanged(accountType);
    // getIt<GetTransactionHistoryBloc>()
    //     .add(GetTransactionHistory(getTransactionCubit.state));
    // getIt<UserBloc>().add(const GetUser(refresh: true));
    // if (accountType != null) {
    //   getIt<GetAccountBalanceBloc>()
    //       .add(GetAccountBalance(GetAccountBalanceParam(accountType)));
    // }
  }
}
