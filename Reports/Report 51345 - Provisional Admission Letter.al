// report 51345 "Provisional Admission Letter"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Reports/SSR/Provisional Admission Letter.rdl';

//     dataset
//     {
//         dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
//         {
//             DataItemTableView = SORTING("Application No.");
//             RequestFilterFields = "Application No.";
//             column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
//             {
//             }
//             column(Application_Form_Header__Application_No__; "Application No.")
//             {
//             }
//             column(FORMAT__Application_Date__0_4_; FORMAT("Application Date", 0, 4))
//             {
//             }
//             column(UPPERCASE_Surname_; UPPERCASE(Surname))
//             {
//             }
//             column(UPPERCASE__Address_for_Correspondence1__; UPPERCASE("Address for Correspondence1"))
//             {
//             }
//             column(UPPERCASE__Address_for_Correspondence2__; UPPERCASE("Address for Correspondence2"))
//             {
//             }
//             column(UPPERCASE__Address_for_Correspondence3__; UPPERCASE("Address for Correspondence3"))
//             {
//             }
//             column(UPPERCASE_Surname__________Other_Names__; UPPERCASE(Surname + ' ' + "Other Names"))
//             {
//             }
//             column(Company_Address; Company.Address)
//             {
//             }
//             column(Tel_________Company__Phone_No___________Company__Phone_No__2_; 'Tel:' + ' ' + Company."Phone No." + ',' + Company."Phone No. 2")
//             {
//             }
//             column(Fax______Company__Fax_No__; 'Fax: ' + Company."Fax No.")
//             {
//             }
//             column(Your_application_for_admission_into_a_degree_programme_at_MASENO_UNIVERSITY_during_; 'Your application for admission into a degree programme at MASENO UNIVERSITY during')
//             {
//             }
//             column(AcademicYear; AcademicYear)
//             {
//             }
//             column(academic_year_has_been_; ' academic year has been')
//             {
//             }
//             column(DataItem1102760015; 'considered. You have, subsequently, been offered provisional admission into ' + FacultyName + ' for a course leading to the degree')
//             {
//             }
//             column(This_interim_admission_is_subject_to_full_payment_of_; 'This interim admission is subject to full payment of')
//             {
//             }
//             column(AmountToPay; AmountToPay)
//             {
//             }
//             column(on_or_before_; ' on or before')
//             {
//             }
//             column(FORMAT_DeadLineDate_0_4_; FORMAT(DeadLineDate, 0, 4))
//             {
//             }
//             column(Registration_will_end_as_; 'Registration will end as')
//             {
//             }
//             column(soon_as_the_capacity_in_this_programme_is_filled_up_; 'soon as the capacity in this programme is filled up')
//             {
//             }
//             column(The_capacity_for_this_degree_is_limited_and_registration_will_be_on_the_first_come_first_served_basis__; 'The capacity for this degree is limited and registration will be on the first come first served basis.')
//             {
//             }
//             column(DataItem1102760032; 'Detailed fee structure is attached for your reference. Comprehensive joining instructions will be sent only to those who will have')
//             {
//             }
//             column(met_the__; 'met the ')
//             {
//             }
//             column(AmountToPay_Control1102760034; AmountToPay)
//             {
//             }
//             column(requirement_by__; ' requirement by ')
//             {
//             }
//             column(FORMAT_DeadLineDate_0_4__Control1102760036; FORMAT(DeadLineDate, 0, 4))
//             {
//             }
//             column(Make_your_payments_to_; 'Make your payments to')
//             {
//             }
//             column(Account_number_____________________; 'Account number: ******************')
//             {
//             }
//             column(of_Equity_Bank__TMUC_or_at_any_branch_of_Equity_; ' of Equity Bank, KILIMAMBOGO or at any branch of Equity')
//             {
//             }
//             column(Bank_countrywide__You_will_be_required_to_submit_banking_slip_s__indicating_the_amount_of_money_paid__Ensure_you_get_; 'Bank countrywide. You will be required to submit banking slip(s) indicating the amount of money paid. Ensure you get')
//             {
//             }
//             column(DataItem1102760041; 'official University receipt for the amount paid from Finance Department. Cash, personal or institutional cheques are not acceptable')
//             {
//             }
//             column(Thank_you__; 'Thank you.')
//             {
//             }
//             column(ProgName; ProgName)
//             {
//             }
//             column(OFFICE_OF_THE_DEPUTY_REGISTRAR___ACADEMIC_AFFAIRSCaption; OFFICE_OF_THE_DEPUTY_REGISTRAR___ACADEMIC_AFFAIRSCaptionLbl)
//             {
//             }
//             column(Our_Ref_Caption; Our_Ref_CaptionLbl)
//             {
//             }
//             column(Your_Ref_Caption; Your_Ref_CaptionLbl)
//             {
//             }
//             column(Dear_Ms__Mr_Caption; Dear_Ms__Mr_CaptionLbl)
//             {
//             }
//             column(RE_Caption; RE_CaptionLbl)
//             {
//             }
//             column(PROVISIONAL_ADMISSION_INTO_A_DEGREE_PROGRAMMECaption; PROVISIONAL_ADMISSION_INTO_A_DEGREE_PROGRAMMECaptionLbl)
//             {
//             }
//             column(Date_Caption; Date_CaptionLbl)
//             {
//             }
//             column(FOR__DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaption; FOR__DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 AcademicYear := "ACA-Applic. Form Header"."Academic Year";
//                 AmountToPay := '';
//                 //DeadLineDate:=TODAY;
//                 Amount := 0;

