page 68978 "ACA-Multple Records"
{
    PageType = List;
    SaveValues = true;
    SourceTable = 61748;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Correct No."; Rec."Correct No.")
                {
                    DrillDownPageID = "ACA-Multple Records";
                    Lookup = true;
                    LookupPageID = "ACA-Multple Records";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(updates)
            {
                Caption = 'data';
                ApplicationArea = All;
            }
        }
    }

    var
        cust: Record 18;
        detailedcus: Record 379;
        custleder: Record 21;

    procedure update()
    begin
    end;
}

