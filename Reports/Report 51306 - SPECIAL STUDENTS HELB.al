report 51306 "SPECIAL STUDENTS HELB"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/SPECIAL STUDENTS HELB.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                WHERE("Document No." = FILTER('HELB*'));
            RequestFilterFields = "Document No.", "Posting Date", "Customer No.", Description;
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
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
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
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
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
                //RONO   TO CATER FOR EDS STUDENTS
                startno := COPYSTR("Cust. Ledger Entry"."Customer No.", 1, 3);

                IF startno = 'EDS' THEN BEGIN
                    StudStr := COPYSTR("Cust. Ledger Entry"."Customer No.", 5, 5);
                    StudNo := FORMAT(StudStr);
                    IF StudNo > '03000' THEN CurrReport.SKIP;
                END
                ELSE BEGIN
                    StudStr := COPYSTR("Cust. Ledger Entry"."Customer No.", 4, 5);
                    StudNo := FORMAT(StudStr);
                    IF StudNo > '03000' THEN CurrReport.SKIP;

                END;
                //RONO


                /*

                 StudStr:=COPYSTR("Cust. Ledger Entry"."Customer No.",4,5);
                 StudNo:=FORMAT(StudStr);
                 IF StudNo>'03000' THEN CurrReport.SKIP;
                 */

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
        startno: Code[10];
        JAB_STUDENTS_HELB_LOANCaptionLbl: Label 'JAB STUDENTS HELB LOAN';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TOTALCaptionLbl: Label 'TOTAL';
}

