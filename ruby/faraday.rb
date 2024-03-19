require 'faraday'

response = Faraday.get('http://httpbingo.org')

puts response.status
puts response.headers
puts response.body

conn = Faraday.new(
  url: 'http://httpbingo.org',
  params: {param: '1'},
  headers: {'Content-Type' => 'application/json'}
)

response = conn.post('/post') do |req|
  req.params['limit'] = 100
  req.body = {query: 'chunky bacon'}.to_json
end
# => POST http://httpbingo.org/post?param=1&limit=100
puts response.body
