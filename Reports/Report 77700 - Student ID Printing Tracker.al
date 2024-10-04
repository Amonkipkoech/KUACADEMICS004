report 77700 "Student ID Printing Tracker"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student ID Printing Tracker.rdl';

    dataset
    {
        dataitem(IdTracker; 77700)
        {
            RequestFilterFields = "Student No.";
            column(StudNo; Customer."No.")
            {
            }
            column(StudNames; Customer.Name)
            {
            }
            column(Serial; IdTracker.Serial)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(CampName; info.Name)
            {
            }
            column(CompAddress; info.Address + ' ' + info."Address 2" + ' ' + info.City)
            {
            }
            column(CompPhone; info."Phone No." + ' ' + info."Phone No. 2")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Customer.RESET;
                Customer.SETRANGE(customer."No.", IdTracker."Student No.");
                IF Customer.FIND('-') THEN;
            end;

            trigger OnPreDataItem()
            begin
                ACASttudentIDPrintTracker.COPYFILTERS(IdTracker);
                IF ACASttudentIDPrintTracker.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        counts := counts + 1;
                        ACASttudentIDPrintTracker.Serial := counts;
                        ACASttudentIDPrintTracker.MODIFY;
                    END;
                    UNTIL ACASttudentIDPrintTracker.NEXT = 0;
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

    trigger OnPreReport()
    begin

        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(Picture);

        CLEAR(counts);
    end;

    var
        info: Record 79;
        Customer: Record 18;
        ACASttudentIDPrintTracker: Record 77700;
        counts: Integer;
}

