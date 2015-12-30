require 'colorize'
require 'forgery'
require 'sequel'
require './lib/config/database.rb'

begin
  # Users
  10.times do
    DB.from(:users).insert(
      name:     Forgery(:name).full_name,
      email:    Forgery(:internet).email_address,
      password: Forgery(:basic).password
    )
  end

  # Tweets
  tweets = []
  20.times { tweets << Forgery(:lorem_ipsum).characters(rand(25..140)) }
  user_ids = DB.from(:users).map{ |user| user[:id] }
  tweets.each do |tweet|
    DB.from(:tweets).insert(
      post:    (tweets - [tweet]).sample,
      user_id: user_ids.sample
    )
  end

  # # favorites
  # tweet_ids = DB.from(:tweets).map{ |tweet| tweet[:id] }
  # user_ids.each do |user_id|
  #   DB.from(:favorites).insert(
  #     user_id:  user_id,
  #     tweet_id: tweet_ids.sample
  #   )
  # end
  #
  # # followers
  # user_ids.each do |user_id|
  #   DB.from(:followers).insert(
  #     follower_id: (user_ids - [user_id]).sample,
  #     user_id:     user_id
  #   )
  # end
  #
  # # replies
  # tweet_ids.each do |tweet_id|
  #   DB.from(:replies).insert(
  #     tweet_id: tweet_id,
  #     reply_id: (tweet_ids - [tweet_id]).sample
  #   )
  # end
  #
  # # retweets
  # tweet_ids.each do |tweet_id|
  #   DB.from(:retweets).insert(
  #     tweet_id:   tweet_id,
  #     retweet_id: (tweet_ids - [tweet_id]).sample
  #   )
  # end

rescue Sequel::Error => e
  puts "<= #{e}".colorize(:red)
end
