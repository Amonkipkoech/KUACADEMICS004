report 51522 "Units Lectuer can take"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Units Lectuer can take.rdl';

    dataset
    {
        dataitem("ACA-Lecturers Qualified Units"; "ACA-Lecturers Qualified Units")
        {
            DataItemTableView = SORTING(Programmes, Stage, Unit, Semester, Lecturer);
            RequestFilterFields = Programmes, Stage, Unit;
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
            column(Lecturers_Qualified_Units_Lecturer; Lecturer)
            {
            }
            column(Lecturers_Qualified_Units_Programme; Programmes)
            {
            }
            column(Lecturers_Qualified_Units_Stage; Stage)
            {
            }
            column(Lecturers_Qualified_Units_Unit; Unit)
            {
            }
            column(Emp__First_Name___________Emp__Last_Name_; Emp."First Name" + '  ' + Emp."Last Name")
            {
            }
            column(Lecturers_Units_Can_TakeCaption; Lecturers_Units_Can_TakeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Lecturers_Qualified_Units_LecturerCaption; FIELDCAPTION(Lecturer))
            {
            }
            column(Lecturers_Qualified_Units_ProgrammeCaption; FIELDCAPTION(Programmes))
            {
            }
            column(Lecturers_Qualified_Units_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Lecturers_Qualified_Units_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Lecturers_Qualified_Units_Semester; Semester)
            {
            }



            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Programmes);
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Emp: Record 61188;
        Lecturers_Units_Can_TakeCaptionLbl: Label 'Lecturers Units Can Take';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
}

