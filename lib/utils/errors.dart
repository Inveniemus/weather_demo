// Errors (development use only!)

class RouteError extends Error {
  final String _description;
  RouteError(this._description);
  String toString() => _description;
}