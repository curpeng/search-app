require 'rails_helper'

RSpec.describe Search::Twitter do
  let(:tweet_count) { 50 }
  let(:hashtag_count) { 5 }

  let(:client) do
    double(search: twitter_search_results)
  end

  let(:twitter_search_results) do
    double(take: tweets)
  end

  let(:top_hashtags) do
    Array.new(hashtag_count).map { double(text: Faker::Lorem.word) }
  end

  let(:tweets) do
    Array.new(tweet_count).map do
      hashtags = [
        top_hashtags.sample,
        top_hashtags.sample,
        top_hashtags.sample,
        double(text: Faker::Lorem.word)
      ]
      double(text: Faker::Lorem.sentence, hashtags: hashtags)
    end
  end

  describe '#call' do
    subject { described_class.new(client).call(term: 'yo', count: tweet_count, hashtag_count: hashtag_count) }

    it 'returns Search::Result' do
      expect(subject).to be_a(Search::Result)
    end

    it 'returns a result with correct messages' do
      mapped_tweets = tweets.map { |tweet| Search::Message.new(tweet.text) }
      expect(subject.messages).to eq(mapped_tweets)
    end

    it 'returns a result with hashtags, which have the highest amount of appears in the results' do
      hashtags_stats = Hash.new(0)

      tweets.map(&:hashtags).flatten.each do |hashtag|
        hashtags_stats[hashtag.text] += 1
      end

      expected_raw_hashtags = hashtags_stats.to_a.sort_by { |hashtag_stats| -hashtag_stats[1] }.first(hashtag_count)

      expected_hashtags = expected_raw_hashtags.map { |hashtag| Search::Hashtag.new(*hashtag) }

      expect(subject.hashtags).to eq(expected_hashtags)
    end
  end
end
