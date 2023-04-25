class Env {
  final String gMapKey;
  final String baseUrl;
  final String postCodeAPIUrl;

  Env(this.baseUrl, this.gMapKey, this.postCodeAPIUrl);
}

mixin EnvValue {
  static final Env development = Env("https://dummyjson.com",
      "AIzaSyBF51gojzwm4t5KCLTnW4_lk5ikS5HVJ04", "https://api.postcodes.io");
  static final Env staging = Env("https://dummyjson.com",
      "AIzaSyBF51gojzwm4t5KCLTnW4_lk5ikS5HVJ04", "https://api.postcodes.io");
  static final Env production = Env("https://dummyjson.com",
      "AIzaSyBF51gojzwm4t5KCLTnW4_lk5ikS5HVJ04", "https://api.postcodes.io");
}
