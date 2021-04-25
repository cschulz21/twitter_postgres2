/*
 * Calculates the languages that commonly use the hashtag #coronavirus
 */
select
    lang,
    count(distinct id) as count
from
(   select distinct
        data->>'id' as id,
        data->>'lang' as lang
    from tweets_jsonb
    where 
        (COALESCE(data->'entities'->'hashtags','[]') ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))::jsonb 
        @>  
        '[{"text":"coronavirus"}]'::jsonb
) t
GROUP BY lang
ORDER BY count DESC, lang;

