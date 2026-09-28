/**
 * Routing HttpCalloutMock shared by the test suite.
 *
 * A response is chosen by the first registered key that the request endpoint
 * contains. A key can hold a queue of responses (paged or sequential calls);
 * the last one is repeated once the queue is drained. Unmatched requests get
 * the default response, 200 with an empty JSON object.
 */
@isTest
public class TestHttpMock implements HttpCalloutMock {
  private final List<String> keys = new List<String>();
  private final Map<String, List<HttpResponse>> responsesByKey = new Map<String, List<HttpResponse>>();
  private HttpResponse defaultResponse = build(200, '{}', null);
  public final List<HttpRequest> requests = new List<HttpRequest>();

  public TestHttpMock when(
    String endpointFragment,
    Integer status,
    String body
  ) {
    return when(endpointFragment, build(status, body, null));
  }

  public TestHttpMock when(
    String endpointFragment,
    Integer status,
    String body,
    Map<String, String> headers
  ) {
    return when(endpointFragment, build(status, body, headers));
  }

  public TestHttpMock when(String endpointFragment, HttpResponse response) {
    if (!responsesByKey.containsKey(endpointFragment)) {
      keys.add(endpointFragment);
      responsesByKey.put(endpointFragment, new List<HttpResponse>());
    }
    responsesByKey.get(endpointFragment).add(response);
    return this;
  }

  public TestHttpMock otherwise(Integer status, String body) {
    defaultResponse = build(status, body, null);
    return this;
  }

  public HttpResponse respond(HttpRequest request) {
    requests.add(request);
    String endpoint = request.getEndpoint() == null
      ? ''
      : request.getEndpoint();
    for (String key : keys) {
      if (!endpoint.contains(key)) {
        continue;
      }
      List<HttpResponse> queue = responsesByKey.get(key);
      return queue.size() > 1 ? queue.remove(0) : queue[0];
    }
    return defaultResponse;
  }

  public static HttpResponse build(
    Integer status,
    String body,
    Map<String, String> headers
  ) {
    HttpResponse response = new HttpResponse();
    response.setStatusCode(status);
    response.setBody(body == null ? '' : body);
    if (headers != null) {
      for (String name : headers.keySet()) {
        response.setHeader(name, headers.get(name));
      }
    }
    return response;
  }

  public static TestHttpMock install() {
    TestHttpMock mock = new TestHttpMock();
    Test.setMock(HttpCalloutMock.class, mock);
    return mock;
  }
}
