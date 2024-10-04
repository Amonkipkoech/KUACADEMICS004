report 51546 "Time Table Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Time Table Allocation.rdl';

    dataset
    {
        dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
        {
            DataItemTableView = SORTING("Programme Code", "Stage Code", Code, "Programme Option");
            RequestFilterFields = "Programme Code", "Stage Code", "Not Allocated", "Slots Varience";
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
            column(Units_Subjects__Slots_Varience_; "Slots Varience")
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
            column(Units_Subjects__Slots_Varience_Caption; FIELDCAPTION("Slots Varience"))
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
                IF "ACA-Units/Subjects"."Not Allocated" = TRUE THEN
                    Allocated := FALSE
                ELSE
                    Allocated := TRUE;

                IF "ACA-Units/Subjects"."Slots Varience" > 0 THEN
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
        AllocatedCaptionLbl: Label 'Allocated';
}

