report 51504 "Class List - Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Class List - Listing.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Student Type")
                                WHERE(Reversed = CONST(false),
                                      "Total Paid" = FILTER(> 1500));
            RequestFilterFields = "Student Type", Programmes, Stage, Semester;
            column(StudType; StudType)
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration__Course_Registration__Programme; "ACA-Course Registration"."Programme Units Done")
            {
            }
            column(Course_Registration__Course_Registration__Programme_Control1000000018; "ACA-Course Registration".Programmes)
            {
            }
            column(Course_Registration__Course_Registration__Semester; "ACA-Course Registration".Semester)
            {
            }
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(SName; SName)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration__Registration_Date_; "Registration Date")
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(StageCaption; StageCaptionLbl)
            {
            }
            column(Student_TypeCaption; Student_TypeCaptionLbl)
            {
            }
            column(semester_filterCaption; semester_filterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Registration_Date_Caption; FIELDCAPTION("Registration Date"))
            {
            }
            column(NameCaption; NameCaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                    SName := Cust.Name
                ELSE
                    SName := '';
                Hesabu := Hesabu + 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Student Type");

                //"Course Registration".SETFILTER("Course Registration".Semester,ProgramStages.GETFILTER(ProgramStages."Semester Filter"));
                //"Course Registration".SETFILTER("Course Registration"."Registration Date",
                //ProgramStages.GETFILTER(ProgramStages."Date Filter"));
                //"Course Registration".SETFILTER("Course Registration".Status,ProgramStages.GETFILTER(ProgramStages.Status));
                Stage := "ACA-Course Registration".GETFILTER("ACA-Course Registration".Stage);
                StudType := "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Student Type");
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
        TotalIncome: Decimal;
        TotalReg: Integer;
        Cust: Record 18;
        SName: Text[200];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Hesabu: Integer;
        Stage: Text[30];
        StudType: Text[30];
        ProgramStages: Record 61516;
        "Code": Code[10];
        Description: Text[30];
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        StageCaptionLbl: Label 'Stage';
        Student_TypeCaptionLbl: Label 'Student Type';
        semester_filterCaptionLbl: Label 'semester filter';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ProgrammeCaptionLbl: Label 'Programme';
        NameCaptionLbl: Label 'Name';
}

