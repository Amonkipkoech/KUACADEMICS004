report 60600 "Check Course Registrations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Check Course Registrations.rdl';

    dataset
    {
        dataitem(DataItem1000000001; 61532)
        {
            RequestFilterFields = Semester, Programmes, Stage, "Settlement Type", "Registration Date", "Student No.";
            column(ProgNo; Programmes)
            {
            }
            column(ProgName; "ACA-Programme".Description)
            {
            }
            column(StudNo; "Student No.")
            {
            }
            column(StudNames; Customer.Name)
            {
            }
            column(Phone; Customer."Phone No.")
            {
            }
            column(TransNo; "Reg. Transacton ID")
            {
            }
            column(AcademicYear; "Academic Year")
            {
            }
            column(Semester; Semester)
            {
            }
            column(Stage; Stage)
            {
            }
            column(SettlementType; "Settlement Type")
            {
            }
            column(Stopped; Reversed)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Customer.RESET;
                Customer.SETRANGE("No.", "Student No.");
                IF Customer.FIND('-') THEN BEGIN

                END;
                "ACA-Programme".RESET;
                "ACA-Programme".SETRANGE("ACA-Programme".Code, Programmes);
                IF "ACA-Programme".FIND('-') THEN BEGIN
                END;
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

    var
        Customer: Record 18;
        "ACA-Programme": Record 61511;
}

