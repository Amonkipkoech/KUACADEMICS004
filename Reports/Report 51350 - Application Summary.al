report 51350 "Application Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Application Summary.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
        {
            DataItemTableView = SORTING("Application No.");
            RequestFilterFields = "Application No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(SUMMARY_LIST_FOR_SPECIAL_ADMISSION_______Application_Form_Header___Academic_Year_______; 'SUMMARY LIST FOR SPECIAL ADMISSION (' + "ACA-Applic. Form Header"."Academic Year" + ')')
            {
            }
            column(Surname________Other_Names_; Surname + ' ' + "Other Names")
            {
            }
            column(Application_Form_Header__Address_for_Correspondence1_; "Address for Correspondence1")
            {
            }
            column(Application_Form_Header__Address_for_Correspondence2_; "Address for Correspondence2")
            {
            }
            column(Application_Form_Header__Address_for_Correspondence3_; "Address for Correspondence3")
            {
            }
            column(Application_Form_Header__Mean_Grade_Acquired_; "Mean Grade Acquired")
            {
            }
            column(Application_Form_Header__HOD_Recommendations_; "HOD Recommendations")
            {
            }
            column(Application_Form_Header__Dean_Recommendations_; "Dean Recommendations")
            {
            }
            column(CourseName; CourseName)
            {
            }
            column(Qualifications; Qualifications)
            {
            }
            column(IntC; IntC)
            {
            }
            column(NAMECaption; NAMECaptionLbl)
            {
            }
            column(ADDRESSCaption; ADDRESSCaptionLbl)
            {
            }
            column(QUALIFICATIONCaption; QUALIFICATIONCaptionLbl)
            {
            }
            column(MEAN_GRADECaption; MEAN_GRADECaptionLbl)
            {
            }
            column(COURSE_REQUIREDCaption; COURSE_REQUIREDCaptionLbl)
            {
            }
            column(REMARKS_FROM_DEANS_HODCaption; REMARKS_FROM_DEANS_HODCaptionLbl)
            {
            }
            column(CONFIRMED_BY_Caption; CONFIRMED_BY_CaptionLbl)
            {
            }
            column(APPROVED_BY_Caption; APPROVED_BY_CaptionLbl)
            {
            }
            column(DATE_Caption; DATE_CaptionLbl)
            {
            }
            column(DATE_Caption_Control1102760039; DATE_Caption_Control1102760039Lbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760041; EmptyStringCaption_Control1102760041Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760042; EmptyStringCaption_Control1102760042Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760043; EmptyStringCaption_Control1102760043Lbl)
            {
            }
            column(DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaption; DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl)
            {
            }
            column(CHAIRMAN__DEANS_COMMITTEECaption; CHAIRMAN__DEANS_COMMITTEECaptionLbl)
            {
            }
            column(APPROVED_BY_Caption_Control1102760001; APPROVED_BY_Caption_Control1102760001Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760004; EmptyStringCaption_Control1102760004Lbl)
            {
            }
            column(CHAIRMAN__SENATECaption; CHAIRMAN__SENATECaptionLbl)
            {
            }
            column(DATE_Caption_Control1102760048; DATE_Caption_Control1102760048Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760049; EmptyStringCaption_Control1102760049Lbl)
            {
            }
            column(Application_Form_Header_Application_No_; "Application No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*Get the name of the course from the database*/
                IntC := IntC + 1;
                Programme.RESET;
                IF Programme.GET("ACA-Applic. Form Header"."First Degree Choice") THEN BEGIN
                    CourseName := Programme.Description;
                END;
                /*Get the qualifications from the database*/

                Qualifications := '';

                AppSubject.RESET;
                AppSubject.SETRANGE(AppSubject."Application No.", "ACA-Applic. Form Header"."Application No.");
                IF AppSubject.FIND('-') THEN BEGIN
                    REPEAT
                        Qualifications := Qualifications + AppSubject."Subject Code" + '  ' + AppSubject.Grade + '' + ';';
                    UNTIL AppSubject.NEXT = 0;
                END;

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
        CourseName: Text[100];
        Qualifications: Text[200];
        IntC: Integer;
        Programme: Record 61511;
        AppSubject: Record 61362;
        NAMECaptionLbl: Label 'NAME';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        QUALIFICATIONCaptionLbl: Label 'QUALIFICATION';
        MEAN_GRADECaptionLbl: Label 'MEAN GRADE';
        COURSE_REQUIREDCaptionLbl: Label 'COURSE REQUIRED';
        REMARKS_FROM_DEANS_HODCaptionLbl: Label 'REMARKS FROM DEANS/HOD';
        CONFIRMED_BY_CaptionLbl: Label 'CONFIRMED BY:';
        APPROVED_BY_CaptionLbl: Label 'APPROVED BY:';
        DATE_CaptionLbl: Label 'DATE:';
        DATE_Caption_Control1102760039Lbl: Label 'DATE:';
        EmptyStringCaptionLbl: Label '__________________________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760041Lbl: Label '__________________________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760042Lbl: Label '__________________________________________________________________________________________________________________________________';
        EmptyStringCaption_Control1102760043Lbl: Label '__________________________________________________________________________________________________________________________________';
        DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl: Label 'DEPUTY REGISTRAR, ACADEMIC AFFAIRS';
        CHAIRMAN__DEANS_COMMITTEECaptionLbl: Label 'CHAIRMAN, DEANS COMMITTEE';
        APPROVED_BY_Caption_Control1102760001Lbl: Label 'APPROVED BY:';
        EmptyStringCaption_Control1102760004Lbl: Label '__________________________________________________________________________________________________________________________________';
        CHAIRMAN__SENATECaptionLbl: Label 'CHAIRMAN, SENATE';
        DATE_Caption_Control1102760048Lbl: Label 'DATE:';
        EmptyStringCaption_Control1102760049Lbl: Label '__________________________________________________________________________________________________________________________________';
}

