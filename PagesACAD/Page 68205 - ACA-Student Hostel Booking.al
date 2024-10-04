page 68205 "ACA-Student Hostel Booking"
{
    PageType = Document;
    SourceTable = 61155;

    layout
    {
        area(content)
        {
            group(Spaces)
            {
                field("Space No"; Rec."Space No")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        HostelLedger.RESET;
                        HostelLedger.SETRANGE(HostelLedger."Space No", Rec."Space No");
                        IF HostelLedger.FIND('-') THEN BEGIN
                            Rec."Room No" := HostelLedger."Room No";
                            Rec."Hostel No" := HostelLedger."Hostel No";
                            Rec."Accomodation Fee" := HostelLedger."Room Cost";
                            Rec."Allocation Date" := TODAY;
                        END;
                    end;
                }
                field("Room No"; Rec."Room No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hostel No"; Rec."Hostel No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Accomodation Fee"; Rec."Accomodation Fee")
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
            group(Functions)
            {
            }
            action("Book Room")
            {
                Image = Save;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you really want to book the selected Room?') THEN BEGIN
                        Sem.RESET;
                        Sem.SETRANGE(Sem."Current Semester", TRUE);
                        IF Sem.FIND('-') THEN BEGIN
                            StudHostel.RESET;
                            StudHostel.SETRANGE(StudHostel.Student, Rec.Student);
                            StudHostel.SETRANGE(StudHostel.Semester, Sem.Code);
                            StudHostel.SETRANGE(StudHostel.Billed, TRUE);
                            IF StudHostel.FIND('-') THEN ERROR('Please note that you have already book the room in the current semester');
                            Rec.Semester := Sem.Code;
                            Rec.Billed := TRUE;
                            Rec."Billed Date" := TODAY;
                            MESSAGE('Booking completed successfully');
                        END;
                    END;
                end;
            }
            separator(Booking)
            {
            }
            action("Print Booking Card")
            {
                Caption = 'Print Booking Card';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StudHostel.RESET;
                    StudHostel.SETFILTER(StudHostel.Student, Rec.Student);
                    //  StudHostel.SETFILTER(StudHostel.Semester,Semester);
                    IF StudHostel.FIND('-') THEN
                        REPORT.RUN(39005954, TRUE, TRUE, Rec);
                end;
            }
        }
    }

    var
        HostelLedger: Record 61163;
        StudentCharges: Record 61535;
        PaidAmt: Decimal;
        ChargesRec: Record 61515;
        Cust: Record 18;
        GenSetup: Record 61534;
        Creg: Record 61532;
        Sem: Record 61692;
        Registered: Boolean;
        StudHostel: Record 61155;
}

