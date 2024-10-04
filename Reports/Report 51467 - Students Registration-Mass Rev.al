report 51467 "Students Registration-Mass Rev"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Registration-Mass Rev.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING(Programmes, Stage)
                                WHERE(Reversed = FILTER(false),
                                      "Cust Exist" = FILTER(> 0),
                                      Balance = FILTER(> 1),
                                      Status = FILTER(Current));
            RequestFilterFields = "Settlement Type", "Registration Date", Programmes, "Academic Year", "Semester Filter", "Intake Code", Stage, "Programme Exam Category", "Student Status", Faculty, Balance;
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
            column(Cust_ID; Cust."ID No")
            {
            }
            column(USERID; USERID)
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Programme_CourseRegistration; "ACA-Course Registration".Programmes)
            {
            }
            column(Course_Registration__Course_Registration___Academic_Year_; "ACA-Course Registration"."Academic Year")
            {
            }
            column(Course_Registration__Course_Registration__Faculty; "ACA-Course Registration".Faculty)
            {
            }
            column(Programme_______ProgName; Programmes + ' - ' + ProgName)
            {
            }
            column(Course_Registration__Student_No__; "Student No.")
            {
            }
            column(Course_Registration__Settlement_Type_; "Settlement Type")
            {
            }
            column(Course_Registration_Gender; Gender)
            {
            }
            column(CustName; CustName)
            {
            }
            column(NCount; NCount)
            {
            }
            column(Course_Registration__Course_Registration__Stage; "ACA-Course Registration".Stage)
            {
            }
            column(EmptyString; '_____________________')
            {
            }
            column(EmptyString_Control1102755003; '_____________________')
            {
            }
            column(TCount; TCount)
            {
            }
            column(MCount; MCount)
            {
            }
            column(FCount; FCount)
            {
            }
            column(IBCount; IBCount)
            {
            }
            column(SSCount; SSCount)
            {
            }
            column(JCount; JCount)
            {
            }
            column(Enrollment_Details__All_StudentsCaption; Enrollment_Details__All_StudentsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_Registration_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Academic_Year_Caption; Academic_Year_CaptionLbl)
            {
            }
            column(FacultyCaption; FacultyCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Course_Registration__Settlement_Type_Caption; FIELDCAPTION("Settlement Type"))
            {
            }
            column(Course_Registration_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(Student_NameCaption; Student_NameCaptionLbl)
            {
            }
            column(YearCaption; YearCaptionLbl)
            {
            }
            column(SignCaption; SignCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Total_Students_Caption; Total_Students_CaptionLbl)
            {
            }
            column(Total_Male_Caption; Total_Male_CaptionLbl)
            {
            }
            column(Total_Female_Caption; Total_Female_CaptionLbl)
            {
            }
            column(Total_IB_Caption; Total_IB_CaptionLbl)
            {
            }
            column(Total_SSP_Caption; Total_SSP_CaptionLbl)
            {
            }
            column(Total_JAB_Caption; Total_JAB_CaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Programme; Programmes)
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
            column(Balance; "ACA-Course Registration".Balance)
            {
            }
            column(RoomNo; "ACA-Course Registration"."Room No")
            {
            }
            column(HostelNo; "ACA-Course Registration"."Hostel No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                NCount := NCount + 1;
                TCount := TCount + 1;
                IF Prog.GET("ACA-Course Registration".Programmes) THEN
                    ProgName := Prog.Description
                ELSE
                    ProgName := '';

                IF Cust.GET("ACA-Course Registration"."Student No.") THEN
                    CustName := Cust.Name
                ELSE
                    CustName := '';

                StudHostel.RESET;
                StudHostel.SETRANGE(StudHostel.Student, "ACA-Course Registration"."Student No.");
                StudHostel.SETRANGE(StudHostel.Semester, "ACA-Course Registration".Semester);
                StudHostel.SETFILTER(StudHostel.Cleared, '%1', FALSE);
                IF StudHostel.FIND('-') THEN
                    RoomNo := StudHostel."Space No";

                IF "ACA-Course Registration"."Settlement Type" = 'SSP' THEN
                    SSCount := SSCount + 1;
                IF "ACA-Course Registration"."Settlement Type" = 'JAB' THEN
                    JCount := JCount + 1;
                IF "ACA-Course Registration"."Settlement Type" = 'IB' THEN
                    IBCount := IBCount + 1;
                IF "ACA-Course Registration".Gender = "ACA-Course Registration".Gender::" " THEN
                    MCount := MCount + 1;
                IF "ACA-Course Registration".Gender = "ACA-Course Registration".Gender::Male THEN
                    FCount := FCount + 1;

                IF MassStop = TRUE THEN BEGIN
                    "ACA-Course Registration".Reversed := TRUE;
                    "ACA-Course Registration"."Mass Stop" := TRUE;
                    "ACA-Course Registration"."Mass Stopped By" := USERID;
                    "ACA-Course Registration"."Mass Stooped Date" := TODAY;
                    "ACA-Course Registration".MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Programmes);
                NCount := 0;
                IF "ACA-Course Registration".GETFILTER("ACA-Course Registration"."Semester Filter") <> '' THEN
                    "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, "ACA-Course Registration".GETFILTER(
                    "ACA-Course Registration"."Semester Filter"));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MassStop; MassStop)
                {
                    Caption = 'Stop Registration';
                    ApplicationArea = All;
                }
            }
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
        Prog: Record 61511;
        Cust: Record 18;
        CustName: Code[100];
        ProgName: Code[100];
        NCount: Integer;
        TCount: Integer;
        JCount: Integer;
        SSCount: Integer;
        IBCount: Integer;
        MCount: Integer;
        FCount: Integer;
        StudHostel: Record 61155;
        RoomNo: Code[20];
        Enrollment_Details__All_StudentsCaptionLbl: Label 'Enrollment Details- All Students';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Academic_Year_CaptionLbl: Label 'Academic Year:';
        FacultyCaptionLbl: Label 'Faculty';
        Student_NameCaptionLbl: Label 'Student Name';
        YearCaptionLbl: Label 'Year';
        SignCaptionLbl: Label 'Sign';
        DateCaptionLbl: Label 'Date';
        Total_Students_CaptionLbl: Label 'Total Students:';
        Total_Male_CaptionLbl: Label 'Total Male:';
        Total_Female_CaptionLbl: Label 'Total Female:';
        Total_IB_CaptionLbl: Label 'Total IB:';
        Total_SSP_CaptionLbl: Label 'Total SSP:';
        Total_JAB_CaptionLbl: Label 'Total JAB:';
        ValUnits: Boolean;
        MassStop: Boolean;
}

