report 51795 "Hostel Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Hostel Invoice.rdl';

    dataset
    {
        dataitem(DataItem1; 61155)
        {
            DataItemTableView = WHERE(Cleared = FILTER('No'));
            column(HostNo; "Hostel No")
            {
            }
            column(RoomNo; "Room No")
            {
            }
            column(SpaceNo; "Space No")
            {
            }
            column(stdNo; cust."No.")
            {
            }
            column(stdName; cust.Name)
            {
            }
            column(IDNo; cust."ID No")
            {
            }
            column(dEPTnAME; Prog."Department Name" + '(' + Prog."Department Code" + ')')
            {
            }
            column(ProgName; Prog.Description + '(' + Prog.Code + ')')
            {
            }
            column(DateGen; TODAY)
            {
            }
            column(address; cust.Address)
            {
            }
            column(addr2; cust."Address 2")
            {
            }
            column(email; cust."E-Mail")
            {
            }
            column(phone; cust."Phone No.")
            {
            }
            column(Bal; cust."Balance (LCY)" - Charges)
            {
            }
            column(Chargez; Charges)
            {
            }
            column(TotalCharge; cust."Balance (LCY)")
            {
            }
            column(curruser; currUser)
            {
            }
            column(FOOTER1; 'PLEASE ADVICE THE HOUSEKEEPER OF ANY OMISSION OR ERRORS IN THE DETAILS OF THIS FORM, AND BRING IT WITH YOU WHEN YOU')
            {
            }
            column(fOOTER2; 'PAY YOUR FEES CHARGED')
            {
            }
            column(Footer3; 'THIS INVOICE IS VALID ONLY FOR 24 HOURS')
            {
            }
            column(hEADER1; 'MASENO UNIVERSITY P.O. BOX 1957 - 10101 MASENO TEL: 05920091')
            {
            }
            column(invpost; invpost)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(invpost);
                IF "Invoice Printed" THEN
                    invpost := 'DUPLICATE';
                CLEAR(bals);
                CLEAR(bal2);
                IF Allocated = FALSE THEN ERROR('Print the Invoive only after Posting allocation.');
                IF NOT (cust.GET(Student)) THEN ERROR('Student Missing.');
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Student);
                courseReg.SETRANGE(courseReg.Semester, Semester);
                courseReg.SETRANGE(courseReg."Academic Year", "Academic Year");
                IF courseReg.FIND('-') THEN BEGIN
                    Prog.RESET;
                    Prog.SETRANGE(Prog.Code, courseReg.Programmes);
                    IF Prog.FIND('-') THEN BEGIN
                        Prog.CALCFIELDS(Prog."Department Name");
                        Dept.RESET;
                        // Dept.setrange(Dept.Code,);
                    END;
                END;
                IF cust.GET(Student) THEN
                    cust.CALCFIELDS(cust."Balance (LCY)");

                //IF Allocated=TRUE THEN bals:="Students Hostel Rooms".Balance-"Students Hostel Rooms".Charges
                // ELSE bals:="Students Hostel Rooms".Balance;
                bal2 := cust."Balance (LCY)";//bals+"Students Hostel Rooms".Charges;

                "Invoice Printed" := TRUE;
                MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CLEAR(currUser);
        users.RESET;
        users.SETRANGE(users."User Name", USERID);
        IF users.FIND('-') THEN BEGIN
            IF users."Full Name" <> '' THEN currUser := users."Full Name" ELSE currUser := users."User Name";
        END;
    end;

    var
        cust: Record 18;
        courseReg: Record 61532;
        Prog: Record 61511;
        Dept: Record 349;
        users: Record 2000000120;
        currUser: Code[150];
        Hostels: Record 61155;
        bals: Decimal;
        bal2: Decimal;
        invpost: Code[30];
}

