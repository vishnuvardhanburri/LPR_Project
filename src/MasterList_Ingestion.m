let
    // Dynamically pull data from CSV
    Source = Csv.Document(File.Contents(File_Path_Parameter & "Authorized_List.csv"),[Delimiter=",", Columns=3, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    PromoteHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // Data Sanitization: Ensure plates are Uppercase and Trimmed of whitespace
    CleanedPlates = Table.TransformColumns(PromoteHeaders, {{"Plate", each Text.Upper(Text.Trim(_)), type text}}),
    
    // Remove duplicates to ensure a clean 1:N relationship in the Data Model
    RemoveDuplicates = Table.Distinct(CleanedPlates, {"Plate"})
in
    RemoveDuplicates
