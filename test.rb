class PactDSL
  def initialize(consumer:, provider:)
    # @pact = Pact.new(consumer: consumer, provider: provider)
    @pact = {}
  end

  def new_http_interaction(description)
    # @pact.will_respond_with
    @pact = HttpInteraction.new(@pact)
  end

  # def given(description)
  #   @pact.given(description)
  #   self
  # end

  # def with_plugin(name, version)
  #   @pact.with_plugin(name, version)
  #   self
  # end

  # def with_request
  #   @pact.with_request
  #   self
  # end

  # def will_respond_with
  #   @pact.will_respond_with
  #   self
  # end

  # def start
  #   @pact.start
  # end

  class HttpInteraction
    def initialize(pact)
      @pact = pact
    end

    def given(description)
      puts "HttpInteraction given"
      # @pact.given(description)
      self
    end

    def with_plugin(name, version)
      @pact.with_plugin(name, version)
      self
    end

    def with_request
      @pact.with_request
      self
    end

    def will_respond_with
      @pact.will_respond_with
      self
    end


    def start
      @pact.start
    end
  end

  class AsyncMessageInteraction
    def initialize(pact)
      @pact = pact
    end

    def given(description)
      @pact.given(description)
      self
    end

    def with_plugin(name, version)
      @pact.with_plugin(name, version)
      self
    end

    def with_contents
      @pact.with_contents
      self
    end

    def start
      @pact.start
    end
  end

  class SyncMessageInteraction
    def initialize(pact)
      @pact = pact
    end

    def given(description)
      @pact.given(description)
      self
    end

    def with_plugin(name, version)
      @pact.with_plugin(name, version)
      self
    end

    def with_request
      @pact.with_request
      self
    end

    def will_respond_with
      @pact.will_respond_with
      self
    end

    def start
      @pact.start
    end
  end
end

mock_provider = PactDSL.new(consumer: 'c', provider: 'p')

mock_provider.new_http_interaction('').given('')

# pact
#   .new_http_interaction('')
#   .given('') # optional
#   .with_plugin('protobuf', '0.0.0')
#   .with_request
#   .will_respond_with
#   .start

# pact
#   .new_async_message_interaction('upon_receiving')
#   .given('') # optional
#   .with_plugin('protobuf', '0.0.0') # optional
#   .with_contents
#   .start

# pact
#   .new_sync_message_interaction('upon_receiving')
#   .given('') # optional
#   .with_plugin('protobuf', '0.0.0') # optional
#   .with_request
#   .will_respond_with
#   .start