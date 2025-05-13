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
                // field("Plan ID"; rec."Plan ID")
                // {
                //     ApplicationArea = all;
                // }
                // field(Year; rec.Year)
                // {
                //     ApplicationArea = all;
                // }
                // field(Session; rec.Session)
                // {
                //     ApplicationArea = all;
                // }
                // field(Department; rec.Department)
                // {
                //     ApplicationArea = all;
                // }
                // field(program; rec.program)
                // {
                //     ApplicationArea = all;
                // }

                field(Group; rec.Group)
                {
                    ApplicationArea = all;


                }
                field(Areas; rec.Areas)
                {
                    ApplicationArea = all;



                }
                field(Week; rec.week)
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

                field(Month; rec.Month)
                {
                    ApplicationArea = all;

                }
                field("No Of students"; rec."No Of Students")
                {
                    ApplicationArea = all;
                    DrillDownPageID = "Group Assignmnets ";

                }
                field(Capacity; rec.Capacity)
                {
                    Caption = 'Rotation Area Capacity';
                    ApplicationArea = all;
                }
                field("Remaining Capacity"; RemainingCapacity)
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Capacity';
                    Editable = false;
                    // Calculated on the fly in the page
                }


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
                Caption = 'Download Excel File';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Export;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    FieldRefs: array[20] of FieldRef;
                    FieldRefLength: Integer;
                    CsvHandler: Codeunit "Export Excell Mrp";
                begin
                    CsvHandler.Run();

                end;
            }

            action("Export 2")
            {
                Caption = 'Export  2';
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

                    CsvHandler.ExportCsvFile('UnitCoverageImport.csv', RecRef, FieldRefs, FieldRefLength);

                    // Refresh the page to show imported data
                    CurrPage.Update();
                end;
            }
            action("Import 2")
            {
                Caption = 'Import  2';
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

                    CsvHandler.ImportCsvFile('UnitCoverageImport.csv', RecRef, FieldRefs, FieldRefLength);

                    // Refresh the page to show imported data
                    CurrPage.Update();
                end;
            }
        }
    }
    var
        RemainingCapacity: Integer;

    trigger OnAfterGetRecord()
    begin
        RemainingCapacity := Rec.Capacity - Rec."No Of Students";
    end;

}

