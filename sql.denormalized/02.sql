/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
select
    '#' || (jsonb->>'text'::TEXT) AS tag,
    count(distinct id) as count
from
(   select distinct
        data->>'id' as id,
        jsonb_array_elements(
                  COALESCE(data->'entities'->'hashtags','[]') ||
                  COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
              ) AS jsonb
    from tweets_jsonb
    where 
        (COALESCE(data->'entities'->'hashtags','[]') ||
        COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))::jsonb 
        @>  
        '[{"text":"coronavirus"}]'::jsonb
) t
GROUP BY (1) 
ORDER BY count DESC,tag
LIMIT 1000;
