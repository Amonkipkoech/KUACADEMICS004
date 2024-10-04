report 51581 "Exam Attendance."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Attendance..rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
        }
        dataitem(Prog; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Stage Filter", "Semester Filter", "Unit Filter", "Intake Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(FDesc; FDesc)
            {
            }
            column(Prog_Description; Description)
            {
            }
            column(Dept; Dept)
            {
            }
            column(Examination_Attendance_ChecklistCaption; Examination_Attendance_ChecklistCaptionLbl)
            {
            }
            column(School_Caption; School_CaptionLbl)
            {
            }
            column(Programme_of_Study_Caption; Programme_of_Study_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Exam_Date_Caption; Exam_Date_CaptionLbl)
            {
            }
            column(Academic_Year_Caption; Academic_Year_CaptionLbl)
            {
            }
            column(Prog_Code; Code)
            {
            }
            column(Prog_Semester_Filter; "Semester Filter")
            {
            }
            column(Prog_Stage_Filter; "Stage Filter")
            {
            }
            column(Prog_Unit_Filter; "Unit Filter")
            {
            }
            column(CompName; cOMPiNF.Name)
            {
            }
            column(CompLogo; cOMPiNF.Picture)
            {
            }
            column(Prog_Intake_Filter; "Intake Filter")
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = Programme = FIELD(Code);
                DataItemTableView = SORTING("Student No.", Unit)
                                    ORDER(Ascending);
                column(Student_Units__Student_Units__Unit; "ACA-Student Units".Unit)
                {
                }
                column(UnitDesc; UnitDesc)
                {
                }
#pragma warning disable AL0667
                column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
                {
                }
                column(Student_Units__Student_No__; "ACA-Student Units"."Student No.")
                {
                }
                column(RCount; RCount)
                {
                }
                column(Names; Names)
                {
                }
                column(RCount_Control1000000002; RCount)
                {
                }
                column(GCount; GCount)
                {
                }
                column(Title_of_Paper_Caption; Title_of_Paper_CaptionLbl)
                {
                }
                column(Registration_NumberCaption; Registration_NumberCaptionLbl)
                {
                }
                column(Serial_NumberCaption; Serial_NumberCaptionLbl)
                {
                }
                column(Name_of_CandidateCaption; Name_of_CandidateCaptionLbl)
                {
                }
                column(SignCaption; SignCaptionLbl)
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(NAME_OF_INVIGILATORSCaption; NAME_OF_INVIGILATORSCaptionLbl)
                {
                }
                column(V1___________________________________________________Caption; V1___________________________________________________CaptionLbl)
                {
                }
                column(CHIEF_INVIGILATOR_SIGNATURECaption; CHIEF_INVIGILATOR_SIGNATURECaptionLbl)
                {
                }
                column(TOTAL_NO_OF_CANDIDATES_ON_THE_SHEETCaption; TOTAL_NO_OF_CANDIDATES_ON_THE_SHEETCaptionLbl)
                {
                }
                column(GRAND_TOTALCaption; GRAND_TOTALCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(V2___________________________________________________Caption; V2___________________________________________________CaptionLbl)
                {
                }
                column(V3___________________________________________________Caption; V3___________________________________________________CaptionLbl)
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
                column(Student_Units_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Student_Units_ENo; ENo)
                {
                }
                column(Student_Units_Registered_Programe; "Registered Programe")
                {
                }
                column(Student_Units_Session_Code; "Session Code")
                {
                }
                column(Unit_StudentUnits; "ACA-Student Units".Unit)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RCount := RCount + 1;
                    GCount := GCount + 1;
                    Names := '';

                    IF Cust.GET("ACA-Student Units"."Student No.") THEN
                        Names := Cust.Name;
                end;

                trigger OnPreDataItem()
                begin
                    // "Student Units".setfilter("Student Units".Unit,Programme.getfilter(Programme."Unit Filter"));
                    "Units/Subj".RESET;
                    "Units/Subj".SETRANGE("Units/Subj"."Programme Code", Prog.Code);
                    "Units/Subj".SETRANGE("Units/Subj".Code, Prog.GETFILTER(Prog."Unit Filter"));
                    IF "Units/Subj".FIND('-') THEN BEGIN
                        UnitDesc := "Units/Subj".Desription;
                        "UnitNo." := "Units/Subj"."No. Units";
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                FDesc := '';
                Dept := '';


                DValue.RESET;
                DValue.SETRANGE(DValue.Code, Prog."School Code");
                IF DValue.FIND('-') THEN
                    FDesc := DValue.Name;

                DValue.RESET;
                DValue.SETRANGE(DValue.Code, Prog."Department Code");
                IF DValue.FIND('-') THEN
                    Dept := DValue.Name;

                RCount := 0;
            end;

            trigger OnPreDataItem()
            begin
                cOMPiNF.GET;
                cOMPiNF.CALCFIELDS(Picture);
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
        RCount: Integer;
        Cust: Record 18;
        Names: Text[200];
        DValue: Record 349;
        FDesc: Text[200];
        Dept: Text[200];
        UnitDesc: Text[100];
        "UnitNo.": Decimal;
        "Units/Subj": Record 61517;
        GCount: Integer;
        Examination_Attendance_ChecklistCaptionLbl: Label 'Examination Attendance Checklist';
        School_CaptionLbl: Label 'School:';
        Programme_of_Study_CaptionLbl: Label 'Programme of Study:';
        Department_CaptionLbl: Label 'Department:';
        Exam_Date_CaptionLbl: Label 'Exam Date:';
        Academic_Year_CaptionLbl: Label 'Academic Year:';
        Title_of_Paper_CaptionLbl: Label 'Title of Paper:';
        Registration_NumberCaptionLbl: Label 'Registration Number';
        Serial_NumberCaptionLbl: Label 'Serial Number';
        Name_of_CandidateCaptionLbl: Label 'Name of Candidate';
        SignCaptionLbl: Label 'Sign';
        RemarksCaptionLbl: Label 'Remarks';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NAME_OF_INVIGILATORSCaptionLbl: Label 'NAME OF INVIGILATORS';
        V1___________________________________________________CaptionLbl: Label '1. .................................................';
        CHIEF_INVIGILATOR_SIGNATURECaptionLbl: Label 'CHIEF INVIGILATOR SIGNATURE';
        TOTAL_NO_OF_CANDIDATES_ON_THE_SHEETCaptionLbl: Label 'TOTAL NO OF CANDIDATES ON THE SHEET';
        GRAND_TOTALCaptionLbl: Label 'GRAND TOTAL';
        EmptyStringCaptionLbl: Label '...................................................................';
        V2___________________________________________________CaptionLbl: Label '2. .................................................';
        V3___________________________________________________CaptionLbl: Label '3. .................................................';
        cOMPiNF: Record 79;
}

