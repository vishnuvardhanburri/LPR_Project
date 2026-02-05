let
    Source = Csv.Document(File.Contents(File_Path_Parameter & "Camera_Logs.csv"),[Delimiter=",", Columns=4, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    PromoteHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // Type Casting: Crucial for Date/Time Analysis in the Dashboard
    TypedColumns = Table.TransformColumnTypes(PromoteHeaders,{
        {"Log_Timestamp", type datetime}, 
        {"Plate_Detected", type text}, 
        {"Confidence", type number}
    }),
    
    // Standardization to match Master List format
    SanitizedPlates = Table.TransformColumns(TypedColumns, {{"Plate_Detected", each Text.Upper(Text.Trim(_)), type text}})
in
    SanitizedPlates
