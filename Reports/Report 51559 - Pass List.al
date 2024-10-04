/// <summary>
/// Report Pass List (ID 51559).
/// </summary>
report 51559 "Pass List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Pass List.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type")
                                WHERE("Result Status" = FILTER(<> Fail));
            PrintOnlyIfDetail = true;
            RequestFilterFields = Programmes, Stage, Semester;
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
            column(Comb; Comb)
            {
            }
            column(PName; PName)
            {
            }
            column(SDesc; SDesc)
            {
            }
            column(Dept; Dept)
            {
            }
            column(FDesc; FDesc)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(RCount; RCount)
            {
            }
            column(Remark; Remark)
            {
            }
            column(Pass_ListCaption; Pass_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Year_of_Study_Caption; Year_of_Study_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Programme_of_Study_Caption; Programme_of_Study_CaptionLbl)
            {
            }
            column(Combination_Caption; Combination_CaptionLbl)
            {
            }
            column(Faculty_Caption; Faculty_CaptionLbl)
            {
            }
            column(Registration_No_Caption; Registration_No_CaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
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
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = FIELD("Student No."),
                               "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                RequestFilterFields = Taken, Failed, Status;

                trigger OnAfterGetRecord()
                begin
                    /*
                    Remark:='REPEAT';
                    PassedUnits:=0;
                    Grading.RESET;
                    Grading.SETRANGE(Grading.Category,'DEFAULT');
                    Grading.SETRANGE(Grading.Failed,TRUE);
                    IF Grading.FIND('+') THEN
                    FailScore:=Grading."Up to";
                    
                    IF "Student Units"."Total Score">=FailScore THEN begin
                       Remark:='PASSED';
                       PassedUnits:=PassedUnits+1;
                    end ELSE begin
                       Remark:='REPEAT';
                     end;
                     {
                    IF ("Course Registration"."Units Taken" - PassedUnits) > 4 THEN
                    Remark:='REPEAT';
                    
                    IF ("Course Registration"."Units Taken" - PassedUnits) <= 4 THEN
                    Remark:='REPEAT';
                    //Remark:='SUPPLEMENTARY';
                    
                    //IF "Course Registration"."Units Taken" = PassedUnits THEN
                    //Remark:='PASSED';
                    
                    "Course Registration"."General Remark":=Remark;
                    "Course Registration".MODIFY;
                    }
                     if Remark='REPEAT'then CurrReport.SKIP;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin

                RCount := RCount + 1;

                IF Dept = '' THEN BEGIN
                    IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                        PName := Prog.Description;
                        IF FacultyR.GET(Prog.Faculty) THEN
                            FDesc := FacultyR.Description;

                        DValue.RESET;
                        DValue.SETRANGE(DValue.Code, Prog."School Code");
                        IF DValue.FIND('-') THEN
                            Dept := DValue.Name;

                    END;

                    IF Stages.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage) THEN
                        SDesc := Stages.Description;

                    IF ProgOptions.GET("ACA-Course Registration".Programmes, "ACA-Course Registration".Stage, "ACA-Course Registration".Options) THEN
                        Comb := ProgOptions.Desription;


                END;



                PassedUnits := 0;
                Grading.RESET;
                Grading.SETRANGE(Grading.Category, 'DEFAULT');
                Grading.SETRANGE(Grading.Failed, TRUE);
                IF Grading.FIND('+') THEN
                    FailScore := Grading."Up to";
                PASS := TRUE;
                StudUnits.RESET;
                StudUnits.SETFILTER(StudUnits."Student No.", "ACA-Course Registration"."Student No.");
                StudUnits.SETFILTER(StudUnits."Reg. Transacton ID", "ACA-Course Registration"."Reg. Transacton ID");
                StudUnits.SETFILTER(StudUnits."Stage Filter", "ACA-Course Registration".Stage);
                //studunits.setfilter(StudUnits.Taken,true);
                IF StudUnits.FIND('-') THEN BEGIN
                    REPEAT
                        StudUnits.CALCFIELDS(StudUnits."Total Score");
                        IF StudUnits."Total Score" > FailScore THEN BEGIN
                            PassedUnits := PassedUnits + 1;
                            StudUnits.Failed := FALSE;
                            PASS := TRUE;
                        END ELSE BEGIN
                            StudUnits.Failed := TRUE;
                            StudUnits."Repeat Unit" := FALSE;
                            StudUnits.MODIFY;
                            "ACA-Course Registration"."Result Status" := "ACA-Course Registration"."Result Status"::Fail;
                            "ACA-Course Registration".MODIFY;

                            PASS := FALSE;
                        END;

                    UNTIL StudUnits.NEXT = 0;
                END;

                IF ("ACA-Course Registration"."Units Taken" - PassedUnits) > 4 THEN
                    Remark := 'REPEAT';

                IF ("ACA-Course Registration"."Units Taken" - PassedUnits) <= 4 THEN
                    Remark := 'REPEAT';
                //Remark:='SUPPLEMENTARY';

                IF "ACA-Course Registration"."Units Taken" = PassedUnits THEN
                    Remark := 'PASSED';


                IF Cust.GET("ACA-Course Registration"."Student No.") THEN BEGIN
                    IF (Cust.Status <> Cust.Status::Current) AND (Cust.Status <> Cust.Status::Registration) THEN
                        "General Remark" := FORMAT(Cust.Status);
                END;

                "ACA-Course Registration"."General Remark" := Remark;
                "ACA-Course Registration".MODIFY;

                //IF PASS=FALSE THEN CurrReport.SKIP;
            end;

            trigger OnPostDataItem()
            begin
                /*
                  IF Remark='REPEAT' THEN
                   CurrReport.SKIP;
                */

            end;

            trigger OnPreDataItem()
            begin
                RCount := 0;
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
        Cust: Record 18;
        Grading: Record 61569;
        StudUnits: Record 61549;
        FailScore: Decimal;
        PassedUnits: Integer;
        Remark: Text[150];
        RCount: Integer;
        DValue: Record 349;
        FacultyR: Record 61587;
        FDesc: Text[200];
        Dept: Text[200];
        Prog: Record 61511;
        PName: Text[200];
        Stages: Record 61516;
        SDesc: Text[200];
        ProgOptions: Record 61554;
        Comb: Text[200];
        marks: Text[255];
        PASS: Boolean;
        Pass_ListCaptionLbl: Label 'Pass List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Year_of_Study_CaptionLbl: Label 'Year of Study:';
        Department_CaptionLbl: Label 'Department:';
        Programme_of_Study_CaptionLbl: Label 'Programme of Study:';
        Combination_CaptionLbl: Label 'Combination:';
        Faculty_CaptionLbl: Label 'Faculty:';
        Registration_No_CaptionLbl: Label 'Registration No.';
}

