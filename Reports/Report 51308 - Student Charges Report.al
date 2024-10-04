report 51308 "Student Charges Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Charges Report.rdl';

    dataset
    {
        dataitem(DataItem9183; 61515)
        {
            RequestFilterFields = "Code";
            column(Charge_Code; Code)
            {
            }
            column(Charge_G_L_Account; "G/L Account")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Bal. Account No." = FIELD("G/L Account");
                DataItemTableView = SORTING("Customer No.", "Posting Date");
                RequestFilterFields = "Posting Date";
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
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Customer_No__; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(Cust__Ledger_Entry_Description; Description)
                {
                }
                column(Cust__Ledger_Entry_Amount; Amount)
                {
                }
                column(Cust__Ledger_Entry_Amount_Control1102756000; Amount)
                {
                }
                column(STUDENTS_CHARGESCaption; STUDENTS_CHARGESCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Customer_No__Caption; FIELDCAPTION("Customer No."))
                {
                }
                column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Bal__Account_No_; "Bal. Account No.")
                {
                }
            }
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
        STUDENTS_CHARGESCaptionLbl: Label 'STUDENTS CHARGES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
}

