class PolicyTerms {
  String? sId;
  String? policy;
  String? termsOfServices;
  String? appEmail;
  String? linkAdroid;
  String? linkIos;

  PolicyTerms(
      {this.sId,
      this.policy,
      this.termsOfServices,
      this.appEmail,
      this.linkAdroid,
      this.linkIos});

  PolicyTerms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    policy = json['policy'];
    termsOfServices = json['termsOfServices'];
    appEmail = json['appEmail'];
    linkAdroid = json['linkShareAndroid'];
    linkIos = json['linkShareIos'];
  }
}
