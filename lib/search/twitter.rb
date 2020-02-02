# frozen_string_literal: true

class Search::Twitter
  def initialize(client = configured_client)
    @client = client
    @hashtag_popularity
  end

  def call(term:, lang: :en, count: 100, hashtag_count: 10)
    result = client.search("#{term} -rt", lang: lang, count: count, result_type: :recent)
    tweets = result.take(count)

    messages = tweets.map { |tweet| Search::Message.new(tweet.text) }
    hashtags = tweets.map(&:hashtags).flatten

    top_hashtags = find_top_hashtags(hashtags, hashtag_count)
    top_hashtags = top_hashtags.map { |hashtag| Search::Hashtag.new(*hashtag) }

    Search::Result.new(messages: messages, hashtags: top_hashtags)
  end

  private

  attr_reader :client

  def configured_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.configuration.x.twitter.consumer_key
      config.consumer_secret = Rails.configuration.x.twitter.consumer_secret
    end
  end

  def find_top_hashtags(hashtags, hashtag_count)
    hashtags_stats = Hash.new(0)

    hashtags.each do |hashtag|
      hashtags_stats[hashtag.text] += 1
    end

    hashtags_stats.to_a.sort_by { |hashtag_stats| -hashtag_stats[1] }.first(hashtag_count)
  end
end
