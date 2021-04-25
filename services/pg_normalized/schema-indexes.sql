create index tweet_tags_idx on tweet_tags(tag, id_tweets);
create index tweets_idx on tweets(id_tweets, lang);
create index tweets_gidx on tweets using gin (to_tsvector('english',text));
