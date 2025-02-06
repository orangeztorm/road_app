class AppNullChecker<T> {
  T? check(T? data) {
    if (data != null && data != "null") {
      return data;
    } else {
      return null;
    }
  }
}

// () {
//         final String? data = json["recipientFullName"] as String?;

//         if (data != null && data != "null") {
//           return data;
//         } else {
//           return null;
//         }
//       }

// 2023-03-20 T 16:18
// 96000
