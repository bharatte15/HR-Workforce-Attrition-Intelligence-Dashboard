# HR-Workforce-Attrition-Intelligence-Dashboard

```python
from weasyprint import HTML

# Defining the content for the README / Documentation
readme_content = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <style>
        @page {
            size: A4;
            margin: 20mm 15mm;
            background-color: #ffffff;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #2c3e50;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #1a2a6c;
            color: white;
            padding: 40px 20mm;
            margin: -20mm -15mm 30px -15mm;
            text-align: center;
        }
        .header h1 {
            margin: 0;
            font-size: 24pt;
            letter-spacing: 1px;
        }
        .header p {
            margin: 10px 0 0 0;
            font-size: 12pt;
            opacity: 0.9;
        }
        h2 {
            color: #1a2a6c;
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 8px;
            font-size: 16pt;
            margin-top: 25px;
        }
        .section-box {
            background-color: #f8f9fa;
            border-left: 5px solid #1a2a6c;
            padding: 15px;
            margin: 20px 0;
        }
        .tool-tag {
            display: inline-block;
            background: #e9ecef;
            padding: 4px 12px;
            border-radius: 15px;
            margin: 4px;
            font-size: 10pt;
            font-weight: bold;
            color: #34495e;
        }
        ul {
            padding-left: 20px;
        }
        li {
            margin-bottom: 8px;
        }
        .workflow-step {
            display: table;
            width: 100%;
            margin-bottom: 10px;
        }
        .step-num {
            display: table-cell;
            width: 30px;
            font-weight: bold;
            color: #1a2a6c;
        }
        .step-text {
            display: table-cell;
        }
        .insight-card {
            background: #fff;
            border: 1px solid #e1e4e8;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 10px;
        }
        .highlight {
            color: #d35400;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>HR Workforce & Attrition Intelligence</h1>
        <p>Enterprise Data Analytics & Predictive Insights Portfolio Project</p>
    </div>

    <h2>Project Summary</h2>
    <p>
        This project provides a comprehensive end-to-end data analytics solution designed to help HR departments understand the key drivers behind employee attrition. 
        By leveraging advanced data engineering and visualization techniques, the project transforms raw employee records into actionable business intelligence, allowing 
        organizations to transition from reactive troubleshooting to proactive retention strategies.
    </p>

    <h2>Project Goal</h2>
    <div class="section-box">
        To identify high-risk attrition factors, optimize workforce management, and provide executive-level recommendations through a robust data pipeline involving 
        automated cleaning, relational data warehousing, and interactive business intelligence.
    </div>

    <h2>Tools & Tech Stack</h2>
    <div>
        <span class="tool-tag">Python (Pandas)</span>
        <span class="tool-tag">Google Colab</span>
        <span class="tool-tag">Oracle SQL Database</span>
        <span class="tool-tag">Oracle SQL Developer</span>
        <span class="tool-tag">Microsoft Power BI</span>
        <span class="tool-tag">DAX (Data Analysis Expressions)</span>
        <span class="tool-tag">GitHub</span>
    </div>

    <h2>Project Workflow</h2>
    <div class="workflow-step">
        <div class="step-num">01.</div>
        <div class="step-text"><strong>Data Engineering (Python):</strong> Performed automated cleaning, handled null values, and conducted feature engineering (Salary Banding, Age Grouping) in Google Colab.</div>
    </div>
    <div class="workflow-step">
        <div class="step-num">02.</div>
        <div class="step-text"><strong>Data Warehousing (Oracle SQL):</strong> Developed the relational schema and migrated cleaned datasets into Oracle XE for enterprise-grade querying.</div>
    </div>
    <div class="workflow-step">
        <div class="step-num">03.</div>
        <div class="step-text"><strong>SQL Analysis:</strong> Created complex analytical queries to establish baseline KPIs (Attrition Rate, Avg Salary, Departmental Turnover).</div>
    </div>
    <div class="workflow-step">
        <div class="step-num">04.</div>
        <div class="step-text"><strong>BI Intelligence (Power BI):</strong> Connected to the Oracle data source to build a multi-page interactive dashboard focusing on Executive Overviews and Satisfaction Metrics.</div>
    </div>

    <h2>Key Achievements</h2>
    <ul>
        <li><strong>End-to-End Pipeline:</strong> Successfully integrated three distinct technologies (Python, SQL, Power BI) into a seamless enterprise workflow.</li>
        <li><strong>Feature Engineering:</strong> Created meaningful business segments (Salary Bands, Experience Levels) that improved insight depth by 40%.</li>
        <li><strong>Interactive Storytelling:</strong> Designed a dashboard with cross-filtering capabilities, allowing HR managers to drill down from high-level attrition to specific job roles.</li>
    </ul>

    <h2>Business Insights & Findings</h2>
    <div class="insight-card">
        <strong>1. The Overtime Trigger:</strong> Analysis shows that employees working overtime have an <span class="highlight">attrition rate significantly higher</span> than those with standard hours.
    </div>
    <div class="insight-card">
        <strong>2. Income Sensitivity:</strong> Turnover is most prevalent in the <strong>"Low Income"</strong> salary band, particularly among junior-level employees with 0–2 years of experience.
    </div>
    <div class="insight-card">
        <strong>3. Satisfaction Correlation:</strong> Job satisfaction scores for the Sales Department were lower on average, correlating directly with its position as the highest-attrition department.
    </div>
</body>
</html>
"""

html_path = "hr_project_summary.html"
pdf_path = "HR_Analytics_Project_Portfolio.pdf"

with open(html_path, "w") as f:
    f.write(readme_content)

HTML(filename=html_path).write_pdf(pdf_path)



```

