--护肤数据洞察

--搜索词（搜索量降序）
select
      search_keyword,
      sum(search_cnt) as search_cnt 
    from 
    (
      select
        search_keyword,
        user_token,
        taxonomy1,
        taxonomy2,
        taxonomy3,
        sum(search_cnt) as search_cnt
      from
      (
          select
            search_keyword,
            user_token,
            keyword_taxonomy1 as taxonomy1,
            keyword_taxonomy2 as taxonomy2,
            keyword_taxonomy3 as taxonomy3,
            sum(origin_query_cnt) as search_cnt
          from reddm.dm_soc_user_search_result_day_inc
          where dtm between '20201001' and '20201031'
          and dtm >= '20201101'
          and regexp_like(replace(lower(search_keyword),' ',''),'美白|淡斑|祛斑|增白|变白|提亮|烟酰胺|维C|熊果苷|谷胱甘肽|传明酸|光果甘草|甘草酰胺|小白瓶|小白灯|小灯泡|皮秒|白瓷镭射|光子嫩肤|纳晶|水光针|黑色素|日晒|紫外线')
          and not regexp_like(replace(lower(search_keyword),' ',''),'牙')
          and coalesce(keyword_taxonomy1,'') like '%美妆%'
          and coalesce(keyword_taxonomy2,'') like '%%'
          and coalesce(keyword_taxonomy3,'') like '%%'
          and type = '社区-搜索'
          group by 1,2,3,4,5
          union all
          select
            search_keyword,
            user_token,
            keyword_taxonomy1 as taxonomy1,
            keyword_taxonomy2 as taxonomy2,
            keyword_taxonomy3 as taxonomy3,
            sum(query_cnt) as search_cnt
          from reddm.dm_soc_user_search_result_day_inc
          where dtm between '20201001' and '20201031'
          and dtm < '20201101'
          and regexp_like(replace(lower(search_keyword),' ',''),'美白|淡斑|祛斑|增白|变白|提亮|烟酰胺|维C|熊果苷|谷胱甘肽|传明酸|光果甘草|甘草酰胺|小白瓶|小白灯|小灯泡|皮秒|白瓷镭射|光子嫩肤|纳晶|水光针|黑色素|日晒|紫外线')
          and not regexp_like(replace(lower(search_keyword),' ',''),'牙')
          and coalesce(keyword_taxonomy1,'') like '%美妆%'
          and coalesce(keyword_taxonomy2,'') like '%%'
          and coalesce(keyword_taxonomy3,'') like '%%'
          and type = '社区-搜索'
          group by 1,2,3,4,5
      ) a
      group by 1,2,3,4,5

    ) as a 
    group by 1
    order by search_cnt desc 
    limit 1000
    
--笔记关键词（笔记量降序）
select
  tag_name ,
  count(distinct b.discovery_id) as note_cnt
from
(
    select
        discovery_id
        ,tag_name
    from reddw.dw_soc_discovery_recommend_info_day
    where dtm = f_getdate('{{ds_nodash}}' , -1) 
    and tag_type in ('keyword','brand')
) a
join 
(
    select
        a.discovery_id
    from reddm.dm_soc_discovery_user_engagement_day_inc a
    where a.dtm =  f_getdate('{{ds_nodash}}' , -1) 
    and a.read_feed_num > 0
    and a.level > 1
    and (a.enabled is null or a.enabled=true)
    and f_getdate(a.create_time) between '20201001' and '20201031'
    and coalesce(a.tag_category1,'') like '%美妆%'
    and coalesce(a.tag_category2,'') like '%%'
    and coalesce(a.tag_category3,'') like '%%'
    group by 1
) b
on a.discovery_id = b.discovery_id

join
(
  select
    distinct discovery_id
  from reddw.dw_soc_discovery_content_day
  where 
    regexp_like(replace(lower(content),' ',''),'美白|淡斑|祛斑|增白|变白|提亮|烟酰胺|维C|熊果苷|谷胱甘肽|传明酸|光果甘草|甘草酰胺|小白瓶|小白灯|小灯泡|皮秒|白瓷镭射|光子嫩肤|纳晶|水光针|黑色素|日晒|紫外线')
    and not regexp_like(replace(lower(content),' ',''),'牙')
  and dtm = f_getdate('{{ds_nodash}}' , -1) 
) as c
on a.discovery_id=c.discovery_id
group by 1
order by note_cnt desc 
limit 1000

----------------------------------------------------------------------------------------------------------------------------

--抗糖（笔记词）
      
