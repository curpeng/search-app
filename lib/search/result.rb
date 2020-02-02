# frozen_string_literal: true

class Search::Result
  attr_reader :messages, :hashtags

  def initialize(messages:, hashtags: )
    @messages = messages
    @hashtags = hashtags
  end

  def to_json
    {
      messages: messages,
      hashtags: hashtags
    }.to_json
  end
end