//                 /*Get the deadline for the payment as the first day of the semester*/
//                 Semester.RESET;
//                 Semester.SETRANGE(Semester.Code, "ACA-Applic. Form Header"."Admitted Semester");
//                 IF Semester.FIND('-') THEN BEGIN
//                     DeadLineDate := Semester.From;
//                 END;
//                 /*Get the amount to be paid by the student*/
//                 NewStudCharges.RESET;
//                 NewStudCharges.SETRANGE(NewStudCharges."Programme Code", "ACA-Applic. Form Header"."Admitted Degree");
//                 IF NewStudCharges.FIND('-') THEN BEGIN
//                     REPEAT
//                         Amount := Amount + NewStudCharges.Amount;
//                     UNTIL NewStudCharges.NEXT = 0;
//                 END;

//                 //PKK
//                 StageCharges.RESET;
//                 StageCharges.SETRANGE(StageCharges."Programme Code", "ACA-Applic. Form Header"."Admitted Degree");
//                 StageCharges.SETRANGE(StageCharges."Stage Code", "ACA-Applic. Form Header"."Admitted To Stage");
//                 IF StageCharges.FIND('-') THEN BEGIN
//                     REPEAT
//                         Amount := Amount + StageCharges.Amount;
//                     UNTIL StageCharges.NEXT = 0;
//                 END;
//                 //PKK

//                 FeeByStage.RESET;
//                 FeeByStage.SETRANGE(FeeByStage."Programme Code", "ACA-Applic. Form Header"."Admitted Degree");
//                 FeeByStage.SETRANGE(FeeByStage."Stage Code", "ACA-Applic. Form Header"."Admitted To Stage");
//                 FeeByStage.SETRANGE(FeeByStage.Semester, "ACA-Applic. Form Header"."Admitted Semester");
//                 FeeByStage.SETRANGE(FeeByStage."Settlemet Type", "ACA-Applic. Form Header"."Settlement Type");
//                 IF FeeByStage.FIND('-') THEN BEGIN Amount := Amount + FeeByStage."Break Down"; END;
//                 AmountToPay := 'Kshs. ' + FORMAT(Amount) + '/=';

//                 DimVal.RESET;
//                 DimVal.SETRANGE(DimVal."Dimension Code", 'COURSE');
//                 DimVal.SETRANGE(DimVal.Code, "ACA-Applic. Form Header".School1);
//                 IF DimVal.FIND('-') THEN BEGIN
//                     FacultyName := DimVal.Name;
//                 END;
//                 Prog.RESET;
//                 IF Prog.GET("ACA-Applic. Form Header"."First Degree Choice") THEN BEGIN
//                     ProgName := Prog.Description;
//                 END;

//             end;

//             trigger OnPreDataItem()
//             begin
//                 /*
//                 GeneralSetUp.RESET;
//                 IF GeneralSetUp.FIND('-') THEN
//                 DeadLineDate:=GeneralSetUp."Applications Date Line";
//                 */

//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         Company: Record 79;
//         AcademicYear: Text[30];
//         AmountToPay: Text[30];
//         DeadLineDate: Date;
//         NewStudCharges: Record 61543;
//         Amount: Decimal;
//         Semester: Record 61692;
//         FeeByStage: Record 61523;
//         FacultyName: Text[100];
//         DimVal: Record 349;
//         Prog: Record 61511;
//         ProgName: Text[100];
//         StageCharges: Record 61533;
//         GeneralSetUp: Record 61534;
//         OFFICE_OF_THE_DEPUTY_REGISTRAR___ACADEMIC_AFFAIRSCaptionLbl: Label 'OFFICE OF THE DEPUTY REGISTRAR - ACADEMIC AFFAIRS';
//         Our_Ref_CaptionLbl: Label 'Our Ref:';
//         Your_Ref_CaptionLbl: Label 'Your Ref:';
//         Dear_Ms__Mr_CaptionLbl: Label 'Dear Ms./Mr.';
//         RE_CaptionLbl: Label 'RE:';
//         PROVISIONAL_ADMISSION_INTO_A_DEGREE_PROGRAMMECaptionLbl: Label 'PROVISIONAL ADMISSION INTO A DEGREE PROGRAMME';
//         Date_CaptionLbl: Label 'Date:';
//         FOR__DEPUTY_REGISTRAR__ACADEMIC_AFFAIRSCaptionLbl: Label 'FOR: DEPUTY REGISTRAR, ACADEMIC AFFAIRS';
// }

