report 51520 "Lecturer Timetable Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Lecturer Timetable Allocation.rdl';

    dataset
    {
        dataitem("ACA-Lecturers Units - Old"; "ACA-Lecturers Units - Old")
        {
            DataItemTableView = SORTING(Programme, Stage, Unit, Semester, Lecturer);
            RequestFilterFields = Lecturer, Programme, Stage, Unit;
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
            column(Lecturers_Units_Lecturer; Lecturer)
            {
            }
            column(Lecturers_Units_Programme; Programme)
            {
            }
            column(Lecturers_Units_Stage; Stage)
            {
            }
            column(Lecturers_Units_Unit; Unit)
            {
            }
            column(Lecturers_Units_Semester; Semester)
            {
            }
            column(Lecturers_Units__Minimum_Contracted_; "Minimum Contracted")
            {
            }
            column(Lecturers_Units__No__Of_Hours_Contracted_; "No. Of Hours Contracted")
            {
            }
            column(Lecturers_Units_Allocation; Allocation)
            {
            }
            column(Emp__First_Name__________Emp__Last_Name_; Emp."First Name" + ' ' + Emp."Last Name")
            {
            }
            column(Lecturers_Units_Time_AllocationCaption; Lecturers_Units_Time_AllocationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Lecturers_Units_LecturerCaption; FIELDCAPTION(Lecturer))
            {
            }
            column(Lecturers_Units_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Lecturers_Units_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Lecturers_Units_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(Lecturers_Units_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Lecturers_Units__Minimum_Contracted_Caption; FIELDCAPTION("Minimum Contracted"))
            {
            }
            column(Lecturers_Units__No__Of_Hours_Contracted_Caption; FIELDCAPTION("No. Of Hours Contracted"))
            {
            }
            column(Lecturers_Units_AllocationCaption; FIELDCAPTION(Allocation))
            {
            }
            column(NameCaption; NameCaptionLbl)
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
        Emp: Record 61188;
        Lecturers_Units_Time_AllocationCaptionLbl: Label 'Lecturers Units Time Allocation';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
}

