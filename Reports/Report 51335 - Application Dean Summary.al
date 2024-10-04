report 51335 "Application Dean Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Application Dean Summary.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
        {
            DataItemTableView = SORTING("First Degree Choice")
                                ORDER(Ascending);
            RequestFilterFields = "First Degree Choice", "Intake Code";
            column(ApplicationNo_ApplicationFormHeader; "ACA-Applic. Form Header"."Application No.")
            {
            }
            column(Date_ApplicationFormHeader; "ACA-Applic. Form Header".Date)
            {
            }
            column(ApplicationDate_ApplicationFormHeader; "ACA-Applic. Form Header"."Application Date")
            {
            }
            column(Surname_ApplicationFormHeader; "ACA-Applic. Form Header".Surname)
            {
            }
            column(OtherNames_ApplicationFormHeader; "ACA-Applic. Form Header"."Other Names")
            {
            }
            column(DateOfBirth_ApplicationFormHeader; "ACA-Applic. Form Header"."Date Of Birth")
            {
            }
            column(Gender_ApplicationFormHeader; "ACA-Applic. Form Header".Gender)
            {
            }
            column(MaritalStatus_ApplicationFormHeader; "ACA-Applic. Form Header"."Marital Status")
            {
            }
            column(Nationality_ApplicationFormHeader; "ACA-Applic. Form Header".Nationality)
            {
            }
            column(CountryofOrigin_ApplicationFormHeader; "ACA-Applic. Form Header"."Country of Origin")
            {
            }
            column(AddressforCorrespondence1_ApplicationFormHeader; "ACA-Applic. Form Header"."Address for Correspondence1")
            {
            }
            column(AddressforCorrespondence2_ApplicationFormHeader; "ACA-Applic. Form Header"."Address for Correspondence2")
            {
            }
            column(AddressforCorrespondence3_ApplicationFormHeader; "ACA-Applic. Form Header"."Address for Correspondence3")
            {
            }
            column(TelephoneNo1_ApplicationFormHeader; "ACA-Applic. Form Header"."Telephone No. 1")
            {
            }
            column(TelephoneNo2_ApplicationFormHeader; "ACA-Applic. Form Header"."Telephone No. 2")
            {
            }
            column(FirstDegreeChoice_ApplicationFormHeader; "ACA-Applic. Form Header"."First Degree Choice")
            {
            }
            column(Faculty1_ApplicationFormHeader; "ACA-Applic. Form Header".School1)
            {
            }
            column(SecondDegreeChoice_ApplicationFormHeader; "ACA-Applic. Form Header"."Second Degree Choice")
            {
            }
            column(Faculty2_ApplicationFormHeader; "ACA-Applic. Form Header"."School 2")
            {
            }
            column(DateofReceipt_ApplicationFormHeader; "ACA-Applic. Form Header"."Date of Receipt")
            {
            }
            column(UserID_ApplicationFormHeader; "ACA-Applic. Form Header"."User ID")
            {
            }
            column(County_ApplicationFormHeader; "ACA-Applic. Form Header".County)
            {
            }
            column(FormerSchoolCode_ApplicationFormHeader; "ACA-Applic. Form Header"."Former School Code")
            {
            }
            column(DateofAdmission_ApplicationFormHeader; "ACA-Applic. Form Header"."Date of Admission")
            {
            }
            column(DateofCompletion_ApplicationFormHeader; "ACA-Applic. Form Header"."Date of Completion")
            {
            }
            column(YearofExamination_ApplicationFormHeader; "ACA-Applic. Form Header"."Year of Examination")
            {
            }
            column(ExaminationBody_ApplicationFormHeader; "ACA-Applic. Form Header"."Examination Body")
            {
            }
            column(MeanGradeAcquired_ApplicationFormHeader; "ACA-Applic. Form Header"."Mean Grade Acquired")
            {
            }
            column(PointsAcquired_ApplicationFormHeader; "ACA-Applic. Form Header"."Points Acquired")
            {
            }
            column(PrincipalPasses_ApplicationFormHeader; "ACA-Applic. Form Header"."Principal Passes")
            {
            }
            column(SubsidiaryPasses_ApplicationFormHeader; "ACA-Applic. Form Header"."Subsidiary Passes")
            {
            }
            column(Examination_ApplicationFormHeader; "ACA-Applic. Form Header".Examination)
            {
            }
            column(ApplicationFormReceiptNo_ApplicationFormHeader; "ACA-Applic. Form Header"."Application Form Receipt No.")
            {
            }
            column(IndexNumber_ApplicationFormHeader; "ACA-Applic. Form Header"."Index Number")
            {
            }
            column(NoSeries_ApplicationFormHeader; "ACA-Applic. Form Header"."No. Series")
            {
            }
            column(HODUserID_ApplicationFormHeader; "ACA-Applic. Form Header"."HOD User ID")
            {
            }
            column(HODDate_ApplicationFormHeader; "ACA-Applic. Form Header"."HOD Date")
            {
            }
            column(HODTime_ApplicationFormHeader; "ACA-Applic. Form Header"."HOD Time")
            {
            }
            column(HODRecommendations_ApplicationFormHeader; "ACA-Applic. Form Header"."HOD Recommendations")
            {
            }
            column(DeanUserID_ApplicationFormHeader; "ACA-Applic. Form Header"."Dean User ID")
            {
            }
            column(DeanDate_ApplicationFormHeader; "ACA-Applic. Form Header"."Dean Date")
            {
            }
            column(DeanTime_ApplicationFormHeader; "ACA-Applic. Form Header"."Dean Time")
            {
            }
            column(DeanRecommendations_ApplicationFormHeader; "ACA-Applic. Form Header"."Dean Recommendations")
            {
            }
            column(Status_ApplicationFormHeader; "ACA-Applic. Form Header".Status)
            {
            }
            column(Select_ApplicationFormHeader; "ACA-Applic. Form Header".Select)
            {
            }
            column(BatchNo_ApplicationFormHeader; "ACA-Applic. Form Header"."Batch No.")
            {
            }
            column(BatchDate_ApplicationFormHeader; "ACA-Applic. Form Header"."Batch Date")
            {
            }
            column(BatchTime_ApplicationFormHeader; "ACA-Applic. Form Header"."Batch Time")
            {
            }
            column(AdmissionBoardRecommendation_ApplicationFormHeader; "ACA-Applic. Form Header"."Admission Board Recommendation")
            {
            }
            column(AdmissionBoardDate_ApplicationFormHeader; "ACA-Applic. Form Header"."Admission Board Date")
            {
            }
            column(AdmissionBoardTime_ApplicationFormHeader; "ACA-Applic. Form Header"."Admission Board Time")
            {
            }
            column(AdmittedDegree_ApplicationFormHeader; "ACA-Applic. Form Header"."Admitted Degree")
            {
            }
            column(AdmittedDepartment_ApplicationFormHeader; "ACA-Applic. Form Header"."Admitted Department")
            {
            }
            column(DeferredUntil_ApplicationFormHeader; "ACA-Applic. Form Header"."Deferred Until")
            {
            }
            column(DateOfMeeting_ApplicationFormHeader; "ACA-Applic. Form Header"."Date Of Meeting")
            {
            }
            column(DateOfReceiptSlip_ApplicationFormHeader; "ACA-Applic. Form Header"."Date Of Receipt Slip")
            {
            }
            column(ReceiptSlipNo_ApplicationFormHeader; "ACA-Applic. Form Header"."Receipt Slip No.")
            {
            }
            column(AcademicYear_ApplicationFormHeader; "ACA-Applic. Form Header"."Academic Year")
            {
            }
            column(AdmissionNo_ApplicationFormHeader; "ACA-Applic. Form Header"."Admission No")
            {
            }
            column(AdmittedToStage_ApplicationFormHeader; "ACA-Applic. Form Header"."Admitted To Stage")
            {
            }
            column(AdmittedSemester_ApplicationFormHeader; "ACA-Applic. Form Header"."Admitted Semester")
            {
            }
            column(FirstChoiceStage_ApplicationFormHeader; "ACA-Applic. Form Header"."First Choice Stage")
            {
            }
            column(FirstChoiceSemester_ApplicationFormHeader; "ACA-Applic. Form Header"."First Choice Semester")
            {
            }
            column(SecondChoiceStage_ApplicationFormHeader; "ACA-Applic. Form Header"."Second Choice Stage")
            {
            }
            column(SecondChoiceSemester_ApplicationFormHeader; "ACA-Applic. Form Header"."Second Choice Semester")
            {
            }
            column(IntakeCode_ApplicationFormHeader; "ACA-Applic. Form Header"."Intake Code")
            {
            }
            column(SettlementType_ApplicationFormHeader; "ACA-Applic. Form Header"."Settlement Type")
            {
            }
            column(IDNumber_ApplicationFormHeader; "ACA-Applic. Form Header"."ID Number")
            {
            }
            column(DateSentforApproval_ApplicationFormHeader; "ACA-Applic. Form Header"."Date Sent for Approval")
            {
            }
            column(IssuedDate_ApplicationFormHeader; "ACA-Applic. Form Header"."Issued Date")
            {
            }
            column(PostGraduate_ApplicationFormHeader; "ACA-Applic. Form Header"."Post Graduate")
            {
            }
            column(Email_ApplicationFormHeader; "ACA-Applic. Form Header".Email)
            {
            }
            column(Campus_ApplicationFormHeader; "ACA-Applic. Form Header".Campus)
            {
            }
            column(AdmissableStatus_ApplicationFormHeader; "ACA-Applic. Form Header"."Admissable Status")
            {
            }
            column(ModeofStudy_ApplicationFormHeader; "ACA-Applic. Form Header"."Mode of Study")
            {
            }
            column(EnquiryNo_ApplicationFormHeader; "ACA-Applic. Form Header"."Enquiry No")
            {
            }
            column(ResponsibilityCenter_ApplicationFormHeader; "ACA-Applic. Form Header"."Responsibility Center")
            {
            }
            column(AdmitNotAdmit; "ACA-Applic. Form Header"."Admit/NotAdmit")
            {
            }
            column(FullNames; FullNames)
            {
            }
            column(FContacts; FContacts)
            {
            }
            column(Seducation; Seducation)
            {
            }
            column(SN; SN)
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(Wexp; Wexp)
            {
            }
            column(OtherQ; OtherQ)
            {
            }
            column(R1; Reqstr[1])
            {
            }
            column(R2; Reqstr[2])
            {
            }
            column(R3; Reqstr[3])
            {
            }
            column(R4; Reqstr[4])
            {
            }
            column(R5; Reqstr[5])
            {
            }

            trigger OnAfterGetRecord()
            begin
                SN := SN + 1;


                FullNames := "ACA-Applic. Form Header".Surname + ' ' + "ACA-Applic. Form Header"."Other Names";
                FContacts := "ACA-Applic. Form Header"."Address for Correspondence1" + ' ' + "ACA-Applic. Form Header"."Address for Correspondence2" + ' ' + "ACA-Applic. Form Header"."Telephone No. 1";
                OtherQ := '';
                Seducation := FORMAT("ACA-Applic. Form Header".Examination) + ' ' + "ACA-Applic. Form Header"."Mean Grade Acquired";

                IF Prog.GET("ACA-Applic. Form Header"."First Degree Choice") THEN
                    ProgName := Prog.Description;

                OtherQRec.RESET;
                OtherQRec.SETRANGE(OtherQRec."Application No.", "ACA-Applic. Form Header"."Application No.");
                IF OtherQRec.FIND('-') THEN BEGIN
                    REPEAT
                        OtherQ := OtherQRec."Where Obtained" + ' ' + OtherQRec.Qualification + OtherQRec.Award + ',' + OtherQ;
                    UNTIL OtherQRec.NEXT = 0;
                END;

                Wexp := '';
                WexpRec.RESET;
                WexpRec.SETRANGE(WexpRec."Application No.", "ACA-Applic. Form Header"."Application No.");
                IF WexpRec.FIND('-') THEN BEGIN
                    REPEAT
                        Wexp := WexpRec.Organisation + ' ' + WexpRec."Job Title" + ' ' + FORMAT(WexpRec.From) + '-' + FORMAT(WexpRec."To date") + Wexp + ',';
                    UNTIL WexpRec.NEXT = 0;
                END;

                AdmReq.RESET;
                AdmReq.SETRANGE(AdmReq."Programme Code", "ACA-Applic. Form Header"."First Degree Choice");
                IF AdmReq.FIND('-') THEN BEGIN
                    REPEAT
                        IF i < 11 THEN BEGIN
                            i := i + 1;
                            Reqstr[i] := AdmReq."Admission Req. Narration";
                        END;
                    UNTIL AdmReq.NEXT = 0;
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
        FullNames: Text[100];
        FContacts: Text[200];
        Seducation: Code[200];
        OtherQ: Text[250];
        Wexp: Text[250];
        OtherQRec: Record 61361;
        WexpRec: Record 61360;
        Reqstr: array[50] of Text[200];
        AdmReq: Record 61608;
        i: Integer;
        ProgName: Code[200];
        Prog: Record 61511;
        SN: Integer;
}

