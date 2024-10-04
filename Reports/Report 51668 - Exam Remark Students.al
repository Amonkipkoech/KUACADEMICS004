report 51668 "Exam Remark Students"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Remark Students.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            column(Customer_No_; "No.")
            {
            }
            dataitem("ACA-Std Exam Registration/Exam"; "ACA-Std Exam Registration/Exam")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = SORTING("Student No.", Programmes, Stage, Semester, Unit, "Exam Code")
                                    WHERE("Due for Refund" = CONST(true));
                RequestFilterFields = "Student No.";
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
                column(Student_Exam_Registration_Exam__Student_No__; "Student No.")
                {
                }
                column(Student_Exam_Registration_Exam_Programme; Programmes)
                {
                }
                column(Student_Exam_Registration_Exam_Stage; Stage)
                {
                }
                column(Student_Exam_Registration_Exam_Semester; Semester)
                {
                }
                column(Student_Exam_Registration_Exam_Unit; Unit)
                {
                }
                column(Student_Exam_Registration_Exam__Exam_Code_; "Exam Code")
                {
                }
                column(Student_Exam_Registration_Exam__Student_Type_; "Student Type")
                {
                }
                column(Student_Exam_Registration_Exam_ReceiptNo; ReceiptNo)
                {
                }
                column(KSPS_Exam_Remarking_Refunds_ReportCaption; KSPS_Exam_Remarking_Refunds_ReportCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Student_Exam_Registration_Exam__Student_No__Caption; FIELDCAPTION("Student No."))
                {
                }
                column(Student_Exam_Registration_Exam_ProgrammeCaption; FIELDCAPTION(Programmes))
                {
                }
                column(Student_Exam_Registration_Exam_StageCaption; FIELDCAPTION(Stage))
                {
                }
                column(Student_Exam_Registration_Exam_SemesterCaption; FIELDCAPTION(Semester))
                {
                }
                column(Student_Exam_Registration_Exam_UnitCaption; FIELDCAPTION(Unit))
                {
                }
                column(Student_Exam_Registration_Exam__Exam_Code_Caption; FIELDCAPTION("Exam Code"))
                {
                }
                column(Student_Exam_Registration_Exam__Student_Type_Caption; FIELDCAPTION("Student Type"))
                {
                }
                column(Student_Exam_Registration_Exam_ReceiptNoCaption; FIELDCAPTION(ReceiptNo))
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
        KSPS_Exam_Remarking_Refunds_ReportCaptionLbl: Label 'KSPS Exam Remarking Refunds Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

