report 51599 "SPECIAL STUDENTS HELB 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/SPECIAL STUDENTS HELB 2.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Document No." = FILTER('*HELB*'));
            RequestFilterFields = "Customer No.", "Posting Date";
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
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Cust__Ledger_Entry_Description; Description)
            {
            }
            column(Cust__Ledger_Entry_Amount; Amount)
            {
            }
            column(ABS_Amount_; ABS(Amount))
            {
            }
            column(JAB_STUDENTS_HELB_LOANCaption; JAB_STUDENTS_HELB_LOANCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                StudStr := COPYSTR("Cust. Ledger Entry"."Customer No.", 4, 5);
                StudNo := FORMAT(StudStr);
                IF StudNo < '03000' THEN CurrReport.SKIP;
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
        StudNo: Code[20];
        StudStr: Text[30];
        JAB_STUDENTS_HELB_LOANCaptionLbl: Label 'JAB STUDENTS HELB LOAN';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TOTALCaptionLbl: Label 'TOTAL';
}

