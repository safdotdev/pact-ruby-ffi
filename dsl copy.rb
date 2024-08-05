class AnimalServiceDSL
  attr_reader :interactions

  def initialize
    @interactions = []
  end

  def given(description)
    interaction = Interaction.new(description)
    @interactions << interaction
    interaction
  end

  class Interaction
    attr_reader :description, :request, :response

    def initialize(description)
      @description = description
    end

    def upon_receiving(description)
      @request = Request.new(description)
      self
    end

    def will_respond_with(response)
      @response = response
      self
    end

    def with(options)
      @request.with(options)
      self
    end
  end

  class Request
    attr_reader :description

    def initialize(description)
      @description = description
    end

    def with(options)
      @options = options
    end
  end
end

animal_service = AnimalServiceDSL.new

animal_service.given("an alligator exists").
  upon_receiving("a request for an alligator").
  with(method: :get, path: '/alligator', query: '').
  will_respond_with(
    status: 200,
    headers: {'Content-Type' => 'application/json'},
    body: {name: 'Betty'}
  )

# Access the interactions
animal_service.interactions.each do |interaction|
  puts "Given: #{interaction.description}"
  puts "Upon receiving: #{interaction.request.description}"
  puts "With: #{interaction.request.instance_variable_get(:@options)}"
  puts "Will respond with: #{interaction.response}"
  puts "------------------------"
end

# pactffi_new_pact
# pactffi_new_interaction
# pactffi_new_message_interaction
# pactffi_new_sync_message_interaction
# pactffi_with_specification

# pactffi_given
# pactffi_given_with_param
# pactffi_given_with_params
# pactffi_upon_receiving

# pactffi_with_query_parameter_v2
# pactffi_with_header_v2
# pactffi_with_request
# pactffi_with_metadata

# pactffi_response_status_v2
# pactffi_with_body
# pactffi_with_binary_body
# pactffi_with_binary_file
# pactffi_with_multipart_file_v2

# pactffi_with_matching_rules
# pactffi_with_generators

# pactffi_create_mock_server_for_transport

# pactffi_message_reify
# pactffi_mock_server_matched
# pactffi_mock_server_mismatches

# pactffi_cleanup_mock_server
# pactffi_write_pact_file
# pactffi_write_message_pact_file

# mock_service = Pact.new(consumer: "c",provider:"p")

# mock_service.given("an alligator exists").
#   upon_receiving("a request for an alligator").
#   with(method: :get, path: '/alligator', query: '').
#   will_respond_with(
#     status: 200,
#     headers: {'Content-Type' => 'application/json'},
#     body: {name: 'Betty'}
#   )

# # Access the interactions
# mock_service.interactions.each do |interaction|
#   puts "Given: #{interaction.description}"
#   puts "Upon receiving: #{interaction.request.description}"
#   puts "With: #{interaction.request.instance_variable_get(:@options)}"
#   puts "Will respond with: #{interaction.response}"
#   puts "------------------------"
# end



pact = Pact.new(consumer: "c",provider:"p")

pact
  .new_http_interaction("")
  .given("") #optional
  .with_plugin("protobuf","0.0.0")
  .with_request()
  .will_respond_with()
  .start()

pact.
  new_async_message_interaction("upon_receiving")
  .given("") #optional
  .with_plugin("protobuf","0.0.0") # optional
  .with_contents()
  .start()

pact.
  new_sync_message_interaction("upon_receiving")
  .given("") #optional
  .with_plugin("protobuf","0.0.0") # optional
  .with_request()
  .will_respond_with()
  .start()

pact.verify()

mock_service.given("an alligator exists").
  upon_receiving("a request for an alligator").
  with(method: :get, path: '/alligator', query: '').
  will_respond_with(
    status: 200,
    headers: {'Content-Type' => 'application/json'},
    body: {name: 'Betty'}
  )

mock_service.interactions.each do |interaction|
  puts "Given: #{interaction.description}"
  puts "Upon receiving: #{interaction.request.description}"
  puts "With: #{interaction.request.instance_variable_get(:@options)}"
  puts "Will respond with: #{interaction.response}"
  puts "------------------------"
end



