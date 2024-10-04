report 51462 "Enrollement Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Enrollement Details.rdl';

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING(Programmes)
                                WHERE(Reversed = CONST(false),
                                      Blocked = CONST(0),
                                      "Total Billed" = FILTER(> 0),
                                      "Total Paid" = FILTER(> 0));
            RequestFilterFields = Programmes, "Academic Year", "Semester Filter", "Intake Code", "Settlement Type", Stage, "Programme Exam Category", "Student Status";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
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
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration__Course_Registration___Academic_Year_; "ACA-Course Registration"."Academic Year")
            {
            }
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
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
            column(RoomNo; RoomNo)
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
            column(Enrollment_DetailsCaption; Enrollment_DetailsCaptionLbl)
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
            column(Room_NoCaption; Room_NoCaptionLbl)
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

                CALCFIELDS("Total Billed");
                IF "Total Billed" = 0 THEN ERROR('Please note that the Billed Amount can not be Zero');

                GenSetup.GET;
                IF GenSetup."Allowed Reg. Fees Perc." = 0 THEN
                    ERROR('Please not that you must specify the Required Fees Percentage in the General setup');

                Custs.RESET;
                Custs.SETRANGE(Custs."No.", "ACA-Course Registration"."Student No.");
                IF Custs.FIND('-') THEN BEGIN
                    Custs.CALCFIELDS(Custs."Balance (LCY)");
                    IF ((("ACA-Course Registration"."Total Billed" - Custs."Balance (LCY)") / "ACA-Course Registration"."Total Billed") * 100)
                    >= GenSetup."Allowed Reg. Fees Perc." THEN BEGIN
                        "ACA-Course Registration".Registered := TRUE;
                        "ACA-Course Registration".MODIFY;
                    END;
                END;




                IF "ACA-Course Registration".Registered = FALSE THEN CurrReport.SKIP;


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
        Enrollment_DetailsCaptionLbl: Label 'Enrollment Details';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Academic_Year_CaptionLbl: Label 'Academic Year:';
        Student_NameCaptionLbl: Label 'Student Name';
        Room_NoCaptionLbl: Label 'Room No';
        Total_Students_CaptionLbl: Label 'Total Students:';
        Total_Male_CaptionLbl: Label 'Total Male:';
        Total_Female_CaptionLbl: Label 'Total Female:';
        Total_IB_CaptionLbl: Label 'Total IB:';
        Total_SSP_CaptionLbl: Label 'Total SSP:';
        Total_JAB_CaptionLbl: Label 'Total JAB:';
        GenSetup: Record 61534;
        Custs: Record 18;
}

