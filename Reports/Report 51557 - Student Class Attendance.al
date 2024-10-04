report 51557 "Student Class Attendance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Class Attendance.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            DataItemTableView = WHERE(Taken = CONST(true));
            RequestFilterFields = Programme, Unit, "Student No.", "Reg. Transacton ID";
            column(Student_Units_Programme; Programme)
            {
            }
            column(Student_Units_Stage; Stage)
            {
            }
            column(UDesc; UDesc)
            {
            }
            column(CreditH; CreditH)
            {
            }
            column(Student_Units_Remarks; Remarks)
            {
            }
            column(Student_Units__Student_No__; "Student No.")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(RCount; RCount)
            {
            }
            column(Student_Units_Attendance; Attendance)
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(KCA_UniversityCaption; KCA_UniversityCaptionLbl)
            {
            }
            column(Student_Class_AttendanceCaption; Student_Class_AttendanceCaptionLbl)
            {
            }
            column(Student_Units__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Programme_FilterCaption; Programme_FilterCaptionLbl)
            {
            }
            column(Stage_FilterCaption; Stage_FilterCaptionLbl)
            {
            }
            column(Unit_FilterCaption; Unit_FilterCaptionLbl)
            {
            }
            column(Student_Units_AttendanceCaption; FIELDCAPTION(Attendance))
            {
            }
            column(Credit_HoursCaption; Credit_HoursCaptionLbl)
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
                Unitz.RESET;
                Unitz.SETRANGE(Unitz."Programme Code", Programme);
                Unitz.SETRANGE(Unitz.Code, Unit);
                IF Unitz.FIND('-') THEN BEGIN
                    UDesc := Unitz.Desription;
                    CreditH := Unitz."Credit Hours";
                END;

                IF "ACA-Student Units".Taken = TRUE THEN BEGIN
                    IF "ACA-Student Units".Attendance < (0.75 * CreditH) THEN BEGIN
                        Remarks := 'Incomplete';
                    END ELSE BEGIN
                        Grade := '';
                        Remarks := 'Complete';
                    END;


                END ELSE BEGIN
                    Grade := '';
                    Remarks := '**Exempted**';


                END;

                RCount := RCount + 1;

            end;

            trigger OnPreDataItem()
            begin
                CreditH := 0;
                UDesc := '';
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

        RFound: Boolean;
        UDesc: Text[200];
        Unitz: Record 61517;
        Result: Decimal;
        Grade: Text[150];
        Remarks: Text[150];
        TotalScore: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Desc: Text[200];
        OScore: Decimal;
        OUnits: Integer;
        MeanScore: Decimal;
        MeanGrade: Code[20];
        LastRemark: Text[200];

        RCount: Integer;
        CreditH: Decimal;
        RemarkCaptionLbl: Label 'Remark';
        KCA_UniversityCaptionLbl: Label 'KCA University';
        Student_Class_AttendanceCaptionLbl: Label 'Student Class Attendance';
        NameCaptionLbl: Label 'Name';
        Programme_FilterCaptionLbl: Label 'Programme Filter';
        Stage_FilterCaptionLbl: Label 'Stage Filter';
        Unit_FilterCaptionLbl: Label 'Unit Filter';
        Credit_HoursCaptionLbl: Label 'Credit Hours';
}

