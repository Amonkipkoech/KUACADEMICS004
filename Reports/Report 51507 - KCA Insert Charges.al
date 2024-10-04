report 51507 "KCA Insert Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA Insert Charges.rdl';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "No. Of Receipts", "No Of Charges";
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__No__Of_Receipts_; "No. Of Receipts")
            {
            }
            column(Customer__No_Of_Charges_; "No Of Charges")
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
            column(Customer__No__Of_Receipts_Caption; FIELDCAPTION("No. Of Receipts"))
            {
            }
            column(Customer__No_Of_Charges_Caption; FIELDCAPTION("No Of Charges"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Customer.CALCFIELDS(Customer."No. Of Receipts", Customer."No Of Charges");
                IF Customer."No Of Charges" = 0 THEN BEGIN
                    CourseReg.RESET;
                    CourseReg.SETRANGE(CourseReg."Student No.", Customer."No.");
                    IF CourseReg.FIND('-') THEN BEGIN
                        CourseReg.VALIDATE(CourseReg."Settlement Type");
                        CourseReg.MODIFY;
                    END;
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
        CourseReg: Record 61532;
        StudCharges: Record 61535;
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

