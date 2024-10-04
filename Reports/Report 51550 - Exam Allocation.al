report 51550 "Exam Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Allocation.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Code, "Programme Option");
            RequestFilterFields = "Programme Code", "Stage Code", "Exam Not Allocated", "Exam Slots Varience";
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
            column(USERID; USERID)
            {
            }
            column(Units_Subjects__Programme_Code_; "Programme Code")
            {
            }
            column(Units_Subjects__Stage_Code_; "Stage Code")
            {
            }
            column(Units_Subjects_Code; Code)
            {
            }
            column(Units_Subjects_Desription; Desription)
            {
            }
            column(Allocated; Allocated)
            {
            }
            column(Units_Subjects__Units_Subjects___Exam_Slots_Varience_; "ACA-Units/Subjects"."Exam Slots Varience")
            {
            }
            column(Time_Table_AllocationCaption; Time_Table_AllocationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Units_Subjects__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Units_Subjects__Stage_Code_Caption; FIELDCAPTION("Stage Code"))
            {
            }
            column(Units_Subjects_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Units_Subjects_DesriptionCaption; FIELDCAPTION(Desription))
            {
            }
            column(Slots_VarienceCaption; Slots_VarienceCaptionLbl)
            {
            }
            column(AllocatedCaption; AllocatedCaptionLbl)
            {
            }
            column(Units_Subjects_Entry_No; "Entry No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrevU := FALSE;
                PrevP := FALSE;

                IF PUnit = "ACA-Units/Subjects".Code THEN
                    PrevU := TRUE;

                PUnit := "ACA-Units/Subjects".Code;

                IF PProg = "ACA-Units/Subjects"."Programme Code" THEN
                    PrevP := TRUE;

                PProg := "ACA-Units/Subjects"."Programme Code";


                Allocated := TRUE;
                IF "ACA-Units/Subjects"."Exam Not Allocated" = TRUE THEN
                    Allocated := FALSE
                ELSE
                    Allocated := TRUE;

                IF "ACA-Units/Subjects"."Exam Slots Varience" > 0 THEN
                    Allocated := FALSE;
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
        PUnit: Code[20];
        PrevU: Boolean;
        PrevP: Boolean;
        PProg: Code[20];
        Allocated: Boolean;
        Time_Table_AllocationCaptionLbl: Label 'Time Table Allocation';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Slots_VarienceCaptionLbl: Label 'Slots Varience';
        AllocatedCaptionLbl: Label 'Allocated';
}

