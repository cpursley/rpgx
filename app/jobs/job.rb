# The idea is to use Celluloid to subscribe to changes in the DB
# for both logging purposes as well triggering jobs, emails and other
# work that can't be accomplised directly in the database.

# links:

# https://github.com/pboling/celluloid-io-pg-listener
# http://www.geotangents.com/2013/12/pubsub-with-ruby-and-postgres.html
# https://gist.github.com/jamiehodge/5676442
# http://taotetek.net/2011/02/16/101/
# https://blog.andyet.com/2015/04/06/postgres-pubsub-with-json/
# http://www.sitepoint.com/simple-background-jobs-with-sucker-punch/
# https://github.com/brandonhilkert/sucker_punch
