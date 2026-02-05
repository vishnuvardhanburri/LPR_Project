
# Enterprise LPR Data Reconciliation & Analytics Engine

Automated ETL Pipeline and Multi-Source Security Analytics Dashboard

---

## Executive Summary

This project implements an automated data reconciliation and analytics system for License Plate Recognition (LPR) operations. It ingests high-volume CSV telemetry from fixed cameras, validates and transforms incoming data, reconciles captured plates against authorized master datasets, and delivers operational insights through a structured analytical model and executive dashboard.

The system replaces manual spreadsheet workflows with a layered ETL architecture built using Power Query (M) and the Excel Data Model (Power Pivot), improving reliability, scalability, and data integrity.

---

## Architecture Overview

```mermaid
flowchart TD
    A[Camera CSV Logs] --> B[Ingestion Layer - Power Query Folder Connector]
    B --> C[Transformation Layer - Validation and Normalization]
    C --> D[Reconciliation Engine - Left Anti Join Logic]
    D --> E[Analytical Data Model - Power Pivot xVelocity]
    E --> F[Executive Dashboard]
````

### Design Principles

* Query-driven processing instead of formula-heavy spreadsheets
* Separation of ingestion, transformation, and analytics layers
* Engine-level calculations for improved performance
* Deterministic and repeatable workflows

---

## ETL Pipeline

### Extraction

* Folder-based CSV ingestion
* Automatic inclusion of new files
* Parameter-driven configuration for portability

### Transformation

* License plate normalization
* Timestamp parsing and alignment
* Data type enforcement
* Schema validation

Example:

```m
Table.TransformColumnTypes(Source, {{"PlateNumber", type text}})
```

### Reconciliation Logic

Unauthorized entries detected using Left Anti Join:

```m
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
```

---

## Analytical Data Model

Relationships:

* Authorized Vehicles (1) → Camera Logs (N)

Example Measures:

* Unauthorized Entry Count
* Unique Plate Frequency
* Peak Traffic Hour
* Camera Activity Distribution

Benefits:

* Columnar in-memory engine
* Faster aggregations
* Reduced memory overhead

---

## Dashboard Capabilities

* Security alerts for unauthorized vehicles
* Time-series traffic analysis
* Camera utilization metrics
* Executive operational monitoring

---

## Performance & Scalability

* Power Pivot xVelocity engine
* Query-based transformations
* Measures instead of calculated columns
* Designed for datasets exceeding 100k+ rows within Excel limits

---

## Data Integrity & Error Handling

* Schema validation during ingestion
* Explicit data typing
* Protected worksheets to prevent accidental edits
* Parameter-driven configuration

---

## Deployment

1. Place CSV logs into ingestion folder
2. Refresh Power Query connections
3. Data model recalculates automatically
4. Dashboard updates

---

## Repository Structure

```
/data
/workbook
/docs
```

---

## Author

Vishnu Vardhan Burri
Senior Data Analyst & Solutions Architect
