report 51489 "Detailed Enrollment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Detailed Enrollment.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Stage Filter", "Semester Filter", "Student Type Filter";
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
#pragma warning disable AL0667
            column(CurrReport_PAGENO_Control1000000006; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(TIME; TIME)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(HS; HS)
            {
            }
            column(Semester_Nomnal_RollCaption; Semester_Nomnal_RollCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Student_No_Caption; Student_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(GenderCaption; GenderCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DistrictCaption; DistrictCaptionLbl)
            {
            }
            column(Student_s_SignatureCaption; Student_s_SignatureCaptionLbl)
            {
            }
            column(Officer_s_SignatureCaption; Officer_s_SignatureCaptionLbl)
            {
            }
            column(Customer_NationalityCaption; Customer.FIELDCAPTION(Nationality))
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(Passport_or_National_IDCaption; Passport_or_National_IDCaptionLbl)
            {
            }
            column(Hall_and_Room_No_Caption; Hall_and_Room_No_CaptionLbl)
            {
            }
            column(Total_StudentsCaption; Total_StudentsCaptionLbl)
            {
            }
            column(Programme_Stage_Filter; "Stage Filter")
            {
            }
            column(Programme_Semester_Filter; "Semester Filter")
            {
            }
            column(Programme_Student_Type_Filter; "Student Type Filter")
            {
            }
            dataitem("ACA-Programme Stages"; "ACA-Programme Stages")
            {
                DataItemLink = "Programme Code" = FIELD(Code),
                               Code = FIELD("Stage Filter"),
                               "Semester Filter" = FIELD("Semester Filter"),
                               "Student Type Filter" = FIELD("Student Type Filter");
                PrintOnlyIfDetail = true;
                column(Programme_Stages_Programme_Code; "Programme Code")
                {
                }
                column(Programme_Stages_Code; Code)
                {
                }
                column(Programme_Stages_Semester_Filter; "Semester Filter")
                {
                }
                column(Programme_Stages_Student_Type_Filter; "Student Type Filter")
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = Programmes = FIELD("Programme Code"),
                                   Stage = FIELD(Code),
                                   Semester = FIELD("Semester Filter"),
                                   "Settlement Type" = FIELD("Student Type Filter");
                    DataItemTableView = SORTING("Student Type")
                                        WHERE(Reversed = CONST(false));
                    PrintOnlyIfDetail = true;
                    RequestFilterFields = "Settlement Type", "Student No.", Registered;
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
                    column(Course_Registration_Settlement_Type; "Settlement Type")
                    {
                    }
                    dataitem(Customer; Customer)
                    {
                        DataItemLink = "No." = FIELD("Student No.");
                        DataItemTableView = WHERE(Status = FILTER(Registration | Current));
                        RequestFilterFields = District;
                        column(Customer_Name; Name)
                        {
                        }
                        column(Customer__No__; "No.")
                        {
                        }
                        column(Customer_Gender; Gender)
                        {
                        }
                        column(SNo; SNo)
                        {
                        }
                        column(dist; dist)
                        {
                        }
                        column(Customer_Nationality; Nationality)
                        {
                        }
                        column(Customer__ID_No_; "ID No")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            SNo := SNo + 1;
                            IF distrec.GET(Customer.District) THEN
                                dist := distrec.Description;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        /*
                        IF Cust.GET("Course Registration"."Student No.") THEN BEGIN
                        Cust.CALCFIELDS(Cust.Balance);
                        SName:=Cust.Name;
                        SGender:=Cust.Gender;
                        SNationality:=Cust.Citizenship;
                        SBal:=Cust.Balance;
                        //Sdistrict:=
                        END
                        ELSE BEGIN
                        SName:='';
                        SGender:=Cust.Gender::Male;
                        SNationality:='KENYAN';
                        SBal:=0;
                        
                        END;
                        */

                    end;

                    trigger OnPreDataItem()
                    begin
                        LastFieldNo := FIELDNO("Student Type");

                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Semester Filter"))
                        ;
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration"."Registration Date",
                        "ACA-Programme Stages".GETFILTER("ACA-Programme Stages"."Date Filter"));
                        "ACA-Course Registration".SETFILTER("ACA-Course Registration".Status, "ACA-Programme Stages".GETFILTER("ACA-Programme Stages".Status));
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
                SNo := 0;
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
        SGender: Option Male,Female;
        SNationality: Text[50];
        SBal: Decimal;
        SNo: Integer;
        Sdistrict: Text[50];
        HS: Integer;
        distrec: Record 61365;
        dist: Text[30];
        Semester_Nomnal_RollCaptionLbl: Label 'Semester Nomnal Roll';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Student_No_CaptionLbl: Label 'Student No.';
        NameCaptionLbl: Label 'Name';
        GenderCaptionLbl: Label 'Gender';
        No_CaptionLbl: Label 'No.';
        DistrictCaptionLbl: Label 'District';
        Student_s_SignatureCaptionLbl: Label 'Student''s Signature';
        Officer_s_SignatureCaptionLbl: Label 'Officer''s Signature';
        RemarksCaptionLbl: Label 'Remarks';
        Passport_or_National_IDCaptionLbl: Label 'Passport or National ID';
        Hall_and_Room_No_CaptionLbl: Label 'Hall and Room No.';
        Total_StudentsCaptionLbl: Label 'Total Students';
}

