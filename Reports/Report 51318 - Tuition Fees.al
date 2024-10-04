report 51318 "Tuition Fees"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Tuition Fees.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Student No.", Programmes;
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Total; Total)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Receipt_NoCaption; Receipt_NoCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_No_Caption; Student_No_CaptionLbl)
            {
            }
            column(Tuition_Fees_CollectionsCaption; Tuition_Fees_CollectionsCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Bal. Account No." = FIELD("Student No.");
                DataItemTableView = WHERE("G/L Account No." = CONST(),
                                          "Document No." = FILTER('TR*'),
                                          Description = FILTER('Fees for *'),
                                          Amount = FILTER(< 0));
                column(G_L_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(G_L_Entry__Document_No__; "Document No.")
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
                column(G_L_Entry_Entry_No_; "Entry No.")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                Total := 0;
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
        Total: Decimal;
        AmountCaptionLbl: Label 'Amount';
        Receipt_NoCaptionLbl: Label 'Receipt No';
        Posting_DateCaptionLbl: Label 'Posting Date';
        DescriptionCaptionLbl: Label 'Description';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Student_No_CaptionLbl: Label 'Student No.';
        Tuition_Fees_CollectionsCaptionLbl: Label 'Tuition Fees Collections';
        TotalCaptionLbl: Label 'Total';
}

