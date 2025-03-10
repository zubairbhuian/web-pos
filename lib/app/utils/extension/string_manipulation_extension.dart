extension StringManipulation on String? {
  // Function to return the part of the string before the first ":"
  String start() {
    if (this == null || this!.isEmpty) {
      return ''; // Return an empty string if the input is null or empty
    }

    try {
      int index = this!.indexOf(':');
      if (index != -1) {
        // Return the part before ":" and trim any leading/trailing spaces
        return this!.substring(0, index).trim();
      }
      return this!.trim(); // Return the whole string if ":" is not found
    } catch (e) {
      return 'Error: Unable to extract start part'; // Return a meaningful error message if something goes wrong
    }
  }

  // Function to return the part of the string after the first ":"
  String end() {
    if (this == null || this!.isEmpty) {
      return ''; // Return an empty string if the input is null or empty
    }

    try {
      int index = this!.indexOf(':');
      if (index != -1) {
        // Return the part after ":" and trim any leading/trailing spaces
        return this!.substring(index + 1).trim();
      }
      return this!.trim(); // Return the whole string if ":" is not found
    } catch (e) {
      return 'Error: Unable to extract end part'; // Return a meaningful error message if something goes wrong
    }
  }

  // Function to capitalize the first letter of the string
  String toCapitalize() {
    if (this == null || this!.isEmpty) {
      return ''; // Return an empty string if the input is null or empty
    }

    try {
      return this![0].toUpperCase() + this!.substring(1).toLowerCase();
    } catch (e) {
      return 'Error: Unable to capitalize string'; // Return a meaningful error message if something goes wrong
    }
  }

  String toCapitalizeEachWord() {
    if (this == null || this!.isEmpty) {
      return ''; // Return an empty string if the input is null or empty
    }

    try {
      return this!
          .split(' ')
          .map((word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : '')
          .join(' ');
    } catch (e) {
      return 'Error: Unable to capitalize each word'; // Return a meaningful error message if something goes wrong
    }
  }
}
