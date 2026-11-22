USE PizzaSalesDB;
GO

-- Prices mapped exactly from the original pizzas.csv (96 rows).
-- Source dbo.pizzas is not modified.
CREATE OR ALTER VIEW dbo.vw_pizzas_clean AS
SELECT
    p.pizza_id,
    p.pizza_type_id,
    p.size,
    v.price
FROM dbo.pizzas AS p
INNER JOIN (
    VALUES
        ('bbq_ckn_s', CAST(12.75 AS DECIMAL(10,2))),
        ('bbq_ckn_m', CAST(16.75 AS DECIMAL(10,2))),
        ('bbq_ckn_l', CAST(20.75 AS DECIMAL(10,2))),
        ('cali_ckn_s', CAST(12.75 AS DECIMAL(10,2))),
        ('cali_ckn_m', CAST(16.75 AS DECIMAL(10,2))),
        ('cali_ckn_l', CAST(20.75 AS DECIMAL(10,2))),
        ('ckn_alfredo_s', CAST(12.75 AS DECIMAL(10,2))),
        ('ckn_alfredo_m', CAST(16.75 AS DECIMAL(10,2))),
        ('ckn_alfredo_l', CAST(20.75 AS DECIMAL(10,2))),
        ('ckn_pesto_s', CAST(12.75 AS DECIMAL(10,2))),
        ('ckn_pesto_m', CAST(16.75 AS DECIMAL(10,2))),
        ('ckn_pesto_l', CAST(20.75 AS DECIMAL(10,2))),
        ('southw_ckn_s', CAST(12.75 AS DECIMAL(10,2))),
        ('southw_ckn_m', CAST(16.75 AS DECIMAL(10,2))),
        ('southw_ckn_l', CAST(20.75 AS DECIMAL(10,2))),
        ('thai_ckn_s', CAST(12.75 AS DECIMAL(10,2))),
        ('thai_ckn_m', CAST(16.75 AS DECIMAL(10,2))),
        ('thai_ckn_l', CAST(20.75 AS DECIMAL(10,2))),
        ('big_meat_s', CAST(12 AS DECIMAL(10,2))),
        ('big_meat_m', CAST(16 AS DECIMAL(10,2))),
        ('big_meat_l', CAST(20.5 AS DECIMAL(10,2))),
        ('classic_dlx_s', CAST(12 AS DECIMAL(10,2))),
        ('classic_dlx_m', CAST(16 AS DECIMAL(10,2))),
        ('classic_dlx_l', CAST(20.5 AS DECIMAL(10,2))),
        ('hawaiian_s', CAST(10.5 AS DECIMAL(10,2))),
        ('hawaiian_m', CAST(13.25 AS DECIMAL(10,2))),
        ('hawaiian_l', CAST(16.5 AS DECIMAL(10,2))),
        ('ital_cpcllo_s', CAST(12 AS DECIMAL(10,2))),
        ('ital_cpcllo_m', CAST(16 AS DECIMAL(10,2))),
        ('ital_cpcllo_l', CAST(20.5 AS DECIMAL(10,2))),
        ('napolitana_s', CAST(12 AS DECIMAL(10,2))),
        ('napolitana_m', CAST(16 AS DECIMAL(10,2))),
        ('napolitana_l', CAST(20.5 AS DECIMAL(10,2))),
        ('pep_msh_pep_s', CAST(11 AS DECIMAL(10,2))),
        ('pep_msh_pep_m', CAST(14.5 AS DECIMAL(10,2))),
        ('pep_msh_pep_l', CAST(17.5 AS DECIMAL(10,2))),
        ('pepperoni_s', CAST(9.75 AS DECIMAL(10,2))),
        ('pepperoni_m', CAST(12.5 AS DECIMAL(10,2))),
        ('pepperoni_l', CAST(15.25 AS DECIMAL(10,2))),
        ('the_greek_s', CAST(12 AS DECIMAL(10,2))),
        ('the_greek_m', CAST(16 AS DECIMAL(10,2))),
        ('the_greek_l', CAST(20.5 AS DECIMAL(10,2))),
        ('the_greek_xl', CAST(25.5 AS DECIMAL(10,2))),
        ('the_greek_xxl', CAST(35.95 AS DECIMAL(10,2))),
        ('brie_carre_s', CAST(23.65 AS DECIMAL(10,2))),
        ('calabrese_s', CAST(12.25 AS DECIMAL(10,2))),
        ('calabrese_m', CAST(16.25 AS DECIMAL(10,2))),
        ('calabrese_l', CAST(20.25 AS DECIMAL(10,2))),
        ('ital_supr_s', CAST(12.5 AS DECIMAL(10,2))),
        ('ital_supr_m', CAST(16.5 AS DECIMAL(10,2))),
        ('ital_supr_l', CAST(20.75 AS DECIMAL(10,2))),
        ('peppr_salami_s', CAST(12.5 AS DECIMAL(10,2))),
        ('peppr_salami_m', CAST(16.5 AS DECIMAL(10,2))),
        ('peppr_salami_l', CAST(20.75 AS DECIMAL(10,2))),
        ('prsc_argla_s', CAST(12.5 AS DECIMAL(10,2))),
        ('prsc_argla_m', CAST(16.5 AS DECIMAL(10,2))),
        ('prsc_argla_l', CAST(20.75 AS DECIMAL(10,2))),
        ('sicilian_s', CAST(12.25 AS DECIMAL(10,2))),
        ('sicilian_m', CAST(16.25 AS DECIMAL(10,2))),
        ('sicilian_l', CAST(20.25 AS DECIMAL(10,2))),
        ('soppressata_s', CAST(12.5 AS DECIMAL(10,2))),
        ('soppressata_m', CAST(16.5 AS DECIMAL(10,2))),
        ('soppressata_l', CAST(20.75 AS DECIMAL(10,2))),
        ('spicy_ital_s', CAST(12.5 AS DECIMAL(10,2))),
        ('spicy_ital_m', CAST(16.5 AS DECIMAL(10,2))),
        ('spicy_ital_l', CAST(20.75 AS DECIMAL(10,2))),
        ('spinach_supr_s', CAST(12.5 AS DECIMAL(10,2))),
        ('spinach_supr_m', CAST(16.5 AS DECIMAL(10,2))),
        ('spinach_supr_l', CAST(20.75 AS DECIMAL(10,2))),
        ('five_cheese_s', CAST(12.5 AS DECIMAL(10,2))),
        ('five_cheese_m', CAST(15.5 AS DECIMAL(10,2))),
        ('five_cheese_l', CAST(18.5 AS DECIMAL(10,2))),
        ('four_cheese_s', CAST(11.75 AS DECIMAL(10,2))),
        ('four_cheese_m', CAST(14.75 AS DECIMAL(10,2))),
        ('four_cheese_l', CAST(17.95 AS DECIMAL(10,2))),
        ('green_garden_s', CAST(12 AS DECIMAL(10,2))),
        ('green_garden_m', CAST(16 AS DECIMAL(10,2))),
        ('green_garden_l', CAST(20.25 AS DECIMAL(10,2))),
        ('ital_veggie_s', CAST(12.75 AS DECIMAL(10,2))),
        ('ital_veggie_m', CAST(16.75 AS DECIMAL(10,2))),
        ('ital_veggie_l', CAST(21 AS DECIMAL(10,2))),
        ('mediterraneo_s', CAST(12 AS DECIMAL(10,2))),
        ('mediterraneo_m', CAST(16 AS DECIMAL(10,2))),
        ('mediterraneo_l', CAST(20.25 AS DECIMAL(10,2))),
        ('mexicana_s', CAST(12 AS DECIMAL(10,2))),
        ('mexicana_m', CAST(16 AS DECIMAL(10,2))),
        ('mexicana_l', CAST(20.25 AS DECIMAL(10,2))),
        ('spin_pesto_s', CAST(12.5 AS DECIMAL(10,2))),
        ('spin_pesto_m', CAST(16.5 AS DECIMAL(10,2))),
        ('spin_pesto_l', CAST(20.75 AS DECIMAL(10,2))),
        ('spinach_fet_s', CAST(12 AS DECIMAL(10,2))),
        ('spinach_fet_m', CAST(16 AS DECIMAL(10,2))),
        ('spinach_fet_l', CAST(20.25 AS DECIMAL(10,2))),
        ('veggie_veg_s', CAST(12 AS DECIMAL(10,2))),
        ('veggie_veg_m', CAST(16 AS DECIMAL(10,2))),
        ('veggie_veg_l', CAST(20.25 AS DECIMAL(10,2)))
) AS v(pizza_id, price)
    ON p.pizza_id = v.pizza_id;
GO

-- Verify count, price range and unmatched source IDs.
SELECT COUNT(*) AS TotalPizzaVariants, MIN(price) AS MinPrice, MAX(price) AS MaxPrice
FROM dbo.vw_pizzas_clean;

SELECT p.pizza_id
FROM dbo.pizzas AS p
LEFT JOIN dbo.vw_pizzas_clean AS v ON p.pizza_id = v.pizza_id
WHERE v.pizza_id IS NULL;
