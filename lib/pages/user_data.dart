class UserData {
  String name;
  String email;
  String about;
  double sliderValue;
  bool newsletter;
  bool darkMode;

  UserData({
    this.name = '',
    this.email = '',
    this.about = '',
    this.sliderValue = 0,
    this.newsletter = false,
    this.darkMode = false,
  });
}