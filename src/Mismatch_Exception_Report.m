let
    // Reference the two cleaned queries
    Logs = CameraLogs_Processing,
    Master = MasterList_Ingestion,

    // Performance Optimized Left Anti-Join
    // This keeps only rows from Logs that do NOT exist in Master
    FindExceptions = Table.NestedJoin(Logs, {"Plate_Detected"}, Master, {"Plate"}, "MatchResult", JoinKind.LeftAnti),
    
    // Clean up the join column
    Output = Table.RemoveColumns(FindExceptions,{"MatchResult"})
in
    Output
