page 68121 "ACA-Rooms"
{
    PageType = Document;
    SourceTable = 61163;

    layout
    {
        area(content)
        {
            field("Hostel No"; Rec."Hostel No")
            {
                LookupPageID = "ACA-Hostel List";
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    "Hostel Rec".SETRANGE("Hostel Rec"."Asset No", Rec."Hostel No");
                    IF "Hostel Rec".FIND('-') THEN BEGIN
                        Hostel := "Hostel Rec".Description
                    END;
                    Rec.SETRANGE("Hostel No", "Hostel Rec"."Asset No");

                    IF Rec.SETCURRENTKEY("Room No") THEN;
                    // setrange("Hostel No","Hostel No");
                    //SETRANGE(Status,Status::Vacant);
                end;
            }
            field(Hostel; Hostel)
            {
                Editable = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(___)
            {
                field("Hostel No2"; Rec."Hostel No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Room No"; Rec."Room No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Space No"; Rec."Space No")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Reservation Remarks"; Rec."Reservation Remarks")
                {
                    ApplicationArea = All;
                }
                field("Reservation UserID"; Rec."Reservation UserID")
                {
                    ApplicationArea = All;
                }
                field("Reservation Date"; Rec."Reservation Date")
                {
                    ApplicationArea = All;
                }
                field("Room Cost"; Rec."Room Cost")
                {
                    ApplicationArea = All;
                }
                field("Students Count"; Rec."Students Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Hostel: Text[30];
        "Hostel No": Code[20];
        "Hostel Rec": Record 61162;
        Programmes: Code[20];
        "Starting No": Code[20];
        "Ending No": Code[20];
        "Starting Room No": Code[20];
}

