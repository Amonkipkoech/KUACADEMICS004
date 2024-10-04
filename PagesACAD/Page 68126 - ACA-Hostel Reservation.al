page 68126 "ACA-Hostel Reservation"
{
    PageType = Card;
    SourceTable = 61626;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Reservation Code"; Rec."Reservation Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Rooms Reservations")
            {
                Caption = 'Rooms Reservations';
                part(RReser; "ACA-Hostel Reservation Lines")
                {
                    SubPageLink = Code = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reserve Rooms")
            {
                Caption = 'Reserve Rooms';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you realy want to Reserve the selected rooms?') THEN BEGIN
                        HostReservLines.RESET;
                        HostReservLines.SETRANGE(HostReservLines.Code, Rec.Code);
                        IF HostReservLines.FIND('-') THEN BEGIN
                            REPEAT
                                HostLedger.RESET;
                                HostLedger.SETRANGE(HostLedger."Space No", HostReservLines."Space No");
                                IF HostLedger.FIND('-') THEN BEGIN
                                    HostLedger.Status := HostLedger.Status::"Fully Occupied";
                                    HostLedger."Reservation Remarks" := Rec."Reservation Code";
                                    HostLedger."Reservation UserID" := USERID;
                                    HostLedger."Reservation Date" := TODAY;
                                    HostLedger.MODIFY;
                                END;
                            UNTIL HostReservLines.NEXT = 0;
                        END;
                        MESSAGE('Reservation Completed Successfully');
                    END;
                end;
            }
        }
    }

    var
        HostLedger: Record "ACA-Hostel Ledger";
        HostReservLines: Record "ACA-Hostel Reservation Lines";
}

