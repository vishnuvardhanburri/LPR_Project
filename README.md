
Enterprise LPR Data Reconciliation & Analytics Engine
Automated ETL Pipeline and Multi-Source Security Analytics Dashboard
---

Executive Summary

This project implements an automated data reconciliation and analytics system for License Plate Recognition (LPR) operations. It ingests high-volume CSV telemetry from fixed cameras, validates and transforms incoming data, reconciles captured plates against authorized master datasets, and provides operational insights through a structured analytical model and dashboard.

The solution replaces manual spreadsheet workflows with a structured ETL pipeline built using Power Query (M) and the Excel Data Model (Power Pivot), improving reliability, scalability, and data integrity.


---

Architecture

CSV Camera Logs
      │
      ▼
Ingestion Layer (Folder Connector)
      │
      ▼
Transformation Layer
 - Data normalization
 - Schema validation
 - Cleaning & typing
      │
      ▼
Reconciliation Engine
 - Left Anti Join (Unauthorized detection)
      │
      ▼
Analytical Data Model (Power Pivot)
      │
      ▼
Executive Dashboard

Principles

Query-driven processing

Separation of ingestion, transformation, and analytics

Engine-level calculations instead of worksheet formulas

Repeatable and deterministic processing



---

ETL Pipeline

Extraction

Folder-based CSV ingestion

Automatic inclusion of new files

Parameter-driven path configuration


Transformation

License plate normalization

Timestamp formatting

Data type enforcement

Schema validation


Example:

Table.TransformColumnTypes(Source, {{"PlateNumber", type text}})

Reconciliation Logic

Unauthorized entries detected using Left Anti Join:

let
    AuthorizedList = Table.TransformColumnTypes(Source_Master, {{"Plate", type text}}),
    CameraLogs = Table.TransformColumnTypes(Source_Logs, {{"PlateNumber", type text}}),

    MismatchedRecords = Table.NestedJoin(
        CameraLogs, {"PlateNumber"},
        AuthorizedList, {"Plate"},
        "Match",
        JoinKind.LeftAnti
    ),

    FinalClean = Table.RemoveColumns(MismatchedRecords, {"Match"})
in
Got it. One final README — with visual architecture so it looks senior and easy to understand quickly (this helps hiring managers scan in seconds).

Copy this as your final README.md.


---

Enterprise LPR Data Reconciliation & Analytics Engine

Automated ETL Pipeline and Multi-Source Security Analytics Dashboard


---

Executive Summary

This project implements an automated data reconciliation and analytics system for License Plate Recognition (LPR) operations. It ingests high-volume CSV telemetry from fixed cameras, validates and transforms incoming data, reconciles captured plates against authorized master datasets, and delivers operational insights through a structured analytical model and executive dashboard.

The system replaces manual spreadsheet workflows with a layered ETL architecture built using Power Query (M) and the Excel Data Model (Power Pivot), improving reliability, scalability, and data integrity.


---

Architecture Overview

System Flow

+--------------------+
|   Camera CSV Logs  |
+--------------------+
           |
           v
+----------------------------+
|   Ingestion Layer          |
|   Power Query Folder Input |
+----------------------------+
           |
           v
+----------------------------+
|   Transformation Layer     |
|   - Schema validation      |
|   - Plate normalization    |
|   - Timestamp formatting   |
+----------------------------+
           |
           v
+----------------------------+
|   Reconciliation Engine    |
|   Left Anti Join Logic     |
|   Unauthorized Detection   |
+----------------------------+
           |
           v
+----------------------------+
|   Analytical Data Model    |
|   Power Pivot (xVelocity)  |
+----------------------------+
           |
           v
+----------------------------+
|   Executive Dashboard      |
|   Security & Ops Insights  |
+----------------------------+

Design Principles

Query-driven processing instead of formula-heavy sheets

Separation of ingestion, transformation, and analytics layers

Engine-level calculations for performance

Deterministic, repeatable workflows



---

ETL Pipeline

Extraction

Folder-based CSV ingestion

Automatically detects new files

Parameter-driven configuration for portability


Transformation

License plate normalization (string cleanup)

Timestamp parsing and alignment

Data type enforcement

Schema validation


Example:

Table.TransformColumnTypes(Source, {{"PlateNumber", type text}})

Reconciliation Logic

Unauthorized entries identified using Left Anti Join:

let
    AuthorizedList = Table.TransformColumnTypes(Source_Master, {{"Plate", type text}}),
    CameraLogs = Table.TransformColumnTypes(Source_Logs, {{"PlateNumber", type text}}),

    MismatchedRecords = Table.NestedJoin(
        CameraLogs, {"PlateNumber"},
        AuthorizedList, {"Plate"},
        "Match",
        JoinKind.LeftAnti
    ),

    FinalClean = Table.RemoveColumns(MismatchedRecords, {"Match"})
in
    FinalClean


---

Analytical Data Model

Relationships:

Authorized Vehicles (1) → Camera Logs (N)


Example Measures:

Unauthorized Entry Count

Unique Plate Frequency

Peak Traffic Hour

Camera Activity Distribution


Advantages:

Columnar in-memory engine

Faster aggregations

Reduced memory usage



---

Dashboard

Executive dashboard provides:

Security alerts for unauthorized vehicles

Time-series traffic analysis

Camera utilization metrics

High-level operational monitoring



---

Performance Strategy

Power Pivot xVelocity engine

Query-based transformation pipeline

Measures preferred over calculated columns

Designed for datasets exceeding 100k+ rows within Excel constraints



---

Data Integrity & Error Handling

Schema validation during ingestion

Explicit data typing

Protected worksheets to prevent accidental edits

Controlled parameter configuration



---

Deployment

1. Place CSV logs into ingestion folder.


2. Update folder parameter if directory changes.


3. Refresh Power Query connections.


4. Data model recalculates automatically.


5. Dashboard updates.




---

Repository Structure

/data
/workbook
/docs


---

Author

Vishnu Vardhan Burri
Senior Data Analyst & Solutions Architect
