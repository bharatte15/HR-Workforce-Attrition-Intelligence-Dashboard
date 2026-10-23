# Employee Attrition Analysis: Excel, Python and Power BI

An end-to-end HR analytics project that answers one business question:

> **Which factors drive employee attrition, and how can the organization reduce turnover and improve retention?**

The same analysis is built three ways, so each tool's result can be checked against the others:

| Tool | Role in the project |
|---|---|
| **Excel** | Formula-driven analysis workbook: data prep, attrition tables, cross-tabs, dashboard, insights |
| **Python** | Cleaning, EDA, attrition-risk model, Power BI data exports |
| **Power BI** | Data model, DAX measures and a three-page interactive dashboard |

> **Data note:** the dataset is **synthetic** (2,000 employees, exits Jan 2022 to Dec 2025, IBM-HR style) with deliberate data-quality issues. The patterns in it were built in for demonstration, so they are not real-world findings. The pipeline runs unchanged on real data with the same 14 columns.

## Key results (sample data)

| Metric | Value |
|---|---|
| Employees / active / leavers | 2,000 / 1,265 / 735 |
| Cumulative attrition (leavers / employees) | 36.8% |
| Average annual attrition (leavers / average headcount) | 14.6% (15.5%, 16.1%, 13.8%, 13.0% for 2022-2025) |
| Voluntary share of exits | 75.8% |
| Overtime vs no overtime | 47.7% vs 32.3% |
| Job satisfaction 1 vs 4 | 51.3% vs 22.2% |
| Highest-risk tenure band | 0-1 years (52.8%) |
| Hotspots | Customer Support department, Associate role |
| Peak quarter / peak month | 2023-Q4 / April |

Two attrition measures are used deliberately. **Segment charts** show cumulative leavers divided by employees ever in the segment. **Time trends** show leavers divided by average headcount, which is an annual-style rate. Each chart is labelled with the one it uses.

## Repository structure

```
.
├── README.md
├── attrition_pipeline.py              # Python: clean, EDA, risk model, exports
├── employee_attrition_clean.csv       # Power BI fact table (2,000 rows)
├── dim_date.csv                       # Power BI date dimension
├── feature_importance.csv             # Risk-model drivers (optional Python visual)
├── reference_yearly_attrition.csv     # Independent answers for validating DAX
├── reference_quarterly_attrition.csv
├── attrition_dashboard_python.png     # One-page Python dashboard
├── DAX_measures.dax                   # All Power BI measures, commented
├── PowerQuery_load.m                  # Typed load queries
├── attrition_theme.json               # Power BI theme
├── PowerBI_Build_Guide.md             # Step-by-step dashboard build
└── Employee_Attrition_Analysis.xlsx   # Excel workbook (copy it here from the Excel deliverable)
```

## Method

**1. Data preparation**
- Standardized headers and types, trimmed text, mapped `M`/`F` and mixed-case labels to consistent values.
- Blank performance ratings and job-satisfaction scores are imputed with the median (3). Blank ages stay blank and are reported as `Unknown`.
- Leavers with no recorded type or reason are kept and shown as `Unknown` / `Not Recorded`.
- Derived fields: `Attrition_Flag`, `Tenure_Years`, age band, tenure band, performance group, exit year, quarter and month.
- Checks: duplicate IDs, exit-before-hire dates and unrecognised codes (all zero in the sample).

**2. Analysis**
- Attrition by department, job role, gender, education, age, tenure, performance and satisfaction.
- Voluntary vs involuntary split with exit reasons for each.
- Yearly, quarterly and seasonal trends, plus a role × department heatmap.
- An illustrative cost estimate (replacement cost as a share of annual salary).

**3. Risk model (Python)**
- Logistic regression on role, department, tenure, income, satisfaction, overtime and a few other fields.
- Out-of-fold ROC-AUC is about 0.75, so it is useful for ranking but not precise.
- `Risk_Score` is a **relative ranking, not a probability**. `Risk_Band` marks the top 10% of active employees as High and the next 20% as Medium.
- Use it to prioritise stay-conversations, not to make decisions about individuals.

## How to run

**Python**

```bash
pip install pandas openpyxl matplotlib scikit-learn
python attrition_pipeline.py Employee_Attrition_Analysis.xlsx powerbi_output
```

Input is a sheet named `Raw_Data` in an `.xlsx` file, or a CSV, with these columns in order: Emp ID, Hire Date, Exit Date, Age, gender, Education Level, department, Job Role, Perf Rating, Job Satisfaction, Monthly Income, Attrition Type, Exit Reason, OverTime.

**Power BI**
1. Load the CSVs with `PowerQuery_load.m` and mark `DimDate` as the date table.
2. Relate `DimDate[Date]` to `Employees[Exit_Date]` (active) and `Employees[Hire_Date]` (inactive).
3. Add the measures from `DAX_measures.dax` and apply `attrition_theme.json`.
4. Follow `PowerBI_Build_Guide.md` for the three report pages and the validation table.

**Excel**
- Open `Employee_Attrition_Analysis.xlsx`. Paste your own data into `Raw_Data` and everything recalculates.
- Native PivotTables and slicers can be added from the `Clean_Data` table (steps are on the `Pivots` tab).

## Validation

The three tools agree on the sample data. Python computed the yearly rates and segment percentages independently, and they match the Excel workbook exactly. The Power BI numbers should be checked against the table in `PowerBI_Build_Guide.md` and the reference CSVs once the model is built.

## Recommendations the analysis supports

1. **Cap sustained overtime** and rebalance workloads. Overtime is the clearest controllable driver.
2. **Strengthen the first three years:** structured onboarding, 30/90/180-day check-ins and career conversations at 12 months.
3. **Benchmark pay and clarify promotion paths** for hotspot roles, since compensation and career growth lead the voluntary exit reasons.
4. **Act on low satisfaction early** with pulse surveys and stay-interviews for anyone scoring 1-2.
5. **Time retention efforts** around appraisal cycles and organizational change, when exits peak.

## Limitations

- Synthetic data, so effect sizes are illustrative.
- The replacement-cost assumption (50% of annual salary) is a placeholder for an HR or finance figure.
- The risk model is cross-sectional: tenure for leavers is measured at exit, so scores are a prioritisation aid only.
- The `.pbix` file is not included; the build guide recreates it.

## Tech stack

Excel (COUNTIFS, SUMPRODUCT, named ranges, conditional formatting) · Python (pandas, scikit-learn, matplotlib) · Power BI (Power Query, DAX)
