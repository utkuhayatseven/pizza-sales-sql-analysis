# Pizza Sales Analysis with SQL Server

## Project Overview

This project analyzes one year of sales data from a pizza restaurant. I used SQL Server to explore order patterns, compare pizza products and categories, and identify periods with high demand.

The main goal was to answer practical business questions using SQL and turn the results into recommendations for the restaurant.

## Dataset

**Source:** [Maven Analytics — Pizza Place Sales](https://mavenanalytics.io/data-playground/pizza-place-sales)

The analysis uses four related tables:

| Table | Description |
| --- | --- |
| `orders` | Order IDs, dates, and times |
| `order_details` | Pizzas and quantities included in each order |
| `pizzas` | Pizza sizes and prices |
| `pizza_types` | Pizza names, categories, and ingredients |

The original CSV files are available from the dataset source. This repository uses SQL Server (T-SQL).

## Tools and SQL Skills

- SQL Server Management Studio (SSMS)
- `JOIN`, `GROUP BY`, `HAVING`, `SUM`, `COUNT`, `CASE WHEN`
- Date functions, subqueries, CTEs, and window functions (`ROW_NUMBER`, `SUM OVER`)

## Data Preparation

I imported the CSV files into SQL Server and checked the data before analyzing it.

During import, some decimal prices were interpreted incorrectly (for example, `12.75` appeared as `1275`). I compared the values with the original `pizzas.csv` file and created the `vw_pizzas_clean` view with corrected prices. The original imported table was left unchanged.

The project also includes SQL checks for duplicate order IDs, missing references, invalid quantities, and the final price range. The results of all checks should be verified before treating the analysis as final.

## Main Questions

1. How many orders were placed and how many pizzas were sold?
2. What were total revenue and average order value?
3. Which pizzas, categories, and sizes generated the most sales?
4. Which hours, weekdays, and months had the highest demand?
5. How do products rank within categories and how does monthly revenue accumulate?

## Key Results

| Metric | Result |
| --- | ---: |
| Total orders | 21,350 |
| Total pizzas sold | 49,574 |
| Total revenue | $817,860.05 |
| Average order value | $38.31 |
| Best-selling pizza (units) | Classic Deluxe — 2,453 |
| Highest-revenue pizza | Thai Chicken — $43,434.25 |
| Highest-revenue category | Classic — $220,053.10 |
| Highest-revenue size | L — $375,318.70 |
| Busiest weekday | Friday — 3,538 orders |
| Busiest hour | 12:00–12:59 — 2,520 orders |
| Highest-revenue month | July — $72,557.90 |

These results were obtained from the SQL query outputs. Before publication, rerun the checks and the KPI queries against the final cleaned price view.

## Findings and Recommendations

- **Units sold and revenue are different measures.** Classic Deluxe sold the most pizzas, but Thai Chicken generated the most revenue. Both measures should be considered when reviewing product performance.
- **Lunch is a high-demand period.** The largest number of orders occurred from 12:00 to 12:59, followed by 13:00 to 13:59. The restaurant could review preparation capacity and staffing during these hours.
- **Friday had the highest order count.** This can be useful when planning ingredients and shifts, although individual dates and other operational factors should also be checked.
- **Classic pizzas and large sizes account for substantial revenue.** Their demand should be considered in inventory and menu planning.
- **Monthly revenue varies.** July had the highest revenue and October the lowest in this dataset. One year of records is not enough to establish a recurring seasonal pattern.

## Project Files

Run the SQL files in this order after importing the data:

```text
sql/
  00_price_cleaning.sql
  01_data_quality.sql
  02_sales_kpis.sql
  03_product_analysis.sql
  04_time_analysis.sql
  05_advanced_analysis.sql
```

1. Create a SQL Server database named `PizzaSalesDB`.
2. Import the four original CSV files as `dbo.orders`, `dbo.order_details`, `dbo.pizzas`, and `dbo.pizza_types`. Check column types, especially dates, times, and numeric fields.
3. Run `00_price_cleaning.sql` to create `dbo.vw_pizzas_clean` using prices from the original CSV.
4. Run `01_data_quality.sql` and inspect any returned exceptions. Confirm that there are 96 pizza variants and that the cleaned price range is $9.75–$35.95.
5. Run the remaining analysis scripts in order. Check that the category-level and monthly revenue totals reconcile with total revenue.

## Limitations

The dataset does not include customer identities, ingredient costs, staffing schedules, or profit margins. For this reason, the analysis focuses on sales and demand rather than customer retention or profitability. Suggestions about staffing and inventory would require operational data before implementation.

## Data Attribution

Dataset: **Pizza Place Sales**, Maven Analytics Data Playground. This is an educational portfolio project, not analysis of a restaurant I worked for.
