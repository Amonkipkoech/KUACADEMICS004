report 51862 "Student Applications Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Applications Report.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 61358)
        {
            RequestFilterFields = "Settlement Type", Date;
            column(no; "Application No.")
            {
            }
            column(Date; Date)
            {
            }
            column(regno; "Admission No")
            {
            }
            column(Name; Surname + ' ' + "Other Names")
            {
            }
            column(sur; "Other Names")
            {
            }
            column(dob; "Date Of Birth")
            {
            }
            column(gender; Gender)
            {
            }
            column(address; "Address for Correspondence1" + ' ' + "Address for Correspondence2")
            {
            }
            column(n; "Address for Correspondence2")
            {
            }
            column(phone; "Telephone No. 1")
            {
            }
            column(degree; "First Degree Choice")
            {
            }
            column(picture; CI.Picture)
            {
            }
            column(Campus; Campus)
            {
            }
            column(Semester; "First Choice Semester")
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(Status; Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ProgName := '';
                IF prog.GET("First Degree Choice") THEN BEGIN
                    ProgName := prog.Description;
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
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record 79;
        prog: Record 61511;
        ProgName: Text[100];
}

