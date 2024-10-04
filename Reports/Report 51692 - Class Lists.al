report 51692 "Class Lists"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Class Lists.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Semester Filter", "Date Filter";
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme__Semester_Filter_; "Semester Filter")
            {
            }
            column(Programme__School_Code_; "School Code")
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Stage; Stage)
            {
            }
            column(StudType; StudType)
            {
            }
            column(ProgrammeCaption; ProgrammeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme__Semester_Filter_Caption; FIELDCAPTION("Semester Filter"))
            {
            }
            column(Programme__School_Code_Caption; FIELDCAPTION("School Code"))
            {
            }
            column(LectureCaption; LectureCaptionLbl)
            {
            }
            column(StageCaption; StageCaptionLbl)
            {
            }
            column(Issued_OnCaption; Issued_OnCaptionLbl)
            {
            }
            column(Student_TypeCaption; Student_TypeCaptionLbl)
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                RequestFilterFields = "Programme Code";
                column(TotalReg; TotalReg)
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = Programmes = FIELD("Programme Code"),
                                   Stage = FIELD(Code);
                    DataItemTableView = SORTING("Student Type");
                    RequestFilterFields = "Student Type", Programmes, Stage;
                    column(SName; SName)
                    {
                    }
                    column(Hesabu; Hesabu)
                    {
                    }
                    column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                    {
                    }
                    column(Course_Registration_Student_No_; "Student No.")
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

                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Semester Filter"))
                        ;
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration"."Registration Date",
                        "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Date Filter"));
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Status, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages".Status));
                        Stage := "ACA-Course Registration".GETFILTER("ACA-Course Registration".Stage);
                        StudType := "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Student Type");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TotalIncome := TotalIncome + "ACA-Programme Stages"."Total Income";
                    TotalReg := TotalReg + "ACA-Programme Stages"."Student Registered";
                end;

                trigger OnPreDataItem()
                begin
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Semester Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages"."Date Filter", "ACA-Programme".GETFILTER("ACA-Programme"."Date Filter"));
                    "ACA-Programme Stages".SETFILTER("ACA-Programme Stages".Status, "ACA-Programme".GETFILTER("ACA-Programme".Status));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalIncome := 0;
                TotalReg := 0;
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
        ProgrammeCaptionLbl: Label 'Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        LectureCaptionLbl: Label 'Lecture';
        StageCaptionLbl: Label 'Stage';
        Issued_OnCaptionLbl: Label 'Issued On';
        Student_TypeCaptionLbl: Label 'Student Type';
}

