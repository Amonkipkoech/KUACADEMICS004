report 51464 "Course Registration Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Course Registration Details.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            DataItemTableView = SORTING(Unit);
            RequestFilterFields = Programme, Stage, Semester, "Unit Filter";
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
            column(Student_Units_Unit; Unit)
            {
            }
            column(UnitSubj_Desription; UnitSubj.Desription)
            {
            }
            column(Student_Units_Programme; Programme)
            {
            }
            column(Student_Units_Stage; Stage)
            {
            }
            column(Student_Units_Semester; Semester)
            {
            }
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(sCount; sCount)
            {
            }
            column(Student_UnitsCaption; Student_UnitsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_Units_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Student_Units_StageCaption; FIELDCAPTION(Stage))
            {
            }
            column(Student_Units_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Student_NameCaption; Student_NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Student_Units_UnitCaption; FIELDCAPTION(Unit))
            {
            }
            column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Student_Units_ENo; ENo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Student Units"."Student No.") THEN
                    CustName := Cust.Name;

                sCount := sCount + 1;

                UnitSubj.RESET;
                UnitSubj.SETRANGE(UnitSubj.Code, "ACA-Student Units".Unit);
                IF UnitSubj.FIND('-') THEN
                    UnitDesc := UnitSubj.Desription;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Unit);
                "ACA-Student Units".SETFILTER("ACA-Student Units".Unit, "ACA-Student Units".GETFILTER("ACA-Student Units"."Unit Filter"));
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
        Cust: Record 18;
        CustName: Text[100];
        UnitSubj: Record 61517;
        UnitDesc: Text[100];
        sCount: Integer;
        Student_UnitsCaptionLbl: Label 'Student Units';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Student_NameCaptionLbl: Label 'Student Name';
        EmptyStringCaptionLbl: Label '#';
}

