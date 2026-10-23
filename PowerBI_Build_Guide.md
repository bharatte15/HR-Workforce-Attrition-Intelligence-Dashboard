# HR Attrition Intelligence: Power BI Build Guide

Files: `attrition_powerbi_ready.csv` (1,470 rows) is your cleaned data plus the columns below. Build time is about 30 minutes.

**Columns added:** `attrition_flag` (1 = left), `predicted_risk` (0–1, from your logistic regression), `risk_tier` (High ≥ 0.5, Medium 0.25–0.5, Low < 0.25), and four band columns (`tenure_band`, `age_band`, `promotion_band`, `income_band`) each with a `_sort` column.

## 1. Load and prepare
1. Home → Get data → Text/CSV → `attrition_powerbi_ready.csv` → Transform data.
2. Rename the table to **HR**. Confirm `attrition_flag` and `predicted_risk` are numeric. Close and Apply.
3. Sort each band by its `_sort` column: select `tenure_band` → Column tools → Sort by column → `tenure_band_sort`. Repeat for `age_band`, `promotion_band`, `income_band`, `risk_tier`.
4. Optional: Home → Themes → Browse for themes, using the palette in section 4.

## 2. DAX measures
Create a table with Home → Enter data named `_Measures`, then add these.

```DAX
Total Employees = COUNTROWS(HR)
Employees Left = CALCULATE(COUNTROWS(HR), HR[attrition] = "Yes")
Active Employees = [Total Employees] - [Employees Left]
Attrition Rate = DIVIDE([Employees Left], [Total Employees])
Company Attrition Rate = CALCULATE([Attrition Rate], ALL(HR))
Rate vs Company = [Attrition Rate] - [Company Attrition Rate]
High Risk Active = CALCULATE(COUNTROWS(HR), HR[attrition] = "No", HR[risk_tier] = "High")
Avg Tenure Leavers = CALCULATE(AVERAGE(HR[yearsatcompany]), HR[attrition] = "Yes")
Avg Tenure Stayers = CALCULATE(AVERAGE(HR[yearsatcompany]), HR[attrition] = "No")
Avg Income Leavers = CALCULATE(AVERAGE(HR[monthlyincome]), HR[attrition] = "Yes")
Avg Income Stayers = CALCULATE(AVERAGE(HR[monthlyincome]), HR[attrition] = "No")
Overtime Attrition Rate = CALCULATE([Attrition Rate], HR[overtime] = "Yes")
No Overtime Attrition Rate = CALCULATE([Attrition Rate], HR[overtime] = "No")
Avg Job Satisfaction Leavers = CALCULATE(AVERAGE(HR[jobsatisfaction]), HR[attrition] = "Yes")
Avg Job Satisfaction Stayers = CALCULATE(AVERAGE(HR[jobsatisfaction]), HR[attrition] = "No")
Rate Colour = IF([Rate vs Company] > 0.03, "#D1495B", IF([Rate vs Company] < -0.03, "#3D8B6E", "#2F5D8A"))
```

Set `Attrition Rate`, `Company Attrition Rate` and `Rate vs Company` to Percentage with 1 decimal.

## 3. Report pages

### Page 1: Executive overview
- **Slicers (top row):** `department`, `gender`, `overtime`, `businesstravel`. Style as dropdowns.
- **Cards:** Attrition Rate, Active Employees, Employees Left, High Risk Active.
- **Clustered bar:** Axis `department`, Values `Attrition Rate`. Conditional colour: Format → Bars → fx → Field value → `Rate Colour`.
- **Column chart:** Axis `tenure_band`, Values `Attrition Rate`.
- **Donut:** Legend `attrition`, Values `Total Employees`.
- **Bar chart:** Axis `jobrole`, Values `Attrition Rate`, sorted descending. Title it "Which roles lose the most people".

### Page 2: Drivers
- **Clustered column:** Axis `overtime`, Values `Attrition Rate`.
- **Column charts (one each):** `promotion_band`, `income_band`, `age_band` against `Attrition Rate`.
- **Matrix heat map:** Rows `department`, Columns `overtime`, Values `Attrition Rate`. Format → Cell elements → Background colour → gradient (white to #D1495B).
- **Table:** Stayers vs leavers. Add `Avg Tenure Stayers`, `Avg Tenure Leavers`, `Avg Income Stayers`, `Avg Income Leavers`, `Avg Job Satisfaction Stayers`, `Avg Job Satisfaction Leavers`.
- **Decomposition tree:** Analyze `Employees Left`, Explain by `department`, `jobrole`, `overtime`, `maritalstatus`, `businesstravel`.

### Page 3: Retention watchlist
- **Visual-level filters:** `attrition` = No, `risk_tier` = High.
- **Table:** `employeenumber`, `department`, `jobrole`, `yearsatcompany`, `monthlyincome`, `overtime`, `predicted_risk`. Sort by `predicted_risk` descending. Add data bars on `predicted_risk`.
- **Cards:** High Risk Active, plus the average of `predicted_risk` for the filtered group.
- **Text box (model note):** "Logistic regression: accuracy 86%, precision 62%, recall 34% for leavers. Use scores to prioritise conversations, not employment decisions."
- Add a **drill-through** page: right-click an employee → Drill through, filtered by `employeenumber`.

## 4. Suggested design
- Page background `#EEF2F6`, visual background white, title colour `#14213D`.
- Bars `#2F5D8A`, high risk `#D1495B`, positive `#3D8B6E`, warning `#E9A23B`.
- Font Segoe UI, titles 14 pt, card values 28 pt. Align everything to the grid and keep one row of slicers.
- Turn on Sync slicers (View → Sync slicers) so filters carry across pages.
- Add page navigation buttons (Insert → Buttons → Navigator → Page navigator).

## 5. Before you publish
- Replace `risk_tier` thresholds if your HR team prefers other cut-offs; edit the CSV or recreate the column in DAX.
- Predicted risk is scored with a model trained on this same data, so it looks slightly better than it would on new employees.
- Refresh: re-run your Python modeling notebook on new data and replace the CSV. Power BI then refreshes in one click.
