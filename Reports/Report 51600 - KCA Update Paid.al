report 51600 "KCA Update Paid"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KCA Update Paid.rdl';

    dataset
    {
        dataitem("ACA-Std Charges"; "ACA-Std Charges")
        {
            DataItemTableView = SORTING("Transacton ID", "Student No.");
            RequestFilterFields = Date;
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
            column(Student_Charges__Student_No__; "Student No.")
            {
            }
            column(Student_Charges__Reg__Transacton_ID_; "Reg. Transacton ID")
            {
            }
            column(Student_Charges__Transaction_Type_; "Transaction Type")
            {
            }
            column(Student_Charges_Code; Code)
            {
            }
            column(Student_Charges_Description; Description)
            {
            }
            column(Student_Charges_Amount; Amount)
            {
            }
            column(Student_ChargesCaption; Student_ChargesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_Charges__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Student_Charges__Reg__Transacton_ID_Caption; FIELDCAPTION("Reg. Transacton ID"))
            {
            }
            column(Student_Charges__Transaction_Type_Caption; FIELDCAPTION("Transaction Type"))
            {
            }
            column(Student_Charges_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Student_Charges_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Student_Charges_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Student_Charges_Transacton_ID; "Transacton ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "ACA-Std Charges".CALCFIELDS("ACA-Std Charges"."Total Paid");
                "ACA-Std Charges"."Amount Paid" := "ACA-Std Charges"."Total Paid";
                IF "ACA-Std Charges"."Amount Paid" = "ACA-Std Charges".Amount THEN BEGIN
                    "ACA-Std Charges"."Fully Paid" := TRUE;

                END;
                "ACA-Std Charges".MODIFY;
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
        Student_ChargesCaptionLbl: Label 'Student Charges';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

