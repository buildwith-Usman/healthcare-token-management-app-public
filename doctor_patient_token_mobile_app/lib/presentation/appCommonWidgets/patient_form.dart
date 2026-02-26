import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_icon.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../generated/locales.g.dart';
import '../book_appointment/book_appointment_controller.dart';
import '../widgets/textfield/form_textfield.dart'; // Your custom text field

class PatientForm extends GetStatefulWidget<BookAppointmentController> {
  final int index;
  const PatientForm({super.key, required this.index});

  @override
  State<PatientForm> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientForm> {
  final GlobalKey _selectGenderFieldKey = GlobalKey();

  String? selectedOption;
  late final TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    // Initialize with current value from controller (or empty)
    _genderController = TextEditingController(
      text: widget.controller.genderList.length > widget.index
          ? widget.controller.genderList[widget.index] ?? ''
          : '',
    );
  }

  @override
  void dispose() {
    _genderController.dispose();
    super.dispose();
  }

  void _onDropdownItemSelected(String selected, int index) {
    setState(() {
      selectedOption = selected;
      widget.controller.genderList[index] = selected;
      _genderController.text = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    // sync controller text with underlying gender list in case of external reset
    final currentGender = widget.controller.genderList.length > widget.index
        ? widget.controller.genderList[widget.index] ?? ''
        : '';
    if (_genderController.text != currentGender) {
      _genderController.text = currentGender;
    }
    return _buildPatientForm(context);
  }

  Widget _buildPatientForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: FormTextField(
            controller: widget.controller.nameControllers[widget.index],
            hintText: LocaleKeys.bookAppointmentScreen_patientName.tr,
            height: 50,
            fontSize: 12,
            titleText: "Patient ${widget.index + 1}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: FormTextField(
            controller: widget.controller.ageControllers[widget.index],
            hintText: LocaleKeys.bookAppointmentScreen_patientAge.tr,
            height: 50,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: FormTextField(
            key: _selectGenderFieldKey,
            hintText: LocaleKeys.bookAppointmentScreen_patientGender.tr,
            height: 50,
            fontSize: 12,
            readOnly: true,
            suffixIcon: AppIcon.dropDown.widget(),
            controller: _genderController,
            onSuffixIconTap: () {
              _selectGenderDropdown(context, _selectGenderFieldKey, widget.index);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _selectGenderDropdown(
      BuildContext context, GlobalKey textFieldKey, int index) async {
    // Ensure the GlobalKey context is valid and the TextFormField is rendered
    final RenderBox? button =
    textFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (button == null) {
      return; // If button is null, we can't proceed with positioning.
    }

    final RenderBox? overlay =
    Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) {
      return; // If overlay is null, we can't show the dropdown.
    }

    // Get the position of the TextFormField relative to the screen
    final Offset buttonOffset =
    button.localToGlobal(Offset.zero, ancestor: overlay);

    // Get the width and height of the TextFormField
    final double buttonHeight = button.size.height;
    final double buttonWidth = button.size.width;

    // Debugging the position and size
    print("Button Offset: $buttonOffset");
    print("Button Width: $buttonWidth, Button Height: $buttonHeight");

    // Create a position for the dropdown that is below and aligned to the full width of the TextFormField
    final RelativeRect position = RelativeRect.fromLTRB(
      buttonOffset.dx, // Left aligned with the TextFormField
      buttonOffset.dy + buttonHeight, // Dropdown starts below the TextFormField
      buttonOffset.dx + buttonWidth, // Right aligned with the TextFormField
      buttonOffset.dy +
          buttonHeight +
          50, // Adjust the dropdown height as needed
    );

    // Show the dropdown menu with the updated position and full width
    String? selectedValue = await showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: "Male",
          child: SizedBox(
            width: buttonWidth, // Full width of the TextFormField
            child: const Text('Male'),
          ),
        ),
        PopupMenuItem<String>(
          value: "Female",
          child: SizedBox(
            width: buttonWidth, // Full width of the TextFormField
            child: const Text('Female'),
          ),
        ),
        PopupMenuItem<String>(
          value: "Other",
          child: SizedBox(
            width: buttonWidth, // Full width of the TextFormField
            child: const Text('Other'),
          ),
        ),
      ],
    );

    if (selectedValue != null) {
      _onDropdownItemSelected(selectedValue, index); // Handle the selection
    }
  }
}
