xmlport 84519 "Import Senate Lubrics"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(Lubs; "ACA-Results Status")
            {

                fieldelement(Code; Lubs."Code")
                {
                }
                fieldelement(Description; Lubs.Description)
                {
                }
                fieldelement(StatusMsg1; Lubs."Status Msg1")
                {
                }
                fieldelement(StatusMsg2; Lubs."Status Msg2")
                {
                }
                fieldelement(StatusMsg3; Lubs."Status Msg3")
                {
                }
                fieldelement(StatusMsg4; Lubs."Status Msg4")
                {
                }
                fieldelement(StatusMsg5; Lubs."Status Msg5")
                {
                }
                fieldelement(StatusMsg6; Lubs."Status Msg6")
                {
                }
                fieldelement(OrderNo; Lubs."Order No")
                {
                }
                fieldelement(ShowRegRemarks; Lubs."Show Reg. Remarks")
                {
                }
                fieldelement(ManualStatusProcessing; Lubs."Manual Status Processing")
                {
                }
                fieldelement(Prefix; Lubs.Prefix)
                {
                }
                fieldelement(IncludeVariable1; Lubs."IncludeVariable 1")
                {
                }
                fieldelement(IncludeVariable2; Lubs."IncludeVariable 2")
                {
                }
                fieldelement(IncludeVariable3; Lubs."IncludeVariable 3")
                {
                }
                fieldelement(IncludeVariable4; Lubs."IncludeVariable 4")
                {
                }
                fieldelement(IncludeVariable5; Lubs."IncludeVariable 5")
                {
                }
                fieldelement(IncludeVariable6; Lubs."IncludeVariable 6")
                {
                }
                fieldelement(MinimumUnitsFailed; Lubs."Minimum Units Failed")
                {
                }
                fieldelement(MaximumUnitsFailed; Lubs."Maximum Units Failed")
                {
                }
                fieldelement(Status; Lubs.Status)
                {
                }
                fieldelement(SummaryPageCaption; Lubs."Summary Page Caption")
                {
                }
                fieldelement(IncludeFailedUnitsHeaders; Lubs."Include Failed Units Headers")
                {
                }
                fieldelement(FailsBasedon; Lubs."Fails Based on")
                {
                }
                fieldelement(TranscriptRemarks; Lubs."Transcript Remarks")
                {
                }
                fieldelement(FinalYearComment; Lubs."Final Year Comment")
                {
                }
                fieldelement(AcademicYear; Lubs."Academic Year")
                {
                }
                fieldelement(MinMaxBasedon; Lubs."Min/Max Based on")
                {
                }
                fieldelement(IncludeAcademicYearCaption; Lubs."Include Academic Year Caption")
                {
                }
                fieldelement(AcademicYearText; Lubs."Academic Year Text")
                {
                }
                fieldelement(Pass; Lubs.Pass)
                {
                }
                fieldelement(SuppLubricCaption; Lubs."Supp. Lubric Caption")
                {
                }
                fieldelement(SuppLubricCaption2; Lubs."Supp. Lubric Caption 2")
                {
                }
                fieldelement(SuppLubricCaption3; Lubs."Supp. Lubric Caption 3")
                {
                }
                fieldelement(SuppLubricCaption4; Lubs."Supp. Lubric Caption 4")
                {
                }
                fieldelement(SuppLubricCaption5; Lubs."Supp. Lubric Caption 5")
                {
                }
                fieldelement(SuppLubricCaption6; Lubs."Supp. Lubric Caption 6")
                {
                }
                fieldelement(SpecialProgrammeClass; Lubs."Special Programme Class")
                {
                }
                fieldelement(SpecialProgrammeScope; Lubs."Special Programme Scope")
                {
                }
                fieldelement(IncludenoofRepeats; Lubs."Include no. of Repeats")
                {
                }
                fieldelement(MinUnitRepeatCounts; Lubs."Min. Unit Repeat Counts")
                {
                }
                fieldelement(MaxUnitRepeatCounts; Lubs."Max. Unit Repeat Counts")
                {
                }
                fieldelement(MaximumAcademicRepeat; Lubs."Maximum Academic Repeat")
                {
                }
                fieldelement(LeadStatus; Lubs."Lead Status")
                {
                }
                fieldelement(MinimumAcademicRepeats; Lubs."Minimum Academic Repeats")
                {
                }
                fieldelement(MinimumCoreFails; Lubs."Minimum Core Fails")
                {
                }
                fieldelement(MaximumCoreFails; Lubs."Maximum Core Fails")
                {
                }
                fieldelement(MinimumNoneCoreFails; Lubs."Minimum None-Core Fails")
                {
                }
                fieldelement(MaximumNoneCoreFails; Lubs."Maximum None-Core Fails")
                {
                }
                fieldelement("Year1GradComments"; Lubs."1st Year Grad. Comments")
                {

                }
                fieldelement(Year2GradComments; Lubs."2nd Year Grad. Comments")
                {
                }
                fieldelement(Year3GradComments; Lubs."3rd Year Grad. Comments")
                {
                }
                fieldelement(Year4GradComments; Lubs."4th Year Grad. Comments")
                {
                }
                fieldelement(Year5GradComments; Lubs."5th Year Grad. Comments")
                {
                }
                fieldelement(Year6GradComments; Lubs."6th Year Grad. Comments")
                {
                }
                fieldelement(Year7GradComments; Lubs."7th Year Grad. Comments")
                {

                }
                fieldelement(FinalistsGradCommDegree; Lubs."Finalists Grad. Comm. Degree")
                {
                }
                fieldelement(GradStatusMsg1; Lubs."Grad. Status Msg 1")
                {
                }
                fieldelement(GradStatusMsg2; Lubs."Grad. Status Msg 2")
                {
                }
                fieldelement(GradStatusMsg3; Lubs."Grad. Status Msg 3")
                {
                }
                fieldelement(GradStatusMsg4; Lubs."Grad. Status Msg 4")
                {
                }
                fieldelement(GradStatusMsg5; Lubs."Grad. Status Msg 5")
                {
                }
                fieldelement(GradStatusMsg6; Lubs."Grad. Status Msg 6")
                {
                }
                fieldelement(FinalistsGradCommDip; Lubs."Finalists Grad. Comm. Dip")
                {
                }
                fieldelement(FinalistsGradCommCert; Lubs."Finalists Grad. Comm. Cert.")
                {
                }
                fieldelement(Year1TransComments; Lubs."1st Year Trans. Comments")
                {
                }
                fieldelement(Year2TransComments; Lubs."2nd Year  Trans. Comments")
                {
                }
                fieldelement(Year3TransComments; Lubs."3rd Year  Trans. Comments")
                {
                }
                fieldelement(Year4TransComments; Lubs."4th Year  Trans. Comments")
                {
                }
                fieldelement(Year5TransComments; Lubs."5th Year  Trans. Comments")
                {
                }
                fieldelement(Year6TransComments; Lubs."6th Year  Trans. Comments")
                {
                }


                trigger OnBeforeInsertRecord()
                begin
                    //if UserId <> 'Appkings' then Error('Access Denied');
                end;


            }

        }
    }

}