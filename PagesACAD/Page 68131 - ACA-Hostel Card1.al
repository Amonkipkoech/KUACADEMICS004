page 68131 "ACA-Hostel Card1"
{
    PageType = Document;
    SourceTable = 61162;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Asset No"; Rec."Asset No")
                {
                    ApplicationArea = All;
                    //  LookupPageID = "PROC-Procure. Plan Period";

                    trigger OnValidate()
                    begin
                        FA.SETRANGE(FA."No.", Rec."Asset No");
                        IF FA.FIND('-') THEN BEGIN
                            Rec.Description := FA.Description;
                        END
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = All;
                }
                field("Room Prefix"; Rec."Room Prefix")
                {
                    ApplicationArea = All;
                }
                field("Total Rooms"; Rec."Total Rooms")
                {
                    ApplicationArea = All;
                }
                field("Space Per Room"; Rec."Space Per Room")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Occupant"; Rec."Cost Per Occupant")
                {
                    ApplicationArea = All;
                }
                field("Starting No"; Rec."Starting No")
                {
                    ApplicationArea = All;
                }
                field("Total Rooms Created"; Rec."Total Rooms Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Rooms")
            {
                Caption = 'Create Rooms';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    "Rooms Maker"();
                end;
            }
        }
    }

    var
        FA: Record "Fixed Asset";
        Rooms: Record "ACA-Hostel Ledger";
        Existing: Integer;
        Counter: Integer;
        "Last Room": Code[10];
        "Space Name": Code[20];
        Counter2: Integer;
        TotalCount: Integer;

    procedure "Rooms Maker"()
    begin
        // Creates Rooms For The Hostel
        Rec.TESTFIELD("Room Prefix");
        Rooms.RESET;
        Rooms.SETRANGE(Rooms."Hostel No", Rec."Asset No");
        Existing := Rooms.COUNT;
        Rooms.RESET;
        IF Existing = 0 THEN
            Existing := 1;
        /*
      IF "Space Per Room">1 THEN
      BEGIN
        "Total Rooms":="Total Rooms"*"Space Per Room"
      END;

      IF "Space Per Room"<1 THEN
      BEGIN
        "Space Per Room":=1
      END;
      */
        TotalCount := 0;
        FOR Counter := Rec."Starting No" TO Rec."Total Rooms" DO BEGIN
            FOR Counter2 := 1 TO Rec."Space Per Room" DO BEGIN
                Rooms.INIT();
                Rooms."Room No" := Rec."Room Prefix" + ' ' + FORMAT(Counter);
                Rooms."Hostel No" := Rec."Asset No";
                Rooms.Status := Rooms.Status::Vaccant;
                Rooms."Room Cost" := Rec."Cost Per Occupant";
                Rooms."Space No" := Rooms."Room No" + '-' + FORMAT(Counter2);
                Rooms.INSERT(TRUE);
                TotalCount := TotalCount + 1;
            END;
            //end;
            //Rooms.INSERT(TRUE);
        END;
        MESSAGE(FORMAT(TotalCount) + ' Rooms Created successfully');

    end;
}

