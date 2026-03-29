/// Enum representing all available muscles in the body diagram
///
/// Each muscle has a stable string ID for consistent identification
enum Muscle {
  // Front body
  neck,
  trapsLeft,
  trapsRight,
  deltsLeft,
  deltsRight,
  chestLeft,
  chestRight,
  abs,
  hipLeft,
  hipRight,
  tricepsLeft,
  tricepsRight,
  bicepsLeft,
  bicepsRight,
  forearmsLeft,
  forearmsRight,
  quadsLeft,
  quadsRight,
  kneeLeft,
  kneeRight,
  calvesLeft,
  calvesRight,
  // Back body
  latsBackLeft,
  latsBackRight,
  upperBackLeft,
  upperBackRight,
  lowerLatsBackLeft,
  lowerLatsBackRight,
  lowerBack,
  glutesLeft,
  glutesRight,
  hamstringsLeft,
  hamstringsRight;

  String get id {
    return name;
  }

  String get displayName {
    return name
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim();
  }

  static Muscle? fromId(String id) {
    try {
      return Muscle.values.firstWhere((muscle) => muscle.id == id);
    } catch (e) {
      return null;
    }
  }
}
