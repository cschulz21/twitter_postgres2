CREATE INDEX tweets_jsonb_idx ON tweets_jsonb USING GIN (((COALESCE(data->'entities'->'hashtags','[]') ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))::jsonb),(data->'id'));
create index twees_jsonb_idx2 on tweets_jsonb using gin(to_tsvector('english',data->>'text'),to_tsvector('english',data->'extended_tweet'->>'full_text'));
