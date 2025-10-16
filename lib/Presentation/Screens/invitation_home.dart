import 'package:flutter/material.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';
import 'package:weeding_invitation/Core/Constants/invitation_content.dart';
import 'package:weeding_invitation/Core/Utilities/invitation_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeding_invitation/Logic/Cubit/invitation_cubit.dart';
import 'package:weeding_invitation/Logic/Cubit/invitation_state.dart';
import 'package:weeding_invitation/Presentation/Widgets/deveoped_by.dart';
import 'package:weeding_invitation/Presentation/Widgets/header_section.dart';
import 'package:weeding_invitation/Presentation/Widgets/event_info_section.dart';
import 'package:weeding_invitation/Presentation/Widgets/rsvp_form_section.dart';
import 'package:weeding_invitation/Presentation/Widgets/closing_section.dart';

class InvitationHome extends StatefulWidget {
  const InvitationHome({super.key});

  @override
  State<InvitationHome> createState() => _WeddingInvitationPageState();
}

class _WeddingInvitationPageState extends State<InvitationHome> {
  final wedding = InvitationContent.coupleData;

  @override
  void initState() {
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<InvitationCubit, InvitationState>(
      listener: (context, state) {
        if (state is InvitationLoading) {
          InvitationHelper.showLoadingDialog(context);
        }

        if (state is InvitationError) {
          InvitationHelper.hideDialog(context);
          InvitationHelper.showErrorBar(
            context,
            message: state.message,
          );
        }

        if (state is InvitationDone) {
          InvitationHelper.hideDialog(context);
          InvitationHelper.showDoneDialog(context);
          Future.delayed(const Duration(seconds: 3), () {
            InvitationHelper.hideDialog(context);
          });
        }
      },
      
      builder: (context, state) {
        return Scaffold(
          backgroundColor: InvitationColors.backgroundSecondary,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Section 
                HeaderSection(),

                // Event Info Section 
                EventInfoSection(
                  onOpenLocation: () => context.read<InvitationCubit>().openMaps(context, wedding.mapLink),
                ),
                
                // RSVP Form Section 
                RSVPFormSection(
                  onSubmit: (guest) => context.read<InvitationCubit>().submitGuestRSVP(context, guest)
                ),

                // Closing Section
                ClosingSection(
                  wedding: wedding,
                  onAddToCalendar: () => context.read<InvitationCubit>().openCalendar(
                    context,
                    title: 'Asaad & Ward Wedding',
                    start: '20251025T093000Z',
                    end: '20251025T140000Z',
                    location: '${wedding.church}, ${wedding.city}, ${wedding.state}',
                    details: wedding.details,
                  ),
                ),

                DevelopedBy(
                  name: 'Afraim Shokralla (Evra)',
                  email: 'afraimevraa@gmail.com',
                  phoneNumber: '01202597737',
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
