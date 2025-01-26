page 40010 "Clinical Rotation List Part"

{
    PageType = ListPart;

    SourceTable = "Clinical Rotation"; // This should be a separate table for managing weekly rotations

    Caption = 'Clinical Rotation List';

    layout
    {
        area(content)
        {
            repeater("clinical rotation")
            {
                field("Plan ID"; rec."Plan ID")
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field(Session; rec.Session)
                {
                    ApplicationArea = all;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = all;
                }
                field(program; rec.program)
                {
                    ApplicationArea = all;
                }

                field(Group; rec.Group)
                {
                    ApplicationArea = all;
                    

                }
                field(Areas; rec.Areas)
                {
                    ApplicationArea = all;
                    TableRelation = Lab."Area cODE";


                }
                field("Week No"; rec."No Of Students")
                {
                    ApplicationArea = all;
                    DrillDownPageID = "Group Assignmnets ";

                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;

                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;

                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;

                }
                // field(Status; rec.Status)
                // {
                //     ApplicationArea = all;
                // }

                // Continue with fields up to Site Week 52...
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("ExportCSV")
            {
                Caption = 'Export to CSV';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    FieldRefs: array[20] of FieldRef;
                    FieldRefLength: Integer;
                    CsvHandler: Codeunit "Csv Handler";
                begin
                    // Initialize RecordRef
                    RecRef.GetTable(Rec);

                    // Define FieldRefs for export using explicit field IDs
                    FieldRefs[1] := RecRef.Field(1); // Replace with the correct field ID for "Date"
                    FieldRefs[2] := RecRef.Field(2); // Replace with the correct field ID for "Time"
                    FieldRefs[3] := RecRef.Field(3); // Replace with the correct field ID for "Rotation Area"
                    FieldRefs[4] := RecRef.Field(4); // Replace with the correct field ID for "Unit Coverage"
                    FieldRefs[5] := RecRef.Field(5);
                    FieldRefs[6] := RecRef.Field(6);
                    FieldRefs[7] := RecRef.Field(7);// Replace with the correct field ID for "Duration Hours"
                    FieldRefLength := 7;

                    // Call ExportCsvFile
                    CsvHandler.ExportCsvFile('UnitCoverageExport', RecRef, FieldRefs, FieldRefLength);
                end;
            }
              
            action("ImportCSV")
            {
                Caption = 'Import from CSV';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    FieldRefs: array[20] of FieldRef;
                    FieldRefLength: Integer;
                    CsvHandler: Codeunit "Csv Handler";
                begin
                    // Initialize RecordRef
                    RecRef.GetTable(Rec);

                    // Define FieldRefs for import using explicit field IDs
                    FieldRefs[1] := RecRef.Field(1); // Replace with the correct field ID for "Date"
                    FieldRefs[2] := RecRef.Field(2); // Replace with the correct field ID for "Time"
                    FieldRefs[3] := RecRef.Field(3); // Replace with the correct field ID for "Rotation Area"
                    FieldRefs[4] := RecRef.Field(4); // Replace with the correct field ID for "Unit Coverage"
                    FieldRefs[5] := RecRef.Field(5);
                    FieldRefs[6] := RecRef.Field(6);
                    FieldRefs[7] := RecRef.Field(7);

                    // Call ImportCsvFile
                    CsvHandler.ImportCsvFile('UnitCoverageImport.csv', RecRef, FieldRefs, FieldRefLength);

                    // Refresh the page to show imported data
                    CurrPage.Update();
                end;
            }
        }
    }
}

