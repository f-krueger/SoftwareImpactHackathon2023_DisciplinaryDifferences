-- SELECT a.pmcid,a.display_name, a.referenced_work_id,b.display_name AS referenced_domain
--step 1: map the referenced work to referenced domains

--step 2: for each referenced work how many software do they use
--step 3: for each referenced work, how many unique software they use (unique per paper)
-- FROM `insyspo.userdb_hackaton_san_francisco.10k_sample_l0_wRef` as a
-- JOIN `insyspo.userdb_hackaton_san_francisco.dois_openalex_concepts_top_concept` as b
-- on b.work_id=a.referenced_work_id
-- ORDER BY a.pmcid



--------------------Generating file 10k_Sampled_L0_wRef
-- SELECT a.display_name AS L0_domain,a.work_id, b.pmcid AS L0_publication, c.referenced_work_id AS L1_ref_paper
-- FROM `insyspo.userdb_hackaton_san_francisco.10k_sampled_core_publication` as a
-- JOIN `insyspo.publicdb_openalex_2023_08_rm.works_ids` as b
-- ON a.doi_alex = b.doi
-- --JOIN `insyspo.userdb_hackaton_san_francisco.df_article_unique_software_count` as cJOIN `insyspo.publicdb_openalex_2023_08_rm.works_related_works` as e
-- JOIN `insyspo.publicdb_openalex_2023_08_rm.works_referenced_works` as c
-- ON a.work_id=c.work_id
-- ORDER BY a.doi_alex


------------------Question 1: domain difference in paper citations
SELECT CONCAT('PMC', REGEXP_EXTRACT(a.L0_publication, r'(\d+)$')) AS L0_pmcid,
       a.L0_domain,d1.n_software AS L0_sw_count,e1.software_id AS L0_sw_id,
       --l1: direct reference
       b.display_name AS L1_domain, 
       CONCAT('PMC', REGEXP_EXTRACT(c.pmcid, r'(\d+)$'))  AS L1_pmcid, 
       d2.n_software AS L1_sw_count, e2.software_id AS L1_sw_id
From `insyspo.userdb_hackaton_san_francisco.10k_sampled_L0_wRef` as a
--Add L1 ref domain
JOIN `insyspo.userdb_hackaton_san_francisco.dois_openalex_concepts_top_concept` as b
ON a.L1_ref_paper=b.work_id
---Convert to pmcid for importing software count
JOIN `insyspo.publicdb_openalex_2023_08_rm.works_ids` as c
ON b.doi_alex=c.doi
----Add L0 software count information
LEFT JOIN `insyspo.userdb_hackaton_san_francisco.df_article_unique_software_count` as d1
ON CONCAT('PMC', REGEXP_EXTRACT(a.L0_publication, r'(\d+)$')) = d1.id
------Add L1 software count information
LEFT JOIN `insyspo.userdb_hackaton_san_francisco.df_article_unique_software_count` as d2
ON CONCAT('PMC', REGEXP_EXTRACT(c.pmcid, r'(\d+)$')) = d2.id
---- Add L0 unique software name
LEFT JOIN `insyspo.userdb_hackaton_san_francisco.df_article_software_id_name` as e1
ON CONCAT('PMC', REGEXP_EXTRACT(a.L0_publication, r'(\d+)$')) = e1.article_id
LEFT JOIN `insyspo.userdb_hackaton_san_francisco.df_article_software_id_name` as e2
ON CONCAT('PMC', REGEXP_EXTRACT(c.pmcid, r'(\d+)$')) = e2.article_id

------SoftwareKG doesn't have the L0 all papers.
WHERE d1.n_software IS NOT NULL
LIMIT 100
-----Add L0 add unique software name
-----Add L1 add unique software name


--------------------------

-- SELECT a.doi_alex, a.work_id, a.pmcid 
-- FROM 
