page 68204 "ACA-Stud Hostel Rooms General"
{
    PageType = ListPart;
    SourceTable = 61155;
    SourceTableView = WHERE(Billed = CONST(true));

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field("Space No"; Rec."Space No")
                {
                    Editable = false;
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
            action("Book Room")
            {
                ApplicationArea = All;
            }
            separator(Aggt)
            {
            }
            action("Print Agreement")
            {
                Caption = 'Print Agreement';
                
               
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Creg.RESET;
                    Creg.SETFILTER(Creg."Student No.", Rec.Student);
                    Creg.SETFILTER(Creg.Semester, Rec.Semester);
                    IF Creg.FIND('-') THEN
                        REPORT.RUN(39005953, TRUE, TRUE, Creg);
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
}