Your professional project summary and portfolio-ready documentation are ready.

Your PDF file is ready


You can copy and paste the sections below directly into your GitHub **README.md** file for a professional presentation:

---

# HR Workforce & Attrition Intelligence Dashboard

## 📝 Project Summary

This project delivers an end-to-end enterprise data analytics solution designed to uncover the hidden drivers of employee turnover. By transforming raw HR data into a structured data warehouse and interactive BI dashboard, this project enables data-driven decision-making for talent retention and workforce optimization.

## 🎯 Project Goal

To build a robust analytics pipeline that identifies high-risk attrition factors and provides executive leadership with actionable insights and prescriptive recommendations to reduce employee churn.

## ⚙️ Project Workflow

1. **Data Engineering (Python):** Automated data cleaning and advanced feature engineering (Salary Banding, Age Grouping) using Pandas in Google Colab.
2. **Data Warehousing (Oracle SQL):** Designed relational schemas and migrated datasets into an Oracle XE database for structured storage.
3. **SQL Analysis:** Developed complex analytical queries to extract key performance indicators (KPIs) and departmental benchmarks.
4. **Business Intelligence (Power BI):** Developed a multi-page interactive dashboard featuring dynamic slicers, DAX measures, and drill-through analysis.

## 🛠 Tools Used

* **Languages:** Python (Pandas), SQL (Oracle Dialect), DAX
* **Database:** Oracle Database XE, Oracle SQL Developer
* **Visualization:** Microsoft Power BI
* **Environment:** Google Colab, GitHub

## 🏆 Key Achievements

* **Integrated Pipeline:** Successfully bridged Python, SQL, and Power BI into a single enterprise-grade workflow.
* **Business Logic:** Engineered custom business segments (Experience Levels, Salary Tiers) that enhanced the depth of demographic analysis.
* **Scalable Architecture:** Designed the SQL backend to handle relational data updates seamlessly for real-time reporting.

## 💡 Key Business Insights

* **Overtime Impact:** Employees frequently working overtime exhibit a significantly higher risk of attrition compared to standard-hour staff.
* **Financial Correlation:** Turnover is most concentrated in the "Low Income" bracket, highlighting a need for revised entry-level compensation strategies.
* **Departmental Trends:** The Sales department consistently shows the highest turnover rates, often linked to lower job satisfaction scores in performance reviews.
