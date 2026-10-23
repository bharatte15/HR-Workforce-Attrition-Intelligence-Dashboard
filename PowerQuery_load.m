// =====================================================================================
// POWER QUERY (M) - load the three files produced by attrition_pipeline.py
// Home > Get Data > Blank Query > Advanced Editor. Create one query per block below.
// First create a text parameter  FolderPath  (Manage Parameters), e.g.  C:\Projects\attrition\powerbi_output\
// =====================================================================================

// ---------- Query: Employees ----------------------------------------------------------
let
    Source   = Csv.Document(File.Contents(FolderPath & "employee_attrition_clean.csv"),
                            [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed    = Table.TransformColumnTypes(Promoted, {
        {"Employee_ID", type text}, {"Hire_Date", type date}, {"Exit_Date", type date},
        {"Age", Int64.Type}, {"Gender", type text}, {"Education", type text},
        {"Department", type text}, {"Job_Role", type text},
        {"Performance_Rating", Int64.Type}, {"Job_Satisfaction", Int64.Type},
        {"Monthly_Income", Int64.Type}, {"Overtime", type text},
        {"Attrition_Flag", Int64.Type}, {"Attrition_Type", type text}, {"Exit_Reason", type text},
        {"Tenure_Years", type number}, {"Age_Band", type text}, {"Tenure_Band", type text},
        {"Perf_Group", type text}, {"Exit_Year", Int64.Type}, {"Exit_Quarter", type text},
        {"Exit_Month", Int64.Type}, {"Risk_Score", type number}, {"Risk_Band", type text},
        {"Age_Band_Order", Int64.Type}, {"Tenure_Band_Order", Int64.Type}, {"Perf_Group_Order", Int64.Type}
    }, "en-US")
in
    Typed

// ---------- Query: DimDate ------------------------------------------------------------
let
    Source   = Csv.Document(File.Contents(FolderPath & "dim_date.csv"),
                            [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed    = Table.TransformColumnTypes(Promoted, {
        {"Date", type date}, {"Year", Int64.Type}, {"Quarter_Num", Int64.Type},
        {"Year_Quarter", type text}, {"Quarter_Key", Int64.Type}, {"Month_Num", Int64.Type},
        {"Month", type text}, {"Year_Month", type text}, {"Month_Year", type text}
    }, "en-US")
in
    Typed

// ---------- Query: FeatureImportance (feeds the optional Python visual) ----------------
let
    Source   = Csv.Document(File.Contents(FolderPath & "feature_importance.csv"),
                            [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    Typed    = Table.TransformColumnTypes(Promoted, {{"Feature", type text}, {"Importance", type number}}, "en-US")
in
    Typed

// ---------- OPTIONAL: run the Python pipeline from inside Power Query -----------------
// Needs Python configured in File > Options > Python scripting. Refresh runs on the desktop (or a personal gateway),
// so for the Power BI Service the CSV route above is simpler. Home > Get Data > Python script, paste:
//
//   import pandas as pd
//   employees = pd.read_csv(r"C:\Projects\attrition\powerbi_output\employee_attrition_clean.csv",
//                           parse_dates=["Hire_Date", "Exit_Date"])
//
// then pick the `employees` table in the Navigator.
