/// <summary>
/// Report Mark Sheet (ID 51578).
/// </summary>
report 51578 "Mark Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Mark Sheet.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Stage Filter", "Semester Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(FDesc; FDesc)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Dept; Dept)
            {
            }
            column(Individual_Mark_SheetCaption; Individual_Mark_SheetCaptionLbl)
            {
            }
            column(Faculty_Caption; Faculty_CaptionLbl)
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Stage_Filter; "Stage Filter")
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code),
                               Code = FIELD("Stage Filter");
                column(Programme_Stages_Description; Description)
                {
                }
                column(Year_Caption; Year_CaptionLbl)
                {
                }
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
                {
                    DataItemLink = "Programme Code" = FIELD("Programme Code"),
                                   "Stage Code" = FIELD(Code);
                    RequestFilterFields = "Code";
                    column(Units_Subjects_Desription; Desription)
                    {
                    }
                    column(Units_Subjects__No__Units_; "No. Units")
                    {
                    }
                    column(Units_Subjects_Code; Code)
                    {
                    }
#pragma warning disable AL0667
                    column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
                    {
                    }
                    column(RemarksCaption; RemarksCaptionLbl)
                    {
                    }
                    column(GradeCaption; GradeCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760083; EmptyStringCaption_Control1102760083Lbl)
                    {
                    }
                    column(Agreed_Total_MarksCaption; Agreed_Total_MarksCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760084; EmptyStringCaption_Control1102760084Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760087; EmptyStringCaption_Control1102760087Lbl)
                    {
                    }
                    column(Total_marksCaption; Total_marksCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760080; EmptyStringCaption_Control1102760080Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760081; EmptyStringCaption_Control1102760081Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760082; EmptyStringCaption_Control1102760082Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760085; EmptyStringCaption_Control1102760085Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760088; EmptyStringCaption_Control1102760088Lbl)
                    {
                    }
                    column(Exam_Marks_70_Caption; Exam_Marks_70_CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760077; EmptyStringCaption_Control1102760077Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760078; EmptyStringCaption_Control1102760078Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760079; EmptyStringCaption_Control1102760079Lbl)
                    {
                    }
                    column(C_W_30_Caption; C_W_30_CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760074; EmptyStringCaption_Control1102760074Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760075; EmptyStringCaption_Control1102760075Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760076; EmptyStringCaption_Control1102760076Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760071; EmptyStringCaption_Control1102760071Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760072; EmptyStringCaption_Control1102760072Lbl)
                    {
                    }
                    column(EmptyStringCaption_Control1102760073; EmptyStringCaption_Control1102760073Lbl)
                    {
                    }
                    column(Title_of_Paper_Caption; Title_of_Paper_CaptionLbl)
                    {
                    }
                    column(Name_of_CandidateCaption; Name_of_CandidateCaptionLbl)
                    {
                    }
                    column(No__of_Units_Caption; No__of_Units_CaptionLbl)
                    {
                    }
                    column(Registration_NumberCaption; Registration_NumberCaptionLbl)
                    {
                    }
                    column(Serial_NumberCaption; Serial_NumberCaptionLbl)
                    {
                    }
                    column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
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
                    dataitem("ACA-Student Units"; "ACA-Student Units")
                    {
                        DataItemLink = Programme = FIELD("Programme Code"),
                                       Stage = FIELD("Stage Code"),
                                       Unit = FIELD(Code);
                        column(Student_Units__Student_No__; "Student No.")
                        {
                        }
                        column(RCount; RCount)
                        {
                        }
                        column(Names; Names)
                        {
                        }
                        column(ICaption; ICaptionLbl)
                        {
                        }
                        column(ECaption; ECaptionLbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760049; EmptyStringCaption_Control1102760049Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760050; EmptyStringCaption_Control1102760050Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760052; EmptyStringCaption_Control1102760052Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760053; EmptyStringCaption_Control1102760053Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760054; EmptyStringCaption_Control1102760054Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760048; EmptyStringCaption_Control1102760048Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760051; EmptyStringCaption_Control1102760051Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760055; EmptyStringCaption_Control1102760055Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760056; EmptyStringCaption_Control1102760056Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760057; EmptyStringCaption_Control1102760057Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760058; EmptyStringCaption_Control1102760058Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760059; EmptyStringCaption_Control1102760059Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760060; EmptyStringCaption_Control1102760060Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760061; EmptyStringCaption_Control1102760061Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760062; EmptyStringCaption_Control1102760062Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760063; EmptyStringCaption_Control1102760063Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760064; EmptyStringCaption_Control1102760064Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760065; EmptyStringCaption_Control1102760065Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760066; EmptyStringCaption_Control1102760066Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760067; EmptyStringCaption_Control1102760067Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760068; EmptyStringCaption_Control1102760068Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760069; EmptyStringCaption_Control1102760069Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102760070; EmptyStringCaption_Control1102760070Lbl)
                        {
                        }
                        column(Signed_by__________________________________________________________________________________________Caption; Signed_by__________________________________________________________________________________________CaptionLbl)
                        {
                        }
                        column(Internal_ExaminerCaption; Internal_ExaminerCaptionLbl)
                        {
                        }
                        column(DataItem1102760027; Signed_by_Caption_Control1102760027Lbl)
                        {
                        }
                        column(Head_of_DepartmentCaption; Head_of_DepartmentCaptionLbl)
                        {
                        }
                        column(DateCaption; DateCaptionLbl)
                        {
                        }
                        column(DateCaption_Control1102760032; DateCaption_Control1102760032Lbl)
                        {
                        }
                        column(DataItem1102760033; Caption_Control1102760033Lbl)
                        {
                        }
                        column(DataItem1102760034; Caption_Control1102760034Lbl)
                        {
                        }
                        column(External_ExaminerCaption; External_ExaminerCaptionLbl)
                        {
                        }
                        column(Dean_DirectorCaption; Dean_DirectorCaptionLbl)
                        {
                        }
                        column(DateCaption_Control1102760037; DateCaption_Control1102760037Lbl)
                        {
                        }
                        column(DateCaption_Control1102760038; DateCaption_Control1102760038Lbl)
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
                        column(Student_Units_Semester; Semester)
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
                            RCount := RCount + 1;
                            Names := '';

                            IF Cust.GET("ACA-Student Units"."Student No.") THEN
                                Names := Cust.Name;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        RCount := 0;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin

                FDesc := '';
                Dept := '';

                IF FacultyR.GET("ACA-Programme".Faculty) THEN
                    FDesc := FacultyR.Description;

                DValue.RESET;
                DValue.SETRANGE(DValue.Code, "ACA-Programme"."School Code");
                IF DValue.FIND('-') THEN
                    Dept := DValue.Name;
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
        FacultyR: Record 61587;
        FDesc: Text[200];
        Dept: Text[200];
        Individual_Mark_SheetCaptionLbl: Label 'Individual Mark Sheet';
        Faculty_CaptionLbl: Label 'Faculty:';
        Programme_of_Study_CaptionLbl: Label 'Programme of Study:';
        Department_CaptionLbl: Label 'Department:';
        Exam_Date_CaptionLbl: Label 'Exam Date:';
        Year_CaptionLbl: Label 'Year:';
        RemarksCaptionLbl: Label 'Remarks';
        GradeCaptionLbl: Label 'Grade';
        EmptyStringCaptionLbl: Label '|';
        EmptyStringCaption_Control1102760083Lbl: Label '|';
        Agreed_Total_MarksCaptionLbl: Label 'Agreed Total Marks';
        EmptyStringCaption_Control1102760084Lbl: Label '|';
        EmptyStringCaption_Control1102760087Lbl: Label '|';
        Total_marksCaptionLbl: Label 'Total marks';
        EmptyStringCaption_Control1102760080Lbl: Label '|';
        EmptyStringCaption_Control1102760081Lbl: Label '|';
        EmptyStringCaption_Control1102760082Lbl: Label '|';
        EmptyStringCaption_Control1102760085Lbl: Label '|';
        EmptyStringCaption_Control1102760088Lbl: Label '|';
        Exam_Marks_70_CaptionLbl: Label 'Exam Marks 70%';
        EmptyStringCaption_Control1102760077Lbl: Label '|';
        EmptyStringCaption_Control1102760078Lbl: Label '|';
        EmptyStringCaption_Control1102760079Lbl: Label '|';
        C_W_30_CaptionLbl: Label 'C/W 30%';
        EmptyStringCaption_Control1102760074Lbl: Label '|';
        EmptyStringCaption_Control1102760075Lbl: Label '|';
        EmptyStringCaption_Control1102760076Lbl: Label '|';
        EmptyStringCaption_Control1102760071Lbl: Label '|';
        EmptyStringCaption_Control1102760072Lbl: Label '|';
        EmptyStringCaption_Control1102760073Lbl: Label '|';
        Title_of_Paper_CaptionLbl: Label 'Title of Paper:';
        Name_of_CandidateCaptionLbl: Label 'Name of Candidate';
        No__of_Units_CaptionLbl: Label 'No. of Units:';
        Registration_NumberCaptionLbl: Label 'Registration Number';
        Serial_NumberCaptionLbl: Label 'Serial Number';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ICaptionLbl: Label 'I';
        ECaptionLbl: Label 'E';
        EmptyStringCaption_Control1102760049Lbl: Label '-----------------------------------------------------------------------------------------------------------------------------------------------------------';
        EmptyStringCaption_Control1102760050Lbl: Label '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
        EmptyStringCaption_Control1102760052Lbl: Label '|';
        EmptyStringCaption_Control1102760053Lbl: Label '|';
        EmptyStringCaption_Control1102760054Lbl: Label '|';
        EmptyStringCaption_Control1102760048Lbl: Label '|';
        EmptyStringCaption_Control1102760051Lbl: Label '|';
        EmptyStringCaption_Control1102760055Lbl: Label '|';
        EmptyStringCaption_Control1102760056Lbl: Label '|';
        EmptyStringCaption_Control1102760057Lbl: Label '|';
        EmptyStringCaption_Control1102760058Lbl: Label '|';
        EmptyStringCaption_Control1102760059Lbl: Label '|';
        EmptyStringCaption_Control1102760060Lbl: Label '|';
        EmptyStringCaption_Control1102760061Lbl: Label '|';
        EmptyStringCaption_Control1102760062Lbl: Label '|';
        EmptyStringCaption_Control1102760063Lbl: Label '|';
        EmptyStringCaption_Control1102760064Lbl: Label '|';
        EmptyStringCaption_Control1102760065Lbl: Label '|';
        EmptyStringCaption_Control1102760066Lbl: Label '|';
        EmptyStringCaption_Control1102760067Lbl: Label '|';
        EmptyStringCaption_Control1102760068Lbl: Label '|';
        EmptyStringCaption_Control1102760069Lbl: Label '|';
        EmptyStringCaption_Control1102760070Lbl: Label '|';
        Signed_by__________________________________________________________________________________________CaptionLbl: Label 'Signed by:   ......................................................................................';
        Internal_ExaminerCaptionLbl: Label 'Internal Examiner';
        Signed_by_Caption_Control1102760027Lbl: Label 'Signed by:   ......................................................................................';
        Head_of_DepartmentCaptionLbl: Label 'Head of Department';
        DateCaptionLbl: Label '/Date';
        DateCaption_Control1102760032Lbl: Label '/Date';
        Caption_Control1102760033Lbl: Label 'Signed by:   ......................................................................................';
        Caption_Control1102760034Lbl: Label 'Signed by:   ......................................................................................';
        External_ExaminerCaptionLbl: Label 'External Examiner';
        Dean_DirectorCaptionLbl: Label 'Dean/Director';
        DateCaption_Control1102760037Lbl: Label '/Date';
        DateCaption_Control1102760038Lbl: Label '/Date';
}