select
  tag_name ,
  count(distinct b.discovery_id) as note_cnt
from
(
    select
        discovery_id
        ,tag_name
    from reddw.dw_soc_discovery_recommend_info_day
    where dtm = f_getdate('{{ds_nodash}}' , -1) 
    and tag_type in ('keyword','brand')
) a
join 
(
    select
        a.discovery_id
    from reddm.dm_soc_discovery_user_engagement_day_inc a
        -----join temp."20190802_lining1_data_insight_user_group_1" as b
        -----on md5(a.user_id) = b.user_token
    where a.dtm =  f_getdate('{{ds_nodash}}' , -1) 
    and a.read_feed_num > 0
    and a.level > 1
    and (a.enabled is null or a.enabled=true)
    and f_getdate(a.create_time) between f_getdate('20201001')  and f_getdate('20201031' )
    and coalesce(a.tag_category1,'') like '%美妆%'
    and coalesce(a.tag_category2,'') like '%%'
    and coalesce(a.tag_category3,'') like '%%'
    group by 1
) b
on a.discovery_id = b.discovery_id

join
(
  select
    distinct discovery_id
  from reddw.dw_soc_discovery_content_day
  where
  (
        regexp_like(replace(lower(content),' ',''),'抗糖|断糖|控糖|肌肽|玻色因|硫辛酸|葡萄籽提取物|黄酮|多酚|阿魏酸|鞣花酸|山竹提取物|蓝莓提取物|白藜芦醇|hfp肌肽原液|奢纯|糖化|AGEs')
        or
        (
        regexp_like(replace(lower(content),' ',''),'去黄|祛黄|发黄|变黄')
        and
        regexp_like(replace(lower(content),' ',''),'面部|脸|肤')  
        )
        )
        and not regexp_like(replace(lower(content),' ',''),'牙|眼白|洗发水')
  and dtm =  f_getdate('{{ds_nodash}}' , -1) 
) as c
on a.discovery_id=c.discovery_id
group by 1
order by note_cnt desc 
limit 100000

----------------------------------------------------------------------------------------------------------------------------
--抗氧化（搜索词）
select
      search_keyword,
      sum(search_cnt) as search_cnt 
    from 
    (

        select
          search_keyword,
          user_token,
          keyword_taxonomy1 as taxonomy1,
          keyword_taxonomy2 as taxonomy2,
          keyword_taxonomy3 as taxonomy3,
          sum(case when dtm >= '20201101' then query_cnt-full_screen_ads_query_cnt else query_cnt end) as search_cnt
        from reddm.dm_soc_user_search_result_day_inc
        where dtm between '20201001' and '20201031'
        and
        (
        regexp_like(replace(lower(search_keyword),' ',''),'自由基|葡萄籽|虾青素|花青素|茶多酚|白藜芦醇|辅酶q10|茄红素|维生素c|维c|儿茶素|硫辛酸|谷胱甘肽|阿瑰酸')
        or
        (
        regexp_like(replace(lower(search_keyword),' ',''),'肤|抗|防|维e|维生素ce|维生素e')
        and
        regexp_like(replace(lower(search_keyword),' ',''),'氧化')
        )
        )
        and coalesce(keyword_taxonomy1,'') like '%美妆%'
        and coalesce(keyword_taxonomy2,'') like '%%'
        and coalesce(keyword_taxonomy3,'') like '%%'
        and type = '社区-搜索'
        group by 1,2,3,4,5


    ) as a 
    -----join temp."20190802_ningli1_data_insight_user_group_1" as b
    -----on a.user_token = b.user_token
    group by 1
    order by search_cnt desc 
    limit 1000


-- 抗氧化（笔记词）
select
  tag_name ,
  count(distinct b.discovery_id) as note_cnt
from
(
    select
        discovery_id
        ,tag_name
    from reddw.dw_soc_discovery_recommend_info_day
    where dtm = f_getdate('{{ds_nodash}}' , -1) 
    and tag_type in ('keyword','brand')
) a
join 
(
    select
        a.discovery_id
    from reddm.dm_soc_discovery_user_engagement_day_inc a
        -----join temp."20190802_lining1_data_insight_user_group_1" as b
        -----on md5(a.user_id) = b.user_token
    where a.dtm =  f_getdate('{{ds_nodash}}' , -1) 
    and a.read_feed_num > 0
    and a.level > 1
    and (a.enabled is null or a.enabled=true)
    and f_getdate(a.create_time) between f_getdate('20201001')  and f_getdate('20201031' )
    and coalesce(a.tag_category1,'') like '%美妆%'
    and coalesce(a.tag_category2,'') like '%%'
    and coalesce(a.tag_category3,'') like '%%'
    group by 1
) b
on a.discovery_id = b.discovery_id

