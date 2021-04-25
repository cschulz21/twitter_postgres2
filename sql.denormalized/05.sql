/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
select
    '#' || (jsonb->>'text'::TEXT) AS tag,
    count(distinct id) as count
from
(
select distinct
    data->>'id' as id,
    jsonb_array_elements(
                  COALESCE(data->'entities'->'hashtags','[]') ||
                  COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
              ) AS jsonb

from tweets_jsonb
where (to_tsvector('english',data->>'text')@@to_tsquery('english','coronavirus')
    or
    to_tsvector('english',data->'extended_tweet'->>'full_text')@@to_tsquery('english','coronavirus'))
and data->>'lang' = 'en'
) as t
group by tag
order by count desc, tag
limit 1000;
