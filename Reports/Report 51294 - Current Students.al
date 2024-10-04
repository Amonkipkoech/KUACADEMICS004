report 51294 "Current Students"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Current Students.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Posting Group" = CONST('STUDENT'),
                                      Status = CONST(Current));
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Search_Name_; "Search Name")
            {
            }
            column(Customer__Name_2_; "Name 2")
            {
            }
            column(int; int)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
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
            column(Customer__Search_Name_Caption; FIELDCAPTION("Search Name"))
            {
            }
            column(Customer__Name_2_Caption; FIELDCAPTION("Name 2"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                CReg.RESET;
                CReg.SETRANGE(CReg."Student No.", Customer."No.");
                CReg.SETRANGE(CReg.Semester, Customer.GETFILTER(Customer."Semester Filter"));
                IF CReg.FIND('-') THEN
                    int := int + 1
                ELSE
                    CurrReport.SKIP;
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
        int: Integer;
        CReg: Record 61532;
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

