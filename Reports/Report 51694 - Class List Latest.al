/// <summary>
/// Report Class List Latest (ID 51694).
/// </summary>
report 51694 "Class List Latest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Class List Latest.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Student Type")
                                      //WHERE(Reversed = const(No),
                                      //Registered = CONST(Yes))
                                      ;
            RequestFilterFields = Programmes, Stage, Semester, "Student Type", "Settlement Type";
            column(StudType; StudType)
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration__Course_Registration__Programme; Programmes)
            {
            }
            column(Course_Registration__Course_Registration__Programme_Control1000000018; Programmes)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Course_Registration__Course_Registration__Semester; Semester)
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
            column(Hesabu; Hesabu)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(MONCaption; MONCaptionLbl)
            {
            }
            column(TUECaption; TUECaptionLbl)
            {
            }
            column(WEDCaption; WEDCaptionLbl)
            {
            }
            column(THURCaption; THURCaptionLbl)
            {
            }
            column(FRICaption; FRICaptionLbl)
            {
            }
            column(SATCaption; SATCaptionLbl)
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
            column(Issued_OnCaption; Issued_OnCaptionLbl)
            {
            }
            column(LecturerCaption; LecturerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Class_List___Paid_StudentsCaption; Class_List___Paid_StudentsCaptionLbl)
            {
            }
            column(SUNCaption; SUNCaptionLbl)
            {
            }
            column(MONCaption_Control1000000003; MONCaption_Control1000000003Lbl)
            {
            }
            column(TUECaption_Control1000000004; TUECaption_Control1000000004Lbl)
            {
            }
            column(WEDCaption_Control1000000005; WEDCaption_Control1000000005Lbl)
            {
            }
            column(THURCaption_Control1000000006; THURCaption_Control1000000006Lbl)
            {
            }
            column(FRICaption_Control1000000041; FRICaption_Control1000000041Lbl)
            {
            }
            column(SATCaption_Control1000000043; SATCaption_Control1000000043Lbl)
            {
            }
            column(SUNCaption_Control1000000044; SUNCaption_Control1000000044Lbl)
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
                IF Cust.GET("Student No.") THEN
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
                Stage := GETFILTER(Stage);
                StudType := GETFILTER("Student Type");
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
        MONCaptionLbl: Label 'MON';
        TUECaptionLbl: Label 'TUE';
        WEDCaptionLbl: Label 'WED';
        THURCaptionLbl: Label 'THUR';
        FRICaptionLbl: Label 'FRI';
        SATCaptionLbl: Label 'SAT';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        StageCaptionLbl: Label 'Stage';
        Student_TypeCaptionLbl: Label 'Student Type';
        semester_filterCaptionLbl: Label 'semester filter';
        Issued_OnCaptionLbl: Label 'Issued On';
        LecturerCaptionLbl: Label 'Lecturer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Class_List___Paid_StudentsCaptionLbl: Label 'Class List - Paid Students';
        SUNCaptionLbl: Label 'SUN';
        MONCaption_Control1000000003Lbl: Label 'MON';
        TUECaption_Control1000000004Lbl: Label 'TUE';
        WEDCaption_Control1000000005Lbl: Label 'WED';
        THURCaption_Control1000000006Lbl: Label 'THUR';
        FRICaption_Control1000000041Lbl: Label 'FRI';
        SATCaption_Control1000000043Lbl: Label 'SAT';
        SUNCaption_Control1000000044Lbl: Label 'SUN';
}

