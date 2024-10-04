report 51346 "Admission Academic Parcel"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Admission Academic Parcel.rdl';

    dataset
    {
        dataitem("ACA-Adm. Parcel Main"; 61370)
        {
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(FORMAT_DeadLineDate_0_4_; FORMAT(DeadLineDate, 0, 4))
            {
            }
            column(OFFICE_OF_THE_DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaption; OFFICE_OF_THE_DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl)
            {
            }
            column(ADMISSION_PARCELCaption; ADMISSION_PARCELCaptionLbl)
            {
            }
            column(A_Caption; A_CaptionLbl)
            {
            }
            column(The_following_documents_have_been_enclosed_for_your_attentionCaption; The_following_documents_have_been_enclosed_for_your_attentionCaptionLbl)
            {
            }
            column(Student_Personal_Details_FormCaption; Student_Personal_Details_FormCaptionLbl)
            {
            }
            column(MUS_J1_1Caption; MUS_J1_1CaptionLbl)
            {
            }
            column(Acceptance_of_offer___Non_Acceptance_of_offerCaption; Acceptance_of_offer___Non_Acceptance_of_offerCaptionLbl)
            {
            }
            column(MUS_J1_2_A___BCaption; MUS_J1_2_A___BCaptionLbl)
            {
            }
            column(Student_Medical_ExaminationCaption; Student_Medical_ExaminationCaptionLbl)
            {
            }
            column(MUS_J1_3Caption; MUS_J1_3CaptionLbl)
            {
            }
            column(Emergency_OperationCaption; Emergency_OperationCaptionLbl)
            {
            }
            column(MUS_J1_4Caption; MUS_J1_4CaptionLbl)
            {
            }
            column(General_Information_to_StudentsCaption; General_Information_to_StudentsCaptionLbl)
            {
            }
            column(MUS_J1_5Caption; MUS_J1_5CaptionLbl)
            {
            }
            column(Financial_RequirementCaption; Financial_RequirementCaptionLbl)
            {
            }
            column(MUS_J1_6Caption; MUS_J1_6CaptionLbl)
            {
            }
            column(DeclarationCaption; DeclarationCaptionLbl)
            {
            }
            column(MUS_J1_7Caption; MUS_J1_7CaptionLbl)
            {
            }
            column(B_Caption; B_CaptionLbl)
            {
            }
            column(Please__note_that_the_following_forms_should_be_filled_and_returned_to_the_University_latest_byCaption; Please__note_that_the_following_forms_should_be_filled_and_returned_to_the_University_latest_byCaptionLbl)
            {
            }
            column(Student_Personal_Details_FormCaption_Control1102760036; Student_Personal_Details_FormCaption_Control1102760036Lbl)
            {
            }
            column(Acceptance_of_offer___Non_Acceptance_of_offerCaption_Control1102760037; Acceptance_of_offer___Non_Acceptance_of_offerCaption_Control1102760037Lbl)
            {
            }
            column(Student_Medical_ExaminationCaption_Control1102760038; Student_Medical_ExaminationCaption_Control1102760038Lbl)
            {
            }
            column(MUS_JI_1Caption; MUS_JI_1CaptionLbl)
            {
            }
            column(MUS_JI_2_A___BCaption; MUS_JI_2_A___BCaptionLbl)
            {
            }
            column(MUS_J1_3Caption_Control1102760041; MUS_J1_3Caption_Control1102760041Lbl)
            {
            }
            column(Emergency_OperationCaption_Control1102760042; Emergency_OperationCaption_Control1102760042Lbl)
            {
            }
            column(MUS_J1_4Caption_Control1102760043; MUS_J1_4Caption_Control1102760043Lbl)
            {
            }
            column(DeclarationCaption_Control1102760044; DeclarationCaption_Control1102760044Lbl)
            {
            }
            column(MUS_J1_7Caption_Control1102760045; MUS_J1_7Caption_Control1102760045Lbl)
            {
            }
            column(To_be_completed_by_a_Medical_Practitioner_Caption; To_be_completed_by_a_Medical_Practitioner_CaptionLbl)
            {
            }
            column(C_Caption; C_CaptionLbl)
            {
            }
            column(Documents_to_come_with_on_report_day_Caption; Documents_to_come_with_on_report_day_CaptionLbl)
            {
            }
            column(The_Original_K_C_S_E_Certificate_Result_Slip_or_other_CertificatesCaption; The_Original_K_C_S_E_Certificate_Result_Slip_or_other_CertificatesCaptionLbl)
            {
            }
            column(A_photocopy_of_K_C_S_E_Certificate_Result_Slip_or_other_CertificatesCaption; A_photocopy_of_K_C_S_E_Certificate_Result_Slip_or_other_CertificatesCaptionLbl)
            {
            }
            column(Original_Admission_LetterCaption; Original_Admission_LetterCaptionLbl)
            {
            }
            column(A_photocopy_of_your_National_Identity_CardCaption; A_photocopy_of_your_National_Identity_CardCaptionLbl)
            {
            }
            column(MUS_JI_1Caption_Control1102760055; MUS_JI_1Caption_Control1102760055Lbl)
            {
            }
            column(MUS_JI_2_A___BCaption_Control1102760056; MUS_JI_2_A___BCaption_Control1102760056Lbl)
            {
            }
            column(MUS_J1_3Caption_Control1102760057; MUS_J1_3Caption_Control1102760057Lbl)
            {
            }
            column(MUS_J1_4Caption_Control1102760058; MUS_J1_4Caption_Control1102760058Lbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
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
            column(EmptyStringCaption_Control1102760071; EmptyStringCaption_Control1102760071Lbl)
            {
            }
            column(EmptyStringCaption_Control1102760072; EmptyStringCaption_Control1102760072Lbl)
            {
            }
            column(i_Caption; i_CaptionLbl)
            {
            }
            column(ii_Caption; ii_CaptionLbl)
            {
            }
            column(iii_Caption; iii_CaptionLbl)
            {
            }
            column(iv_Caption; iv_CaptionLbl)
            {
            }
            column(Admission_Parcel_Main_Line_No; "Line No")
            {
            }
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

    trigger OnPreReport()
    begin
        AdmParc.RESET;
        IF AdmParc.FIND('+') THEN BEGIN
            LineNo := AdmParc."Line No";
        END
        ELSE BEGIN
            LineNo := 0;
        END;
        AdmParc.INIT;
        AdmParc."Line No" := LineNo + 1;
        AdmParc.Date := TODAY;
        AdmParc.Time := TIME;
        AdmParc."User ID" := USERID;
        AdmParc.INSERT();
    end;

    var
        AdmParc: Record 61370;
        LineNo: Integer;
        DeadLineDate: Date;
        OFFICE_OF_THE_DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl: Label 'OFFICE OF THE DEPUTY REGISTRAR, ACADEMIC AFFAIRS';
        ADMISSION_PARCELCaptionLbl: Label 'ADMISSION PARCEL';
        A_CaptionLbl: Label '(A)';
        The_following_documents_have_been_enclosed_for_your_attentionCaptionLbl: Label 'The following documents have been enclosed for your attention';
        Student_Personal_Details_FormCaptionLbl: Label 'Student Personal Details Form';
        MUS_J1_1CaptionLbl: Label '-MUS/J1/1';
        Acceptance_of_offer___Non_Acceptance_of_offerCaptionLbl: Label 'Acceptance of offer / Non-Acceptance of offer';
        MUS_J1_2_A___BCaptionLbl: Label '-MUS/J1/2/A & B';
        Student_Medical_ExaminationCaptionLbl: Label 'Student Medical Examination';
        MUS_J1_3CaptionLbl: Label '-MUS/J1/3';
        Emergency_OperationCaptionLbl: Label 'Emergency Operation';
        MUS_J1_4CaptionLbl: Label '-MUS/J1/4';
        General_Information_to_StudentsCaptionLbl: Label 'General Information to Students';
        MUS_J1_5CaptionLbl: Label '-MUS/J1/5';
        Financial_RequirementCaptionLbl: Label 'Financial Requirement';
        MUS_J1_6CaptionLbl: Label '-MUS/J1/6';
        DeclarationCaptionLbl: Label 'Declaration';
        MUS_J1_7CaptionLbl: Label '-MUS/J1/7';
        B_CaptionLbl: Label '(B)';
        Please__note_that_the_following_forms_should_be_filled_and_returned_to_the_University_latest_byCaptionLbl: Label 'Please, note that the following forms should be filled and returned to the University latest by';
        Student_Personal_Details_FormCaption_Control1102760036Lbl: Label 'Student Personal Details Form';
        Acceptance_of_offer___Non_Acceptance_of_offerCaption_Control1102760037Lbl: Label 'Acceptance of offer / Non-Acceptance of offer';
        Student_Medical_ExaminationCaption_Control1102760038Lbl: Label 'Student Medical Examination';
        MUS_JI_1CaptionLbl: Label '-MUS/JI/1';
        MUS_JI_2_A___BCaptionLbl: Label '-MUS/JI/2/A & B';
        MUS_J1_3Caption_Control1102760041Lbl: Label '-MUS/J1/3';
        Emergency_OperationCaption_Control1102760042Lbl: Label 'Emergency Operation';
        MUS_J1_4Caption_Control1102760043Lbl: Label '-MUS/J1/4';
        DeclarationCaption_Control1102760044Lbl: Label 'Declaration';
        MUS_J1_7Caption_Control1102760045Lbl: Label '-MUS/J1/7';
        To_be_completed_by_a_Medical_Practitioner_CaptionLbl: Label '(To be completed by a Medical Practitioner)';
        C_CaptionLbl: Label '(C)';
        Documents_to_come_with_on_report_day_CaptionLbl: Label 'Documents to come with on report day.';
        The_Original_K_C_S_E_Certificate_Result_Slip_or_other_CertificatesCaptionLbl: Label 'The Original K.C.S.E Certificate/Result Slip or other Certificates';
        A_photocopy_of_K_C_S_E_Certificate_Result_Slip_or_other_CertificatesCaptionLbl: Label 'A photocopy of K.C.S.E Certificate/Result Slip or other Certificates';
        Original_Admission_LetterCaptionLbl: Label 'Original Admission Letter';
        A_photocopy_of_your_National_Identity_CardCaptionLbl: Label 'A photocopy of your National Identity Card';
        MUS_JI_1Caption_Control1102760055Lbl: Label '-MUS/JI/1';
        MUS_JI_2_A___BCaption_Control1102760056Lbl: Label '-MUS/JI/2/A & B';
        MUS_J1_3Caption_Control1102760057Lbl: Label '-MUS/J1/3';
        MUS_J1_4Caption_Control1102760058Lbl: Label '-MUS/J1/4';
        EmptyStringCaptionLbl: Label '=';
        EmptyStringCaption_Control1102760062Lbl: Label '=';
        EmptyStringCaption_Control1102760063Lbl: Label '=';
        EmptyStringCaption_Control1102760064Lbl: Label '=';
        EmptyStringCaption_Control1102760065Lbl: Label '=';
        EmptyStringCaption_Control1102760066Lbl: Label '=';
        EmptyStringCaption_Control1102760067Lbl: Label '=';
        EmptyStringCaption_Control1102760068Lbl: Label '=';
        EmptyStringCaption_Control1102760069Lbl: Label '=';
        EmptyStringCaption_Control1102760070Lbl: Label '=';
        EmptyStringCaption_Control1102760071Lbl: Label '=';
        EmptyStringCaption_Control1102760072Lbl: Label '=';
        i_CaptionLbl: Label '(i)';
        ii_CaptionLbl: Label '(ii)';
        iii_CaptionLbl: Label '(iii)';
        iv_CaptionLbl: Label '(iv)';
}

