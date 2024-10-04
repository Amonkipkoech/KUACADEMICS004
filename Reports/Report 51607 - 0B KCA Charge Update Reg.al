report 51607 "0B KCA Charge Update Reg"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/0B KCA Charge Update Reg.rdl';

    dataset
    {
        dataitem("ACA-Std Charges"; "ACA-Std Charges")
        {
            DataItemTableView = SORTING("Transacton ID", "Student No.");
            RequestFilterFields = "Reg. Transacton ID", Date;
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
                CourseReg.RESET;
                CourseReg.SETCURRENTKEY("Reg. Transacton ID", "Student No.");
                CourseReg.SETRANGE(CourseReg."Student No.", "ACA-Std Charges"."Student No.");
                IF CourseReg.FIND('+') THEN BEGIN
                    "ACA-Std Charges"."Reg. Transacton ID" := CourseReg."Reg. Transacton ID";
                    "ACA-Std Charges".Programme := CourseReg.Programmes;
                    "ACA-Std Charges".Stage := CourseReg.Stage;
                    "ACA-Std Charges".Unit := CourseReg.Unit;
                    "ACA-Std Charges".Semester := CourseReg.Semester;
                    "ACA-Std Charges".MODIFY;
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
        Student_ChargesCaptionLbl: Label 'Student Charges';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

