# require 'faraday'
# require 'json'
# require 'pact/ffi'
# require 'pact/ffi/logger'
# require 'pact/ffi/mock_server'
# require 'pact/ffi/http_consumer'

# # Example API client
# class Client
#   def initialize(conn)
#     @conn = conn
#   end

#   def httpbingo(jname, params: {})
#     res = @conn.get("/#{jname}", params)
#     data = JSON.parse(res.body)
#     data['origin']
#   end

#   def foo(params)
#     res = @conn.post('/foo', JSON.dump(params))
#     res.status
#   end
# end

# RSpec.describe Client do
#   let(:conn)   { Faraday.new(url: 'http://127.0.0.1:8000/') }
#   let(:client) { Client.new(conn) }
#   let(:pact) { PactFfi.new_pact('faraday-consumer', 'faraday-provider') }
#   let(:mock_server_port) { PactFfi::MockServer.create_for_pact(pact, '127.0.0.1:8000', false) }
#   let(:interaction) { PactFfi::HttpConsumer.new_interaction(pact, 'A POST request to create book') }
#   let(:response_interaction_body) do
#     '
#     {
#       "@context": "/api/contexts/Book",
#       "@id": {
#           "pact:matcher:type": "regex",
#           "regex": "^\\\\/api\\\\/books\\\\/[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12}$",
#           "value": "/api/books/0114b2a8-3347-49d8-ad99-0e792c5a30e6"
#       },
#       "@type": "Book",
#       "title": {
#           "pact:matcher:type": "type",
#           "value": "Voluptas et tempora repellat corporis excepturi."
#       },
#       "description": {
#           "pact:matcher:type": "type",
#           "value": "Quaerat odit quia nisi accusantium natus voluptatem. Explicabo corporis eligendi ut ut sapiente ut qui quidem. Optio amet velit aut delectus. Sed alias asperiores perspiciatis deserunt omnis. Mollitia unde id in."
#       },
#       "author": {
#           "pact:matcher:type": "type",
#           "value": "Melisa Kassulke"
#       },
#       "publicationDate": {
#           "pact:matcher:type": "regex",
#           "regex": "^\\\\d{4}-[01]\\\\d-[0-3]\\\\dT[0-2]\\\\d:[0-5]\\\\d:[0-5]\\\\d([+-][0-2]\\\\d:[0-5]\\\\d|Z)$",
#           "value": "1999-02-13T00:00:00+07:00"
#       },
#       "reviews": [

#       ]
#     }
#     '
#   end
#   before do
#     PactFfi::HttpConsumer.with_specification(pact, PactFfi::FfiSpecificationVersion['SPECIFICATION_VERSION_V3'])
#     PactFfi::HttpConsumer.upon_receiving(interaction, 'A POST request to create book')
#     PactFfi::HttpConsumer.given(interaction, 'No book fixtures required')
#     PactFfi::HttpConsumer.with_request(interaction, 'GET', '/ip')
#     PactFfi::HttpConsumer.with_header(interaction, PactFfi::FfiInteractionPart['INTERACTION_PART_RESPONSE'],
#     'Content-Type', 0, 'application/ld+json; charset=utf-8')
#     PactFfi::HttpConsumer.with_body(interaction, PactFfi::FfiInteractionPart['INTERACTION_PART_RESPONSE'],
#     'application/ld+json; charset=utf-8', response_interaction_body)
#   end

#   after do
#     # expect(PactFfi::MockServer.matched(mock_server_port)).to be true
#     mismatchers = PactFfi::MockServer.mismatches(mock_server_port)
#     puts JSON.parse(mismatchers)
#     res_write_pact = PactFfi::MockServer.write_pact_file(mock_server_port, './pacts', false)
#     PactFfi::MockServer.cleanup(mock_server_port)
#     expect(res_write_pact).to be(0)
#   end
#   it 'parses origin' do
#     #   stubs.get('/ip') do |env|
#     #     # optional: you can inspect the Faraday::Env
#     #     expect(env.url.path).to eq('/ip')
#     #     [
#     #       200,
#     #       { 'Content-Type': 'application/javascript' },
#     #       '{"origin": "127.0.0.1"}'
#     #     ]
#     #   end

#     # uncomment to trigger stubs.verify_stubbed_calls failure
#     # stubs.get('/unused') { [404, {}, ''] }
#     puts "Mock server port=#{mock_server_port}"
#     puts client.httpbingo('ip')
#     # expect(client.httpbingo('ip')).to eq('127.0.0.1')
#     #   stubs.verify_stubbed_calls
#   end

#   # it 'handles 404' do
#   #   stubs.get('/api') do
#   #     [
#   #       404,
#   #       { 'Content-Type': 'application/javascript' },
#   #       '{}'
#   #     ]
#   #   end
#   #   expect(client.httpbingo('api')).to be_nil
#   #   stubs.verify_stubbed_calls
#   # end

#   # it 'handles exception' do
#   #   stubs.get('/api') do
#   #     raise Faraday::ConnectionFailed
#   #   end

#   #   expect { client.httpbingo('api') }.to raise_error(Faraday::ConnectionFailed)
#   #   stubs.verify_stubbed_calls
#   # end

#   # context 'When the test stub is run in strict_mode' do
#   #   let(:stubs) { Faraday::Adapter::Test::Stubs.new(strict_mode: true) }

#   #   it 'verifies the all parameter values are identical' do
#   #     stubs.get('/api?abc=123') do
#   #       [
#   #         200,
#   #         { 'Content-Type': 'application/javascript' },
#   #         '{"origin": "127.0.0.1"}'
#   #       ]
#   #     end

#   #     # uncomment to raise Stubs::NotFound
#   #     # expect(client.httpbingo('api', params: { abc: 123, foo: 'Kappa' })).to eq('127.0.0.1')
#   #     expect(client.httpbingo('api', params: { abc: 123 })).to eq('127.0.0.1')
#   #     stubs.verify_stubbed_calls
#   #   end
#   # end

#   # context 'When the Faraday connection is configured with FlatParamsEncoder' do
#   #   let(:conn) { Faraday.new(request: { params_encoder: Faraday::FlatParamsEncoder }) { |b| b.adapter(:test, stubs) } }

#   #   it 'handles the same multiple URL parameters' do
#   #     stubs.get('/api?a=x&a=y&a=z') { [200, { 'Content-Type' => 'application/json' }, '{"origin": "127.0.0.1"}'] }

#   #     # uncomment to raise Stubs::NotFound
#   #     # expect(client.httpbingo('api', params: { a: %w[x y] })).to eq('127.0.0.1')
#   #     expect(client.httpbingo('api', params: { a: %w[x y z] })).to eq('127.0.0.1')
#   #     stubs.verify_stubbed_calls
#   #   end
#   # end

#   # context 'When you want to test the body, you can use a proc as well as string' do
#   #   it 'tests with a string' do
#   #     stubs.post('/foo', '{"name":"YK"}') { [200, {}, ''] }

#   #     expect(client.foo(name: 'YK')).to eq 200
#   #     stubs.verify_stubbed_calls
#   #   end

#   #   it 'tests with a proc' do
#   #     check = ->(request_body) { JSON.parse(request_body).slice('name') == { 'name' => 'YK' } }
#   #     stubs.post('/foo', check) { [200, {}, ''] }

#   #     expect(client.foo(name: 'YK', created_at: Time.now)).to eq 200
#   #     stubs.verify_stubbed_calls
#   #   end
#   # end
# end
