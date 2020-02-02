# frozen_string_literal: true

class Search::Message
  attr_reader :body

  def initialize(body)
    @body = body
  end

  def to_json
    {
      body: body
    }.to_json
  end

  def ==(other_message)
    body == other_message.body
  end
end
