report 51585 "Update Scores"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Scores.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            DataItemTableView = SORTING(Programme, Stage, Unit, Semester, "Reg. Transacton ID", "Student No.");
            RequestFilterFields = Programme;
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
            column(Student_Units__Reg__Transacton_ID_; "Reg. Transacton ID")
            {
            }
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Student_Units_Programme; Programme)
            {
            }
            column(Student_Units_Stage; Stage)
            {
            }
            column(Student_Units_Unit; Unit)
            {
            }
            column(Student_Units__Total_Score_; "Total Score")
            {
            }
            column(Student_UnitsCaption; Student_UnitsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_Units__Reg__Transacton_ID_Caption; FIELDCAPTION("Reg. Transacton ID"))
            {
            }
            column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Student_Units_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Student_Units_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Student_Units_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(Student_Units__Total_Score_Caption; FIELDCAPTION("Total Score"))
            {
            }
            column(Student_Units_Semester; Semester)
            {
            }
            column(Student_Units_ENo; ENo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "ACA-Student Units"."Final Score" := "ACA-Student Units"."Total Score";
                IF UnitsR.GET("ACA-Student Units".Programme, "ACA-Student Units".Stage, "ACA-Student Units".Unit) THEN //BEGIN
                    "ACA-Student Units"."No. Of Units" := UnitsR."No. Units";
                //"Student Units"."Unit Type":=UnitsR."Unit Type";
                "ACA-Student Units".MODIFY;
                //END;
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
        UnitsR: Record 61517;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

