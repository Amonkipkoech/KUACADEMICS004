page 69168 "ACA-Std Hostel Rooms Clear"
{
    PageType = ListPart;
    SourceTable = "ACA-Students Hostel Rooms";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Hostel No"; Rec."Hostel No")
                {
                    ApplicationArea = All;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = All;
                }
                field("Space No"; Rec."Space No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        HostelLedger.RESET;
                        HostelLedger.SETRANGE(HostelLedger."Space No", Rec."Space No");
                        IF HostelLedger.FIND('-') THEN BEGIN
                            IF HostelLedger.Status <> HostelLedger.Status::Vaccant THEN ERROR('Please note that you can only select from vacant spaces');
                            Rec."Room No" := HostelLedger."Room No";
                            Rec."Hostel No" := HostelLedger."Hostel No";
                            Rec."Accomodation Fee" := HostelLedger."Room Cost";
                            Rec."Allocation Date" := TODAY;
                        END;
                        Sem.RESET;
                        Sem.SETRANGE(Sem."Current Semester", TRUE);
                        IF Sem.FIND('-') THEN
                            Rec.Semester := Sem.Code
                        ELSE
                            ERROR('Please Select the semester');

                        Registered := FALSE;
                        Creg.RESET;
                        Creg.SETRANGE(Creg."Student No.", Rec.Student);
                        Creg.SETRANGE(Creg.Semester, Sem.Code);
                        // Creg.SETRANGE(Creg.Posted,TRUE);
                        IF Creg.FIND('-') THEN
                            Registered := Creg.Registered;

                        GenSetup.GET;
                        IF GenSetup."Allow UnPaid Hostel Booking" = FALSE THEN BEGIN
                            // Check if he has a fee balance
                            IF Cust.GET(Rec.Student) THEN BEGIN
                                Cust.CALCFIELDS(Cust.Balance);
                                IF (Cust.Balance > 1) AND (Registered = FALSE) THEN ERROR('Please Note that you must first clear your balance');
                            END;

                            //Calculate Paid Accomodation Fee
                            PaidAmt := 0;
                            StudentCharges.RESET;
                            StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
                            StudentCharges.SETRANGE(StudentCharges.Semester, Rec.Semester);
                            StudentCharges.SETRANGE(StudentCharges.Recognized, TRUE);
                            StudentCharges.SETFILTER(StudentCharges.Code, '%1', 'ACC*');
                            IF StudentCharges.FIND('-') THEN BEGIN
                                REPEAT
                                    PaidAmt := PaidAmt + StudentCharges.Amount;
                                UNTIL StudentCharges.NEXT = 0;
                            END;
                            IF PaidAmt > Rec."Accomodation Fee" THEN BEGIN
                                Rec."Over Paid" := TRUE;
                                Rec."Over Paid Amt" := PaidAmt - Rec."Accomodation Fee";
                            END ELSE BEGIN
                                IF PaidAmt < Rec."Accomodation Fee" THEN BEGIN
                                    IF ((Cust.Balance * -1) < Rec."Accomodation Fee") AND (Registered = FALSE) THEN // Checking if over paid fee can pay accomodation
                                        ERROR('Accomodation Fee Paid Can Not Book This Room The Paid Amount is ' + FORMAT((Cust.Balance * -1)))
                                END ELSE BEGIN
                                    Rec."Over Paid" := FALSE;
                                    Rec."Over Paid Amt" := 0;
                                END;
                            END;
                        END;
                    end;
                }
                field("Accomodation Fee"; Rec."Accomodation Fee")
                {
                    ApplicationArea = All;
                }
                field("Allocation Date"; Rec."Allocation Date")
                {
                    ApplicationArea = All;
                }
                field(Charges; Rec.Charges)
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Agreement")
            {
                Caption = 'Print Agreement';
                
                
                Visible = false;
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
        HostelLedger: Record "ACA-Hostel Ledger";
        StudentCharges: Record "ACA-Std Charges";
        PaidAmt: Decimal;
        ChargesRec: Record "ACA-Charge";
        Cust: Record Customer;
        GenSetup: Record "ACA-General Set-Up";
        Creg: Record "ACA-Course Registration";
        Sem: Record "ACA-Semesters";
        Registered: Boolean;

    procedure "Book Room"()
    begin

        StudentCharges.SETRANGE(StudentCharges."Student No.", Rec.Student);
        StudentCharges.SETRANGE(StudentCharges.Semester, Rec.Semester);
        StudentCharges.SETRANGE(Posted, TRUE);
        IF StudentCharges.FIND('-') THEN BEGIN
            ChargesRec.SETRANGE(ChargesRec.Code, StudentCharges.Code);
            IF ChargesRec.FIND('-') THEN BEGIN
                PaidAmt := ChargesRec.Amount
            END;
        END;
        IF PaidAmt > Rec."Accomodation Fee" THEN BEGIN
            //StudentCharges."Over Charged":=TRUE;
            //StudentCharges."Over Charged Amount":=PaidAmt-"Accomodation Fee";
            // StudentCharges.MODIFY;
            Rec."Over Paid" := TRUE;
            Rec."Over Paid Amt" := PaidAmt - Rec."Accomodation Fee";
        END ELSE BEGIN
            IF PaidAmt <> Rec."Accomodation Fee" THEN BEGIN

                ERROR('Accomodation Fee Paid Can Not Book This Room The Paid Amount is ' + FORMAT(PaidAmt))
            END;
        END;
    end;
}

