report 51598 "JAB HELB LOAN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/JAB HELB LOAN.rdl';

    dataset
    {
        dataitem("G/L Entry"; 17)
        {
#pragma warning disable AL0254
            DataItemTableView = SORTING("Bal. Account No.")
#pragma warning restore AL0254
                                WHERE("G/L Account No." = FILTER(300020 | 200012),
                                      "Document No." = FILTER('*HELB*'),
                                      Reversed = CONST(false),
                                      "Bal. Account Type" = CONST(Customer),
                                      "Bal. Account No." = FILTER(<> ''));
            RequestFilterFields = "Posting Date", "Bal. Account No.", "Document No.";
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
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry_Description; Description)
            {
            }
            column(G_L_Entry__Bal__Account_No__; "Bal. Account No.")
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(G_L_Entry_Amount_Control1102756000; Amount)
            {
            }
            column(SPECIAL_STUDENTS_HELB_LOANCaption; SPECIAL_STUDENTS_HELB_LOANCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(G_L_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Student_NoCaption; Student_NoCaptionLbl)
            {
            }
            column(G_L_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                studstr := COPYSTR("G/L Entry"."Bal. Account No.", 4, 5);
                StudNo := FORMAT(studstr);
                IF StudNo > '03000' THEN CurrReport.SKIP;
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
        StudNo: Code[10];
        studstr: Code[20];
        SPECIAL_STUDENTS_HELB_LOANCaptionLbl: Label 'SPECIAL STUDENTS HELB LOAN';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Student_NoCaptionLbl: Label 'Student No';
        TotalCaptionLbl: Label 'Total';
}

