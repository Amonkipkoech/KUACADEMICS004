page 40022 xylist
{
    Caption = 'Unit Coverage';
    PageType = ListPart;
    SourceTable = "XY form Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Time"; Rec."Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
                field("Rotation Area"; Rec."Rotation Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rotation Area field.', Comment = '%';
                }
                field("Unit   Coverage"; Rec."Unit   Coverage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Description Covered field.', Comment = '%';
                }
                field("Duration Hours"; Rec."Duration Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Duration Hours';
                    ToolTip = 'Specifies the value of the Unit Description Covered field.', Comment = '%';
                }
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
                    FieldRefs[5] := RecRef.Field(5); // Replace with the correct field ID for "Duration Hours"
                    FieldRefLength := 5;

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
                    FieldRefs[5] := RecRef.Field(5); // Replace with the correct field ID for "Duration Hours"
                    FieldRefLength := 5;

                    // Call ImportCsvFile
                    CsvHandler.ImportCsvFile('UnitCoverageImport.csv', RecRef, FieldRefs, FieldRefLength);

                    // Refresh the page to show imported data
                    CurrPage.Update();
                end;
            }
        }
    }
}
