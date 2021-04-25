/*
 * Count the number of tweets that use #coronavirus
 */
select 
    count(distinct data->>'id') 
from tweets_jsonb 
where 
    (COALESCE(data->'entities'->'hashtags','[]') ||
    COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))::jsonb 
    @> 
    '[{"text":"coronavirus"}]'::jsonb;
