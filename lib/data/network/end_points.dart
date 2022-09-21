class EndPoints {
  final String _baseURL = 'https://api.covid19api.com';
  final String _summary = '/summary';


  String getCoronaSummary() {
    return _baseURL + _summary;
  }

}
