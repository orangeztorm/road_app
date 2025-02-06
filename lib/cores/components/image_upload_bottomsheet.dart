import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_app/cores/__cores.dart';

class ImageSourceBottomSheet extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;

  const ImageSourceBottomSheet(
      {super.key, required this.onImageSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Wrap(
        children: [
          const Align(
            alignment: Alignment.center,
            child: TextWidget.semiBold(
              'Select Type',
              fontSize: 18,
            ),
          ),
          const VSpace(20),
          ListTile(
            leading: const Icon(
              Icons.photo_library,
              size: 25,
              color: AppColor.kcPrimaryColor,
            ),
            title: const TextWidget.semiBold(
              'Gallery',
              fontSize: 17,
            ),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              onImageSourceSelected.call(
                ImageSource.gallery,
              ); // Trigger the callback with the selected option
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.camera_alt,
              size: 25,
              color: AppColor.kcPrimaryColor,
            ),
            title: const TextWidget.semiBold(
              'Camera',
              fontSize: 17,
            ),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
              onImageSourceSelected(
                ImageSource.camera,
              ); // Trigger the callback with the selected option
            },
          ),
        ],
      ),
    );
  }
}

// class ImagePickerScreen extends StatelessWidget {
//   const ImagePickerScreen({Key? key}) : super(key: key);

//   void _showImageSourceSelection(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return ImageSourceBottomSheet(
//           onImageSourceSelected: (ImageSource source) {
//             _pickImage(source, context);
//           },
//         );
//       },
//     );
//   }

//   void _pickImage(ImageSource source, BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image Selected: ${pickedFile.path}')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No image selected')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Picker'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _showImageSourceSelection(context),
//           child: const Text('Select Image'),
//         ),
//       ),
//     );
//   }
// }