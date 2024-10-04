report 51476 "Student List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student List.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student));
            RequestFilterFields = "No.", Gender, "Student Programme";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(UserFilters; UserFilters)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Date_Registered_; "Date Registered")
            {
            }
            column(Customer_Status; Status)
            {
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(Hesabu; Hesabu)
            {
            }
            column(Customer__Balance__LCY___Control1000000010; "Balance (LCY)")
            {
            }
            column(Student_ListCaption; Student_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__Date_Registered_Caption; FIELDCAPTION("Date Registered"))
            {
            }
            column(Customer_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CReg.RESET;
                CReg.SETFILTER(CReg."Student No.", Customer."No.");
                CReg.SETFILTER(CReg.Programmes, GETFILTER(Customer."Programme Filter"));
                CReg.SETFILTER(CReg."Settlement Type", GETFILTER(Customer."Settlement Type Filter"));
                IF CReg.FIND('-') THEN BEGIN
                    // CurrReport.SKIP()
                END ELSE BEGIN
                    CurrReport.SKIP()
                END;
            end;

            trigger OnPreDataItem()
            begin
                UserFilters := GETFILTER(Customer."No.") + ' ' + Customer.GETFILTER(Customer.Status) + ' ' + Customer.GETFILTER(Customer.
              "Programme Filter")
                + ' ' + Customer.GETFILTER(Customer."Settlement Type Filter");
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
        Hesabu: Integer;
        UserFilters: Text[200];
        CReg: Record 61532;
        Student_ListCaptionLbl: Label 'Student List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

