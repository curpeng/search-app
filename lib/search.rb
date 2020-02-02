# frozen_string_literal: true

module Search
  def self.call(term: , lang: :en, count: 100, hashtag_count: 10)
    Search::Twitter.new.call(
      term: term,
      lang: lang,
      count: count,
      hashtag_count: hashtag_count
    )
  end
end
