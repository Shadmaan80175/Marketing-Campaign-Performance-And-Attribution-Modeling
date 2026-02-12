WITH base_sessions AS (
    SELECT
        s.session_id,
        s.user_id,
        s.source,
        s.campaign,
        u.country,
        DATE(s.session_date) AS day
    FROM sessions s
    JOIN users u ON s.user_id = u.user_id
),

session_counts AS (
    SELECT
        source,
        campaign,
        country,
        day,
        COUNT(session_id) AS total_sessions
    FROM base_sessions
    GROUP BY source, campaign, country, day
),

conversion_details AS (
    SELECT
        bs.session_id,
        bs.user_id,
        bs.source,
        bs.campaign,
        bs.country,
        bs.day,
        c.conversion_id,
        c.revenue
    FROM base_sessions bs
    JOIN conversions c
        ON bs.user_id = c.user_id
       AND bs.day <= DATE(c.conversion_date)
),

conversion_counts AS (
    SELECT
        source,
        campaign,
        country,
        day,
        COUNT(conversion_id) AS total_conversions,
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS avg_revenue_per_conversion
    FROM conversion_details
    GROUP BY source, campaign, country, day
),

daily_spend AS (
    SELECT
        source,
        campaign,
        spend_date AS day,
        SUM(cost) AS total_cost
    FROM ad_spend
    GROUP BY source, campaign, spend_date
),

combined_metrics AS (
    SELECT
        cc.source,
        cc.campaign,
        cc.country,
        cc.day,
        sc.total_sessions,
        cc.total_conversions,
        cc.total_revenue,
        cc.avg_revenue_per_conversion,
        ds.total_cost
    FROM conversion_counts cc
    JOIN session_counts sc
        ON cc.source = sc.source
       AND cc.campaign = sc.campaign
       AND cc.country = sc.country
       AND cc.day = sc.day
    JOIN daily_spend ds
        ON cc.source = ds.source
       AND cc.campaign = ds.campaign
       AND cc.day = ds.day
),

kpi_calculations AS (
    SELECT
        *,
        ROUND(total_conversions::numeric / total_sessions * 100, 2) AS conversion_rate_percent,
        ROUND(total_cost / total_conversions, 2) AS cpa,
        ROUND(total_revenue / total_cost, 2) AS roas,
        ROUND(total_revenue / total_sessions, 2) AS revenue_per_session
    FROM combined_metrics
),

rolling_metrics AS (
    SELECT
        *,
        SUM(total_revenue) OVER (
            PARTITION BY source, campaign, country
            ORDER BY day
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS rolling_7day_revenue,

        AVG(total_revenue) OVER (
            PARTITION BY source, campaign, country
            ORDER BY day
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS rolling_7day_avg_revenue
    FROM kpi_calculations
),

growth_metrics AS (
    SELECT
        *,
        LAG(total_revenue) OVER (
            PARTITION BY source, campaign, country
            ORDER BY day
        ) AS previous_day_revenue
    FROM rolling_metrics
),

final_growth AS (
    SELECT
        *,
        ROUND(
            (total_revenue - previous_day_revenue)
            / NULLIF(previous_day_revenue,0) * 100,
            2
        ) AS revenue_growth_percent
    FROM growth_metrics
),

ranking_metrics AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY source
            ORDER BY total_revenue DESC
        ) AS revenue_rank_within_source,

        DENSE_RANK() OVER (
            ORDER BY roas DESC
        ) AS overall_roas_rank
    FROM final_growth
),

percentage_contribution AS (
    SELECT
        *,
        ROUND(
            total_revenue /
            SUM(total_revenue) OVER () * 100,
            2
        ) AS revenue_contribution_percent
    FROM ranking_metrics
)

SELECT *
FROM percentage_contribution
WHERE
    total_sessions > 0
    AND total_conversions > 0
    AND total_revenue > 0
    AND total_cost > 0
ORDER BY day DESC, total_revenue DESC
LIMIT 500;


















