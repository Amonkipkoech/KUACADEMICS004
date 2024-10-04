report 51069 "Entries Reversal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Entries Reversal.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type", "Entry No.");
            RequestFilterFields = "Student No.", "Settlement Type", Remarks, "Programme Exam Category", Posted;
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
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration__Settlement_Type_; "Settlement Type")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Remarks; Remarks)
            {
            }
            column(Course_RegistrationCaption; Course_RegistrationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Course_Registration_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Course_Registration__Settlement_Type_Caption; FIELDCAPTION("Settlement Type"))
            {
            }
            column(Course_Registration_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Course_Registration_RemarksCaption; FIELDCAPTION(Remarks))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Register_for; "Register for")
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
            dataitem("ACA-Std Charges"; 61535)
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
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
                column(Student_Charges_Transacton_ID; "Transacton ID")
                {
                }
                column(Student_Charges_Student_No_; "Student No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "G/LEntry".RESET;
                    "G/LEntry".SETCURRENTKEY("Document No.", "Posting Date");
                    "G/LEntry".SETRANGE("G/LEntry"."Document No.", "ACA-Std Charges"."Transacton ID");
                    IF "G/LEntry".FIND('-') THEN BEGIN
                        REPEAT
                            "G/LEntry".DELETE;
                        UNTIL "G/LEntry".NEXT = 0;
                    END;

                    CustEntry.RESET;
                    CustEntry.SETCURRENTKEY("Document No.");
                    CustEntry.SETRANGE(CustEntry."Document No.", "ACA-Std Charges"."Transacton ID");
                    IF CustEntry.FIND('-') THEN BEGIN
                        REPEAT
                            CustEntry.DELETE;
                        UNTIL CustEntry.NEXT = 0;
                    END;

                    CustDet.RESET;
                    CustDet.SETCURRENTKEY("Document No.", "Posting Date");
                    CustDet.SETRANGE(CustDet."Document No.", "ACA-Std Charges"."Transacton ID");
                    IF CustDet.FIND('-') THEN BEGIN
                        REPEAT
                            CustDet.DELETE;
                        UNTIL CustDet.NEXT = 0;
                    END;
                end;
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
        "G/LEntry": Record 17;
        CustEntry: Record 21;
        CustDet: Record 379;
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

