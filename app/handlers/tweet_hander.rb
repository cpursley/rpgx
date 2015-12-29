require './lib/dsl/handlers.rb'

class TweetHandler < RubyResty::Handlers
  model :tweet

  handler(:get_tweets)   { @tweets.sql }
  handler(:create_tweet) { @tweets.insert_sql(tweet_params) }
  handler(:get_tweet)    { @tweets.where(@tweet_id).sql }
  handler(:update_tweet) { @tweets.where(@tweet_id).update_sql(tweet_params) }
  handler(:delete_tweet) { @tweets.where(@tweet_id).delete_sql }

  private
  def self.tweet_params
    escape_params %w(user_id post)
  end
end
