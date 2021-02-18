class Doctor {
  final String id;
  final String displayName;
  final String bio;
  final String degrees;
  final String category;
  final String hospital;
  final String photoUrl;
  String status;
  double rating;

  Doctor(
      {this.id,
      this.displayName,
      this.category,
      this.bio,
      this.degrees,
      this.hospital,
      this.photoUrl,
      this.status,
      this.rating});
}
