import 'package:aigent_softwares/shared/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/bloc/scroll_cubit.dart';
import '../../../../shared/widgets/footer_widget.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../../shared/widgets/section_header.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ScrollController _scrollController = ScrollController();
  late ContactBloc _contactBloc;
  late ScrollCubit _scrollCubit;

  @override
  void initState() {
    super.initState();
    _contactBloc = sl<ContactBloc>();
    _scrollCubit = ScrollCubit();
    _scrollController.addListener(() {
      _scrollCubit.checkScroll(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return BlocProvider.value(
      value: _contactBloc,
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Stack(
          children: [
            WebSmoothScroll(
              controller: _scrollController,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(height: 120.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24.w : 80.w),
                      child: const SectionHeader(
                        tag: '📬 Contact Us',
                        title: 'Let\'s Build Something Great',
                        subtitle:
                            'Tell us about your project and we\'ll get back to you within 24 hours.',
                      ),
                    ),
                    SizedBox(height: 60.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24.w : 80.w),
                      child: isMobile
                          ? Column(
                              children: [
                                _ContactForm(),
                                SizedBox(height: 48.h),
                                _ContactInfo(),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 3, child: _ContactForm()),
                                SizedBox(width: 60.w),
                                Expanded(flex: 2, child: _ContactInfo()),
                              ],
                            ),
                    ),
                    SizedBox(height: 80.h),
                    const FooterWidget(),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: BlocBuilder<ScrollCubit, bool>(
                  bloc: _scrollCubit,
                  builder: (context, scrolled) =>
                      NavBarWidget(scrolled: scrolled ?? false),
                )),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _services = [
    'App Development',
    'Web Development',
    'AI Workflow Agents',
    'General Inquiry',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context, String? currentService) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ContactBloc>().add(ContactFormSubmitted(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            message: _messageController.text.trim(),
            service: currentService ?? _services.first,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactSuccess) {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      },
      builder: (context, state) {
        if (state is ContactSuccess) {
          return _SuccessCard()
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.9, 0.9));
        }

        // Ensure state.service is initialized
        String? selectedService;
        if (state is ContactInitial) {
          selectedService = _services.first;
        } else if (state is ContactFormSubmitted) {
          selectedService = state.service;
        } else if (state is ContactLoading) {
          selectedService = state.service;
        } else if (state is ContactFailure) {
          selectedService = state.service ?? _services.first;
        } else if (state is ContactSuccess) {
          selectedService = _services.first;
        } else
          selectedService = state.service;

        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(36.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Us a Message',
                    style: AppTypography.h3.copyWith(color: Colors.white)),
                SizedBox(height: 28.h),
                _InputField(
                  controller: _nameController,
                  label: 'Your Name',
                  hint: 'John Smith',
                  icon: Icons.person_outline_rounded,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Name is required' : null,
                ),
                SizedBox(height: 16.h),
                _InputField(
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'john@company.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email is required';
                    final regex =
                        RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
                    if (!regex.hasMatch(v)) return 'Enter a valid email';
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // Service selector
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service Interested In',
                        style: AppTypography.labelMedium
                            .copyWith(color: AppColors.textMuted)),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.darkBackground,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _services.contains(selectedService)
                              ? selectedService
                              : _services.first,
                          isExpanded: true,
                          dropdownColor: AppColors.surfaceCard,
                          style: AppTypography.bodySmall
                              .copyWith(color: Colors.white),
                          items: _services
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              context
                                  .read<ContactBloc>()
                                  .add(ContactServiceChanged(v));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _InputField(
                  controller: _messageController,
                  label: 'Your Message',
                  hint: 'Tell us about your project, goals, and timeline...',
                  icon: Icons.message_outlined,
                  maxLines: 5,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Message is required' : null,
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: state is ContactLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryPurple))
                      : GradientButton(
                          label: 'Send Message',
                          onPressed: () => _submit(context, selectedService),
                          icon: Icons.send_rounded,
                        ),
                ),
                if (state is ContactFailure)
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Text(state.message,
                        style: AppTypography.caption
                            .copyWith(color: Colors.red.shade400)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                AppTypography.labelMedium.copyWith(color: AppColors.textMuted)),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: AppTypography.bodySmall.copyWith(color: Colors.white),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.caption,
            prefixIcon: maxLines == 1
                ? Icon(icon, color: AppColors.textMuted, size: 18)
                : null,
            filled: true,
            fillColor: AppColors.darkBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.borderSubtle),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.borderSubtle),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide(color: AppColors.primaryPurple, width: 2.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.red, width: 2.w),
            ),
            errorStyle:
                AppTypography.caption.copyWith(color: Colors.red.shade400),
          ),
        ),
      ],
    );
  }
}

class _SuccessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(48.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.check_rounded, color: Colors.white, size: 40),
          ),
          SizedBox(height: 24.h),
          Text('Message Sent! 🎉',
              style: AppTypography.h2.copyWith(color: Colors.white)),
          SizedBox(height: 12.h),
          Text(
            'Thank you for reaching out. We\'ll review your project and get back to you within 24 hours.',
            style: AppTypography.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28.h),
          GradientButton(
            label: 'Send Another',
            variant: ButtonVariant.outlined,
            onPressed: () =>
                context.read<ContactBloc>().add(const ContactFormReset()),
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Information',
            style: AppTypography.h3.copyWith(color: Colors.white)),
        SizedBox(height: 8.h),
        Text('Prefer to reach out directly? Here\'s how to find us.',
            style: AppTypography.bodySmall),
        SizedBox(height: 32.h),
        const _InfoItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: AppConstants.contactEmail),
        SizedBox(height: 20.h),
        const _InfoItem(
            icon: Icons.language_rounded,
            title: 'Website',
            value: AppConstants.websiteUrl),
        SizedBox(height: 20.h),
        const _InfoItem(
            icon: Icons.schedule_rounded,
            title: 'Response Time',
            value: 'Within 24 hours'),
        SizedBox(height: 20.h),
        const _InfoItem(
            icon: Icons.location_on_outlined,
            title: 'Serving',
            value: 'Clients Worldwide'),
        SizedBox(height: 40.h),
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryPurple.withOpacity(0.15),
                AppColors.electricBlue.withOpacity(0.1)
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Free Consultation',
                  style: AppTypography.h4.copyWith(color: Colors.white)),
              SizedBox(height: 8.h),
              Text(
                  'Book a free 30-minute call to discuss your project — no commitment required.',
                  style: AppTypography.bodySmall),
              SizedBox(height: 16.h),
              Row(
                children: [
                  const Icon(Icons.calendar_today_rounded,
                      color: AppColors.primaryPurple, size: 16),
                  SizedBox(width: 8.w),
                  Text('Schedule a Call',
                      style: AppTypography.labelMedium
                          .copyWith(color: AppColors.primaryPurple)),
                ],
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.1);
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _InfoItem(
      {required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.borderSubtle),
          ),
          child: Icon(icon, color: AppColors.primaryPurple, size: 20),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.caption),
            Text(value,
                style: AppTypography.labelMedium.copyWith(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
