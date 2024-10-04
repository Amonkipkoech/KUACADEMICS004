/// <summary>
/// Report Copy Fees Struc (ID 51683).
/// </summary>
report 51683 "Copy Fees Struc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Copy Fees Struc.rdl';

    dataset
    {
        dataitem(DataItem2453; 61523)
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Semester, "Student Type", "Settlemet Type", "Seq.");
            RequestFilterFields = "Programme Code";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Fee_By_Stage__Break_Down_; "Break Down")
            {
            }
            column(Fee_By_Stage__Break_Down_Caption; FIELDCAPTION("Break Down"))
            {
            }
            column(Fee_By_Stage__Programme_Code_; "Programme Code")
            {
            }
            column(Fee_By_Stage__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Fee_By_Stage__Seq__; "Seq.")
            {
            }
            column(Fee_By_Stage__Seq__Caption; FIELDCAPTION("Seq."))
            {
            }
            column(Fee_By_Stage__Settlemet_Type_; "Settlemet Type")
            {
            }
            column(Fee_By_Stage__Settlemet_Type_Caption; FIELDCAPTION("Settlemet Type"))
            {
            }
            column(Fee_By_Stage__Stage_Code_; "Stage Code")
            {
            }
            column(Fee_By_Stage__Stage_Code_Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Fee_By_Stage__Student_Type_; "Student Type")
            {
            }
            column(Fee_By_Stage__Student_Type_Caption; FIELDCAPTION("Student Type"))
            {
            }
            column(Fee_By_Stage_Semester; Semester)
            {
            }
            column(Fee_By_Stage_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Fee_By_StageCaption; Fee_By_StageCaptionLbl)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FeesByStage.INIT;
                FeesByStage."Programme Code" := "Programme Code";
                FeesByStage."Stage Code" := "Stage Code";
                FeesByStage.Semester := Semester;
                FeesByStage."Student Type" := "Student Type";
                FeesByStage."Settlemet Type" := "Settlemet Type";
                FeesByStage."Seq." := "Seq.";
                FeesByStage."Break Down" := "Break Down";
                FeesByStage.Remarks := Remarks;
                FeesByStage."Amount Not Distributed" := "Amount Not Distributed";
                FeesByStage.INSERT;
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
        FeesByStage: Record 61523;
        Fee_By_StageCaptionLbl: Label 'Fee By Stage';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

