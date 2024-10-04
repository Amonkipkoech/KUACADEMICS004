report 51518 "Course Units Registration Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Course Units Registration Form.rdl';
    UseRequestPage = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            DataItemTableView = SORTING("Reg. Transacton ID", "Student No.", Programmes, Semester, "Register for", Stage, Unit, "Student Type", "Entry No.");
            RequestFilterFields = "Student No.", "Reg. Transacton ID";
            column(Cust_Name; Cust.Name)
            {
            }
            column(Cust__No__; Cust."No.")
            {
            }
            column(Cust__Phone_No__; Cust."Phone No.")
            {
            }
            column(Course_Registration__Course_Registration__Stage; "ACA-Course Registration".Stage)
            {
            }
            column(Course_Registration__Course_Registration__Semester; "ACA-Course Registration".Semester)
            {
            }
            column(AcademicY_Code; AcademicY.Code)
            {
            }
            column(Prog_Description; Prog.Description)
            {
            }
            column(School; School)
            {
            }
            column(STUDENTS_ADMISSION_CHECKLISTCaption; STUDENTS_ADMISSION_CHECKLISTCaptionLbl)
            {
            }
            column(YEAR_OF_STUDY_Caption; YEAR_OF_STUDY_CaptionLbl)
            {
            }
            column(SESSION_SEMSTER_Caption; SESSION_SEMSTER_CaptionLbl)
            {
            }
            column(ACADEMIC_YEAR_Caption; ACADEMIC_YEAR_CaptionLbl)
            {
            }
            column(PROGRAMME_Caption; PROGRAMME_CaptionLbl)
            {
            }
            column(SCHOOL_Caption; SCHOOL_CaptionLbl)
            {
            }
            column(V1__STUDENT_DETAILS_Caption; V1__STUDENT_DETAILS_CaptionLbl)
            {
            }
            column(NAME_Caption; NAME_CaptionLbl)
            {
            }
            column(REG__NO_Caption; REG__NO_CaptionLbl)
            {
            }
            column(MOBILE_NO_Caption; MOBILE_NO_CaptionLbl)
            {
            }
            column(V2__FINANCIAL_OBLIGATIONS_Caption; V2__FINANCIAL_OBLIGATIONS_CaptionLbl)
            {
            }
            column(AMOUNT_PAID_KSHS_____________________BALANCE_KSHS___________________DATE_PAID____________________Caption; AMOUNT_PAID_KSHS_____________________BALANCE_KSHS___________________DATE_PAID____________________CaptionLbl)
            {
            }
            column(CASHIER_S_NAME___________________________SIGN_____________________DATE_STAMP________________________Caption; CASHIER_S_NAME___________________________SIGN_____________________DATE_STAMP________________________CaptionLbl)
            {
            }
            column(V3__University_COMMON_UNITS_Caption; V3__University_COMMON_UNITS_CaptionLbl)
            {
            }
            column(UNIT_CODESCaption; UNIT_CODESCaptionLbl)
            {
            }
            column(TITLECaption; TITLECaptionLbl)
            {
            }
            column(INDICATE_RETAKE_S_Caption; INDICATE_RETAKE_S_CaptionLbl)
            {
            }
            column(SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption; SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________CaptionLbl)
            {
            }
            column(V4__DEPARTMENT_Caption; V4__DEPARTMENT_CaptionLbl)
            {
            }
            column(UNIT_CODESCaption_Control1000000037; UNIT_CODESCaption_Control1000000037Lbl)
            {
            }
            column(TITLECaption_Control1000000041; TITLECaption_Control1000000041Lbl)
            {
            }
            column(INDICATE_RETAKE_S_Caption_Control1000000043; INDICATE_RETAKE_S_Caption_Control1000000043Lbl)
            {
            }
            column(SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000045; SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000045Lbl)
            {
            }
            column(SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000051; SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000051Lbl)
            {
            }
            column(UNIT_CODESCaption_Control1000000059; UNIT_CODESCaption_Control1000000059Lbl)
            {
            }
            column(TITLECaption_Control1000000060; TITLECaption_Control1000000060Lbl)
            {
            }
            column(INDICATE_RETAKE_S_Caption_Control1000000061; INDICATE_RETAKE_S_Caption_Control1000000061Lbl)
            {
            }
            column(V5__DEPARTMENT_Caption; V5__DEPARTMENT_CaptionLbl)
            {
            }
            column(SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000063; SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000063Lbl)
            {
            }
            column(UNIT_CODESCaption_Control1000000071; UNIT_CODESCaption_Control1000000071Lbl)
            {
            }
            column(TITLECaption_Control1000000072; TITLECaption_Control1000000072Lbl)
            {
            }
            column(INDICATE_RETAKE_S_Caption_Control1000000073; INDICATE_RETAKE_S_Caption_Control1000000073Lbl)
            {
            }
            column(V6__DEPARTMENT_Caption; V6__DEPARTMENT_CaptionLbl)
            {
            }
            column(V7__STUDENTCaption; V7__STUDENTCaptionLbl)
            {
            }
            column(SIGNED____________________________DATE_______________________Caption; SIGNED____________________________DATE_______________________CaptionLbl)
            {
            }
            column(V8__DEAN_OF_SCHOOLCaption; V8__DEAN_OF_SCHOOLCaptionLbl)
            {
            }
            column(SIGNED____________________________DATE_STAMP_______________________Caption; SIGNED____________________________DATE_STAMP_______________________CaptionLbl)
            {
            }
            column(V9__REGISTRAR_S_OFFICECaption; V9__REGISTRAR_S_OFFICECaptionLbl)
            {
            }
            column(NAME______________________________SIGNED____________________________DATE_STAMP_______________________Caption; NAME______________________________SIGNED____________________________DATE_STAMP_______________________CaptionLbl)
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
                    IF Prog.GET("ACA-Course Registration".Programmes) THEN BEGIN
                        Dim.RESET;
                        Dim.SETRANGE(Dim."Dimension Code", 'SCHOOLS');
                        Dim.SETRANGE(Dim.Code, Prog."School Code");
                        IF Dim.FIND('-') THEN
                            School := Dim.Name;
                    END;
                AcademicY.RESET;
                AcademicY.SETRANGE(AcademicY.Current, TRUE);

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
        Prog: Record 61511;
        AcademicY: Record 61382;
        School: Code[100];
        Dim: Record 349;
        STUDENTS_ADMISSION_CHECKLISTCaptionLbl: Label 'STUDENTS ADMISSION CHECKLIST';
        YEAR_OF_STUDY_CaptionLbl: Label 'YEAR OF STUDY:';
        SESSION_SEMSTER_CaptionLbl: Label 'SESSION/SEMSTER:';
        ACADEMIC_YEAR_CaptionLbl: Label 'ACADEMIC YEAR:';
        PROGRAMME_CaptionLbl: Label 'PROGRAMME:';
        SCHOOL_CaptionLbl: Label 'SCHOOL:';
        V1__STUDENT_DETAILS_CaptionLbl: Label '1. STUDENT DETAILS:';
        NAME_CaptionLbl: Label 'NAME:';
        REG__NO_CaptionLbl: Label 'REG. NO.';
        MOBILE_NO_CaptionLbl: Label 'MOBILE NO.';
        V2__FINANCIAL_OBLIGATIONS_CaptionLbl: Label '2. FINANCIAL OBLIGATIONS:';
        AMOUNT_PAID_KSHS_____________________BALANCE_KSHS___________________DATE_PAID____________________CaptionLbl: Label 'AMOUNT PAID KSHS.____________________BALANCE(KSHS)__________________DATE PAID____________________';
        CASHIER_S_NAME___________________________SIGN_____________________DATE_STAMP________________________CaptionLbl: Label 'CASHIER''S NAME:__________________________SIGN_____________________DATE/STAMP________________________';
        V3__University_COMMON_UNITS_CaptionLbl: Label '3. University COMMON UNITS:';
        UNIT_CODESCaptionLbl: Label 'UNIT CODES';
        TITLECaptionLbl: Label 'TITLE';
        INDICATE_RETAKE_S_CaptionLbl: Label 'INDICATE RETAKE(S)';
        SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________CaptionLbl: Label 'SIGNED: (CHAIRMAN)__________________________DATE/STAMP_______________________';
        V4__DEPARTMENT_CaptionLbl: Label '4. DEPARTMENT:';
        UNIT_CODESCaption_Control1000000037Lbl: Label 'UNIT CODES';
        TITLECaption_Control1000000041Lbl: Label 'TITLE';
        INDICATE_RETAKE_S_Caption_Control1000000043Lbl: Label 'INDICATE RETAKE(S)';
        SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000045Lbl: Label 'SIGNED: (CHAIRMAN)__________________________DATE/STAMP_______________________';
        SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000051Lbl: Label 'SIGNED: (CHAIRMAN)__________________________DATE/STAMP_______________________';
        UNIT_CODESCaption_Control1000000059Lbl: Label 'UNIT CODES';
        TITLECaption_Control1000000060Lbl: Label 'TITLE';
        INDICATE_RETAKE_S_Caption_Control1000000061Lbl: Label 'INDICATE RETAKE(S)';
        V5__DEPARTMENT_CaptionLbl: Label '5. DEPARTMENT:';
        SIGNED___CHAIRMAN___________________________DATE_STAMP_______________________Caption_Control1000000063Lbl: Label 'SIGNED: (CHAIRMAN)__________________________DATE/STAMP_______________________';
        UNIT_CODESCaption_Control1000000071Lbl: Label 'UNIT CODES';
        TITLECaption_Control1000000072Lbl: Label 'TITLE';
        INDICATE_RETAKE_S_Caption_Control1000000073Lbl: Label 'INDICATE RETAKE(S)';
        V6__DEPARTMENT_CaptionLbl: Label '6. DEPARTMENT:';
        V7__STUDENTCaptionLbl: Label '7. STUDENT';
        SIGNED____________________________DATE_______________________CaptionLbl: Label 'SIGNED: __________________________DATE_______________________';
        V8__DEAN_OF_SCHOOLCaptionLbl: Label '8. DEAN OF SCHOOL';
        SIGNED____________________________DATE_STAMP_______________________CaptionLbl: Label 'SIGNED: __________________________DATE/STAMP_______________________';
        V9__REGISTRAR_S_OFFICECaptionLbl: Label '9. REGISTRAR''S OFFICE';
        NAME______________________________SIGNED____________________________DATE_STAMP_______________________CaptionLbl: Label 'NAME:_____________________________SIGNED: __________________________DATE/STAMP_______________________';
}

