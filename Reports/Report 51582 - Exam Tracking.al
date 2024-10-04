report 51582 "Exam Tracking"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Tracking.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Code, "Programme Option");
            RequestFilterFields = "Programme Code", "Stage Code", "Exam Status";
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
            column(Units_Subjects__Programme_Code_; "Programme Code")
            {
            }
            column(Units_Subjects__Stage_Code_; "Stage Code")
            {
            }
            column(Units_Subjects_Code; Code)
            {
            }
            column(Units_Subjects_Desription; Desription)
            {
            }
            column(Units_Subjects__Exam_Status_; "Exam Status")
            {
            }
            column(Units_Subjects__Printed_Copies_; "Printed Copies")
            {
            }
            column(Units_Subjects__Issued_Copies_; "Issued Copies")
            {
            }
            column(Units_Subjects__Returned_Copies_; "Returned Copies")
            {
            }
            column(Units_Subjects__Exam_Remarks_; "Exam Remarks")
            {
            }
            column(Exam_TrackingCaption; Exam_TrackingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Units_Subjects__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Units_Subjects__Stage_Code_Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Units_Subjects_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Units_Subjects_DesriptionCaption; FIELDCAPTION(Desription))
            {
            }
            column(Units_Subjects__Exam_Status_Caption; FIELDCAPTION("Exam Status"))
            {
            }
            column(Units_Subjects__Printed_Copies_Caption; FIELDCAPTION("Printed Copies"))
            {
            }
            column(Units_Subjects__Issued_Copies_Caption; FIELDCAPTION("Issued Copies"))
            {
            }
            column(Units_Subjects__Returned_Copies_Caption; FIELDCAPTION("Returned Copies"))
            {
            }
            column(Units_Subjects__Exam_Remarks_Caption; FIELDCAPTION("Exam Remarks"))
            {
            }
            column(Units_Subjects_Entry_No; "Entry No")
            {
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
        Exam_TrackingCaptionLbl: Label 'Exam Tracking';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