join
(
  select
    distinct discovery_id
  from reddw.dw_soc_discovery_content_day
  where
        (
        regexp_like(replace(lower(content),' ',''),'自由基|葡萄籽|虾青素|花青素|茶多酚|白藜芦醇|辅酶q10|茄红素|维生素c|维c|儿茶素|硫辛酸|谷胱甘肽|阿瑰酸')
        or
        (
        regexp_like(replace(lower(content),' ',''),'肤|抗|防|维e|维生素ce|维生素e')
        and
        regexp_like(replace(lower(content),' ',''),'氧化')
        )
        )
  and dtm =  f_getdate('{{ds_nodash}}' , -1) 
) as c
on a.discovery_id=c.discovery_id
group by 1
order by note_cnt desc 
limit 1000


----------------------------------------------------------------------------------------------------------------------------


--抗老（搜索词）
select
      search_keyword,
      sum(search_cnt) as search_cnt 
    from 
    (

        select
          search_keyword,
          user_token,
          keyword_taxonomy1 as taxonomy1,
          keyword_taxonomy2 as taxonomy2,
          keyword_taxonomy3 as taxonomy3,
          sum(case when dtm >= '20201101' then query_cnt-full_screen_ads_query_cnt else query_cnt end) as search_cnt
        from reddm.dm_soc_user_search_result_day_inc
        where dtm between '20200101' and '20200131'
        and
        (
        regexp_like(replace(lower(search_keyword),' ',''),'抗老|抗初老|防衰|抗衰|抗皱|防皱|祛皱|提拉|焕肤|紧致|胜肽|视黄醇|烟酰胺|热玛吉|肉毒素|衰老|皱纹|细纹')
        or
        (
        regexp_like(replace(lower(search_keyword),' ',''),'小棕瓶')
        and not regexp_like(replace(lower(search_keyword),' ',''),'英诺')
        )
        )
        and coalesce(keyword_taxonomy1,'') like '%美妆%'
        and coalesce(keyword_taxonomy2,'') like '%%'
        and coalesce(keyword_taxonomy3,'') like '%%'
        and type = '社区-搜索'
        group by 1,2,3,4,5


    ) as a 
    -----join temp."20190802_ningli1_data_insight_user_group_1" as b
    -----on a.user_token = b.user_token
    group by 1
    order by search_cnt desc 
    limit 1000
    
    
-- 抗老（笔记词）

select
  tag_name ,
  count(distinct b.discovery_id) as note_cnt
from
(
    select
        discovery_id
        ,tag_name
    from reddw.dw_soc_discovery_recommend_info_day
    where dtm = f_getdate('{{ds_nodash}}' , -1) 
    and tag_type in ('keyword','brand')
) a
join 
(
    select
        a.discovery_id
    from reddm.dm_soc_discovery_user_engagement_day_inc a
        -----join temp."20190802_lining1_data_insight_user_group_1" as b
        -----on md5(a.user_id) = b.user_token
    where a.dtm =  f_getdate('{{ds_nodash}}' , -1) 
    and a.read_feed_num > 0
    and a.level > 1
    and (a.enabled is null or a.enabled=true)
    and f_getdate(a.create_time) between f_getdate('20201001')  and f_getdate('20201031' )
    and coalesce(a.tag_category1,'') like '%美妆%'
    and coalesce(a.tag_category2,'') like '%%'
    and coalesce(a.tag_category3,'') like '%%'
    group by 1
) b
on a.discovery_id = b.discovery_id

join
(
  select
    distinct discovery_id
  from reddw.dw_soc_discovery_content_day
  where
       (
        regexp_like(replace(lower(content),' ',''),'抗老|抗初老|防衰|抗衰|抗皱|防皱|祛皱|提拉|焕肤|紧致|胜肽|视黄醇|烟酰胺|热玛吉|肉毒素|衰老|皱纹|细纹')
        or
        (
        regexp_like(replace(lower(content),' ',''),'小棕瓶')
        and not regexp_like(replace(lower(content),' ',''),'英诺')
        )
        )
  and dtm =  f_getdate('{{ds_nodash}}' , -1) 
) as c
on a.discovery_id=c.discovery_id
group by 1
order by note_cnt desc 
limit 1000