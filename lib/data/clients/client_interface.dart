abstract class IClient<T> {
  T getClient();
  Future<T> getAuthClient();
}
