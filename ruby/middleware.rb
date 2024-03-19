require 'faraday'

conn = Faraday.new(url: 'http://httpbingo.org') do |builder|
  # Calls MyAuthStorage.get_auth_token on each request to get the auth token
  # and sets it in the Authorization header with Bearer scheme.
  builder.request :authorization, 'Bearer', -> { MyAuthStorage.get_auth_token }

  # Sets the Content-Type header to application/json on each request.
  # Also, if the request body is a Hash, it will automatically be encoded as JSON.
  builder.request :json

  # Parses JSON response bodies.
  # If the response body is not valid JSON, it will raise a Faraday::ParsingError.
  builder.response :json

  # Raises an error on 4xx and 5xx responses.
  builder.response :raise_error

  # Logs requests and responses.
  # By default, it only logs the request method and URL, and the request/response headers.
  builder.response :logger
end

# A simple example implementation for MyAuthStorage
class MyAuthStorage
  def self.get_auth_token
    rand(36 ** 8).to_s(36)
  end
end

begin
  response = conn.post('post', { payload: 'this ruby hash will become JSON' })
rescue Faraday::Error => e
  # You can handle errors here (4xx/5xx responses, timeouts, etc.)
  puts e.response[:status]
  puts e.response[:body]
end

# At this point, you can assume the request was successful
puts response.body

# I, [2023-06-30T14:27:11.776511 #35368]  INFO -- request: POST http://httpbingo.org/post
# I, [2023-06-30T14:27:11.776646 #35368]  INFO -- request: User-Agent: "Faraday v2.7.8"
# Authorization: "Bearer wibzjgyh"
# Content-Type: "application/json"
# I, [2023-06-30T14:27:12.063897 #35368]  INFO -- response: Status 200
# I, [2023-06-30T14:27:12.064260 #35368]  INFO -- response: access-control-allow-credentials: "true"
# access-control-allow-origin: "*"
# content-type: "application/json; encoding=utf-8"
# date: "Fri, 30 Jun 2023 13:27:12 GMT"
# content-encoding: "gzip"
# transfer-encoding: "chunked"
# server: "Fly/a0b91024 (2023-06-13)"
# via: "1.1 fly.io"
# fly-request-id: "01H467RYRHA0YK4TQSZ7HS8ZFT-lhr"
# cf-team: "19ae1592b8000003bbaedcf400000001"
