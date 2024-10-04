report 51461 "Update Units Prog/Stages"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Update Units ProgStages.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; 61517)
        {
            DataItemTableView = SORTING(Code, "Programme Option", "Entry No")
                                WHERE("Programme Code" = FILTER(''),
                                      "Stage Code" = FILTER(''),
                                      "Programme Code" = FILTER(<> ''));
            RequestFilterFields = "Programme Code", "Stage Code";
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
            column(Units_Subjects_Code; Code)
            {
            }
            column(Units_Subjects_Desription; Desription)
            {
            }
            column(Units_Subjects_Amount; Amount)
            {
            }
            column(Units_Subjects__Programme_Code_lkup_; "Programme Code lkup")
            {
            }
            column(Units_Subjects__Stage_Code_Lkup_; "Lecturer Lkup")
            {
            }
            column(Units_SubjectsCaption; Units_SubjectsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Units_Subjects_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Units_Subjects_DesriptionCaption; FIELDCAPTION(Desription))
            {
            }
            column(Units_Subjects_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Units_Subjects__Programme_Code_lkup_Caption; FIELDCAPTION("Programme Code lkup"))
            {
            }
            column(Units_Subjects__Stage_Code_Lkup_Caption; FIELDCAPTION("Lecturer Lkup"))
            {
            }
            column(Units_Subjects_Programme_Code; "Programme Code")
            {
            }
            column(Units_Subjects_Stage_Code; "Stage Code")
            {
            }
            column(Units_Subjects_Entry_No; "Entry No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "ACA-Units/Subjects"."Programme Code" := "ACA-Units/Subjects"."Programme Code lkup";
                "ACA-Units/Subjects"."Stage Code" := "ACA-Units/Subjects"."Lecturer Lkup";
                "ACA-Units/Subjects".MODIFY;
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
        Units_SubjectsCaptionLbl: Label 'Units/Subjects';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

