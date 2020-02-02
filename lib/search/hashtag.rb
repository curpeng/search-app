# frozen_string_literal: true

class Search::Hashtag
  attr_reader :name, :appearances_amount

  def initialize(name, appearances_amount)
    @name = name
    @appearances_amount = appearances_amount
  end

  def to_json
    {
      name: name,
      appearances_amount: appearances_amount
    }.to_json
  end

  def ==(other_hashtag)
    name == other_hashtag.name && appearances_amount == other_hashtag.appearances_amount
  end
end
