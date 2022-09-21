import 'package:awesome_flutter_extensions/all.dart';
import 'package:enviro_bank/features/authentication/controller/auth_controller.dart';
import 'package:enviro_bank/features/loan/controller/loan_controller.dart';
import 'package:enviro_bank/features/loan/model/loan_application_model.dart';
import 'package:enviro_bank/features/loan/model/loan_state.dart';
import 'package:enviro_bank/features/loan/view/loan_form.dart';
import 'package:enviro_bank/utils/app_routes.dart';
import 'package:enviro_bank/utils/constants.dart';
import 'package:enviro_bank/widgets/LoadingButton.dart';
import 'package:enviro_bank/widgets/forms/forms.dart';
import 'package:enviro_bank/widgets/glassish_container.dart';
import 'package:enviro_bank/widgets/snack_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authControllerProvider.notifier).getUser();
    final scrollController = useScrollController();
    final loanController = ref.watch(loanControllerProvider);
    final loanControllerNotif = ref.watch(loanControllerProvider.notifier);
    final formEnabled = useState(true);
    final startApplication = useState(false);
    final applicationSubmited = useState(false);

    ref.listen(loanControllerProvider, (prev, next) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent + 150);
      if (next is LoanStateSuccess) {
        if (next.applicationResponse.warnings.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackResponse.warning(
                context: context,
                message: next.applicationResponse.warnings.join("\n"),
                duration: const Duration(seconds: 10)),
          );
        }
      } else if (next is LoanStateFail) {
        formEnabled.value = false;
      } else if (next is LoanStateError) {
        formEnabled.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackResponse.error(context: context, message: next.error));
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: context.height,
            width: context.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  //colorFilter: ColorFilter.mode(SHColors.primaryVariant.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage(
                    Strings.BgImage,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Container(
              height: context.height,
              width: context.width,
              color: Colors.black54,
            ),
          ),
          Column(
            children: [
              PreferredSize(
                preferredSize: Size(context.width, kToolbarHeight + 24),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 56, left: 16, right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi there!',
                              style: context.h5,
                            ),
                            Text(
                              user?.emailAddress ?? "",
                              style: context.bodyText2.copyWith(
                                  color: context.iconTheme.color
                                      ?.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          context.go(AppRoutes.PROFILE_SCREEN);
                        },
                        child: GlassishContainer(
                          height: 48,
                          width: 48,
                          borderRadius: BorderRadius.circular(50),
                          color: context.primaryColorLight,
                          margin: EdgeInsets.zero,
                          child: Icon(
                            Icons.person,
                            color: context.iconTheme.color ?? Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 200),
                  children: [
                    ChatBubble(
                      key: const Key('intro-bubble'),
                      isRounded: false,
                      isMe: false,
                      username: Strings.appName,
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(Strings.introMessage),
                          const SizedBox(
                            height: 16,
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: startApplication.value ? 0.3 : 1,
                            child: LoadingButton(
                              key: const Key("apply-btn"),
                              title: 'Apply',
                              onTap: () {
                                if (!startApplication.value) {
                                  startApplication.value = true;
                                }
                              },
                              radius: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: startApplication.value ? 1 : 0,
                      child: Visibility(
                        visible: startApplication.value,
                        child: const ChatBubble(
                          key: Key('me-apply-bubble'),
                          isRounded: false,
                          isMe: true,
                          username: 'Me',
                          content: Text("Apply"),
                        ),
                      ),
                    ),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 400),
                      scale: startApplication.value &&
                              loanController is! LoanStateSuccess
                          ? 1
                          : 0,
                      child: Visibility(
                        visible: startApplication.value &&
                            loanController is! LoanStateSuccess,
                        child: const ChatBubble(
                          key: Key('start-application-message-bubble'),
                          isRounded: false,
                          isMe: false,
                          username: Strings.appName,
                          content: Text(Strings.startApplicationMessage),
                        ),
                      ),
                    ),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 600),
                      scale: startApplication.value ? 1 : 0,
                      child: Visibility(
                        visible: startApplication.value,
                        child: ChatBubble(
                          key: const Key('loan-form-bubble'),
                          isRounded: true,
                          isMe: false,
                          username: Strings.appName,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LoanApplicationForm(
                                enabled: formEnabled.value,
                                onSubmit: (form) async {
                                  formEnabled.value = false;
                                  applicationSubmited.value = true;
                                  await ref
                                      .read(loanControllerProvider.notifier)
                                      .apply(
                                        LoanApplication(
                                          double.parse(Forms.getFormField(
                                                  form, Strings.loanAmountField)
                                              .toString()),
                                          BankAccount(
                                              Forms.getFormField(form,
                                                  Strings.accountNumberField),
                                              Forms.getFormField(
                                                  form, Strings.bankNameField),
                                              "code"),
                                          DateFormat("y-MM-dd").format(
                                              Forms.getFormField(form,
                                                  Strings.collectionDateField)),
                                          Forms.getFormField(
                                              form, Strings.nameField),
                                          Forms.getFormField(
                                              form, Strings.surnameField),
                                          Forms.getFormField(
                                              form, Strings.idNumberField),
                                        ),
                                      );
                                },
                              ),
                              Visibility(
                                visible: loanController is! LoanStateSuccess &&
                                    loanController is! LoanStateFail,
                                child: TextButton(
                                  onPressed: () {
                                    startApplication.value = false;
                                    applicationSubmited.value = false;
                                  },
                                  child: Text(
                                    Strings.cancel,
                                    style: context.subtitle2.copyWith(
                                        color: context.colorScheme.secondary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: applicationSubmited.value && startApplication.value
                          ? 1
                          : 0,
                      child: Visibility(
                        visible:
                            applicationSubmited.value && startApplication.value,
                        child: const ChatBubble(
                          key: Key('me-submitted-bubble'),
                          isRounded: false,
                          isMe: true,
                          username: 'Me',
                          content: Text("Submitted"),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: loanController is LoanStateSuccess,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 2000),
                        opacity: loanController is LoanStateSuccess ? 1 : 0,
                        child: ChatBubble(
                          key: const Key('success-gif-bubble'),
                          isRounded: false,
                          isMe: false,
                          username: Strings.appName,
                          content: Lottie.asset(
                            'assets/animations/moneybox.json',
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: loanController is LoanStateFail ? 1 : 0,
                      child: Visibility(
                        visible: loanController is LoanStateFail,
                        child: ChatBubble(
                          key: const Key('fail-gif-bubble'),
                          isRounded: false,
                          isMe: false,
                          username: Strings.appName,
                          content: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Lottie.asset(
                                  'assets/animations/fail.json',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                if (loanController.props.isNotEmpty &&
                                    loanController.props.length > 1 &&
                                    loanController.props[1]
                                        is LoanApplicationResponse)
                                  Column(
                                    children: [
                                      Text(
                                        "Application Failed!",
                                        style: context.h6.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text((loanController.props[1]
                                              as LoanApplicationResponse)
                                          .errors
                                          .join("\n")),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 16,
                                ),
                                LoadingButton(
                                    key: const Key("retry-btn"),
                                    title: "Try again",
                                    onTap: () {
                                      //showFailBubble.value = false;
                                      loanControllerNotif.resetState();
                                      formEnabled.value = true;
                                      applicationSubmited.value = false;
                                    }),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 800),
                      opacity: loanController is LoanStateSuccess ? 1 : 0,
                      child: Visibility(
                        visible: loanController is LoanStateSuccess,
                        child: ChatBubble(
                          key: const Key('success-msg-bubble'),
                          isRounded: true,
                          isMe: false,
                          username: Strings.appName,
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (loanController.props.isNotEmpty &&
                                  loanController.props[0] is LoanApplication)
                                Text(
                                    "Congratulations ${(loanController.props[0] as LoanApplication).firstName} ${(loanController.props[0] as LoanApplication).lastName}! "
                                    "Your loan for ${NumberFormat.currency(symbol: "R").format((loanController.props[0] as LoanApplication).amount)} has been approved."),
                              const SizedBox(
                                height: 16,
                              ),
                              LoadingButton(
                                  key: const Key("done-btn"),
                                  title: Strings.done,
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    formEnabled.value = true;
                                    startApplication.value = false;
                                    applicationSubmited.value = false;
                                    loanControllerNotif.resetState();
                                  }),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.isRounded,
    required this.isMe,
    required this.username,
    required this.content,
  }) : super(key: key);
  final bool isRounded;
  final bool isMe;
  final String username;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GlassishContainer(
          borderRadius: isRounded
              ? BorderRadius.circular(16)
              : BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomRight: Radius.circular(isMe ? 0 : 16),
                  bottomLeft: Radius.circular(isMe ? 16 : 0),
                ),
          margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
          constraints: BoxConstraints(maxWidth: context.width * 0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !isRounded,
                  child: Text(
                    username,
                    style: context.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? context.colorScheme.tertiary
                            : context.colorScheme.secondary,
                        fontSize: 12),
                  ),
                ),
                Visibility(
                  visible: !isRounded,
                  child: const SizedBox(
                    height: 4,
                  ),
                ),
                content
              ],
            ),
          )),
    );
  }
}
