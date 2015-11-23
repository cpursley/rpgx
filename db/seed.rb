require 'colorize'
require 'sequel'
require './config/database.rb'

begin
  # users
  %w(doug jane steve tom).each do |user|
    DB.from(:users).insert(username: user)
  end

  # tweets
  tweets = [
    'My first tweet!',
    'Another tweet with a tag! #hello-world @missing',
    'My second tweet! #hello-world #hello-world-again',
    'Is anyone else hungry? #imHUNGRY #gimmefood @TOM @jane',
    '@steve hola!',
    '@bob I am! #imhungry #metoo #gimmefood #now'
  ]
  user_ids = DB.from(:users).map{ |user| user[:id] }
  tweets.each do |tweet|
    DB.from(:tweets).insert(
      post:    tweet,
      user_id: user_ids.sample
    )
  end

  # favorites
  tweet_ids = DB.from(:tweets).map{ |tweet| tweet[:id] }
  user_ids.each do |user_id|
    DB.from(:favorites).insert(
      user_id:  user_id,
      tweet_id: tweet_ids.sample
    )
  end

  # followers
  user_ids.each do |user_id|
    DB.from(:followers).insert(
      follower_id: (user_ids - [user_id]).sample,
      user_id:     user_id
    )
  end

  # replies
  tweet_ids.each do |tweet_id|
    DB.from(:replies).insert(
      tweet_id: tweet_id,
      reply_id: (tweet_ids - [tweet_id]).sample
    )
  end

  # retweets
  tweet_ids.each do |tweet_id|
    DB.from(:retweets).insert(
      tweet_id:   tweet_id,
      retweet_id: (tweet_ids - [tweet_id]).sample
    )
  end

rescue Sequel::Error => e
  puts "<= #{e}".colorize(:red)
end
