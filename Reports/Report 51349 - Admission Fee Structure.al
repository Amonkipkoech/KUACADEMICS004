report 51349 "Admission Fee Structure"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Admission Fee Structure.rdl';

    dataset
    {
        dataitem("ACA-Adm. Form Header"; "ACA-Adm. Form Header")
        {
            DataItemTableView = SORTING("Admission No.");
            RequestFilterFields = "Admission No.";
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(CompanyInfo__Phone_No_____________CompanyInfo__Phone_No__2_; CompanyInfo."Phone No." + ' , ' + CompanyInfo."Phone No. 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo__Address_2__; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(TAmount___TFee; TAmount + TFee)
            {
            }
            column(TFee; TFee)
            {
            }
            column(IntC__1; IntC + 1)
            {
            }
            column(OFFICE_OF_THE__REGISTRAR___ACADEMIC_AFFAIRSCaption; OFFICE_OF_THE__REGISTRAR___ACADEMIC_AFFAIRSCaptionLbl)
            {
            }
            column(Tel_Caption; Tel_CaptionLbl)
            {
            }
            column(Fax_Caption; Fax_CaptionLbl)
            {
            }
            column(Our_Ref_Caption; Our_Ref_CaptionLbl)
            {
            }
            column(Your_Ref_Caption; Your_Ref_CaptionLbl)
            {
            }
            column(FINANCIAL_REQUIREMENTSCaption; FINANCIAL_REQUIREMENTSCaptionLbl)
            {
            }
            column(FEE_STRUCTURECaption; FEE_STRUCTURECaptionLbl)
            {
            }
            column(In_order_to_be_registered__a_student_is_expected_to_pay_the_following_fees_Caption; In_order_to_be_registered__a_student_is_expected_to_pay_the_following_fees_CaptionLbl)
            {
            }
            column(COMPULSORYCaption; COMPULSORYCaptionLbl)
            {
            }
            column(AMOUNT_KSHS_Caption; AMOUNT_KSHS_CaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(N_B_Caption; N_B_CaptionLbl)
            {
            }
            /*  column(Note;The_above_indicated_financial_requirements_do_not_include_accomodation__food__books_and_stationery__and_personal_effects_a_stLbl)
             {
             } */
            column(ACCOMMODATIONCaption; ACCOMMODATIONCaptionLbl)
            {
            }
            column(B_Caption; B_CaptionLbl)
            {
            }
            /* column(Note2;The_University_is_not_obliged_to_offer_accommodation_services_to_students__However__there_are_limited_number__of_rooms_availaLbl)
            {
            } */
            column(Tuition_FeesCaption; Tuition_FeesCaptionLbl)
            {
            }
            column(Admission_Form_Header_Admission_No_; "Admission No.")
            {
            }
            column(Admission_Form_Header_Degree_Admitted_To; "Degree Admitted To")
            {
            }
            dataitem("ACA-New Student Charges"; "ACA-New Student Charges")
            {
                DataItemLink = "Programme Code" = FIELD("Degree Admitted To");
                column(New_Student_Charges_Amount; Amount)
                {
                }
                column(New_Student_Charges_Description; Description)
                {
                }
                column(IntC; IntC)
                {
                }
                column(New_Student_Charges_Programme_Code; "Programme Code")
                {
                }
                column(New_Student_Charges_Code; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TAmount := TAmount + "ACA-New Student Charges".Amount;
                    IntC := IntC + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TAmount := 0;
                IntC := 0;
                TFee := 0;
                FeeByStage.RESET;
                FeeByStage.SETRANGE(FeeByStage."Programme Code", "ACA-Adm. Form Header"."Degree Admitted To");
                FeeByStage.SETRANGE(FeeByStage."Stage Code", "ACA-Adm. Form Header"."Stage Admitted To");
                FeeByStage.SETRANGE(FeeByStage.Semester, "ACA-Adm. Form Header"."Semester Admitted To");
                FeeByStage.SETRANGE(FeeByStage."Settlemet Type", "ACA-Adm. Form Header"."Settlement Type");
                IF FeeByStage.FIND('-') THEN BEGIN TFee := FeeByStage."Break Down"; END;
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

    trigger OnPreReport()
    begin
        CompanyInfo.RESET();
        CompanyInfo.GET();
    end;

    var
        CompanyInfo: Record 79;
        TAmount: Decimal;
        IntC: Integer;
        TFee: Decimal;
        FeeByStage: Record 61523;
        OFFICE_OF_THE__REGISTRAR___ACADEMIC_AFFAIRSCaptionLbl: Label 'OFFICE OF THE  REGISTRAR - ACADEMIC AFFAIRS';
        Tel_CaptionLbl: Label 'Tel:';
        Fax_CaptionLbl: Label 'Fax:';
        Our_Ref_CaptionLbl: Label 'Our Ref:';
        Your_Ref_CaptionLbl: Label 'Your Ref:';
        FINANCIAL_REQUIREMENTSCaptionLbl: Label 'FINANCIAL REQUIREMENTS';
        FEE_STRUCTURECaptionLbl: Label 'FEE STRUCTURE';
        In_order_to_be_registered__a_student_is_expected_to_pay_the_following_fees_CaptionLbl: Label 'In order to be registered, a student is expected to pay the following fees.';
        COMPULSORYCaptionLbl: Label 'COMPULSORY';
        AMOUNT_KSHS_CaptionLbl: Label 'AMOUNT KSHS.';
        TOTALCaptionLbl: Label 'TOTAL';
        N_B_CaptionLbl: Label 'N.B.';
        //The_above_indicated_financial_requirements_do_not_include_accomodation__food__books_and_stationery__and_personal_effects_a_stLbl: Label 'The above indicated financial requirements do not include accomodation, food, books and stationery, and personal effects a student may require.';
        ACCOMMODATIONCaptionLbl: Label 'ACCOMMODATION';
        B_CaptionLbl: Label 'B.';
        //The_University_is_not_obliged_to_offer_accommodation_services_to_students__However__there_are_limited_number__of_rooms_availaLbl: Label 'The University is not obliged to offer accommodation services to students. However, there are limited number  of rooms available for rental, which will be allocated on a competitive basis. The available rooms arecurrently rented out to stuents at Kshs. 3,000/= per semester.';
        Tuition_FeesCaptionLbl: Label 'Tuition Fees';
}

