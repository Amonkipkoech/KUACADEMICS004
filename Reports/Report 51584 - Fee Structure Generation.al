report 51584 "Fee Structure Generation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fee Structure Generation.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            DataItemTableView = SORTING(Code);
            RequestFilterFields = "Code", "Stage Filter", "Semester Filter", "Settlement Type Filter";
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
            column(Programme_Code; Code)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme_Category; Category)
            {
            }
            column(Master_Fee_UpdateCaption; Master_Fee_UpdateCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Programme_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Programme_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Programme_CategoryCaption; FIELDCAPTION(Category))
            {
            }
            column(FE; "ACA-Programme"."Tuition Fees")
            {
            }
            dataitem("ACA-Programme Stages"; 61516)
            {
                DataItemLink = "Programme Code" = FIELD(Code),
                               Code = FIELD("Stage Filter");
                DataItemTableView = SORTING("Programme Code", Code)
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    MasterFee.RESET;
                    IF MasterFee.FIND('-') THEN BEGIN
                        FeeByStage.RESET;
                        FeeByStage.SETRANGE(FeeByStage."Programme Code", "ACA-Programme Stages"."Programme Code");
                        FeeByStage.SETRANGE(FeeByStage."Stage Code", "ACA-Programme Stages".Code);
                        FeeByStage.SETRANGE(FeeByStage."Settlemet Type", MasterFee."Settlemet Type");
                        FeeByStage.SETFILTER(FeeByStage.Semester, "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                        IF FeeByStage.FIND('-') THEN
                            FeeByStage.DELETEALL;

                        REPEAT
                            FeeByStage.INIT;
                            FeeByStage."Programme Code" := "ACA-Programme Stages"."Programme Code";
                            FeeByStage."Stage Code" := "ACA-Programme Stages".Code;
                            FeeByStage.Semester := "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter");
                            FeeByStage."Student Type" := MasterFee."Student Type";
                            FeeByStage."Settlemet Type" := MasterFee."Settlemet Type";
                            FeeByStage."Seq." := MasterFee."Seq.";
                            FeeByStage."Break Down" := MasterFee."Break Down";
                            FeeByStage."Amount Not Distributed" := MasterFee."Amount Not Distributed";
                            FeeByStage.INSERT;


                        UNTIL MasterFee.NEXT = 0;
                    END;


                    StageC.RESET;
                    StageC.SETRANGE(StageC."Programme Code", "ACA-Programme Stages"."Programme Code");
                    StageC.SETRANGE(StageC."Stage Code", "ACA-Programme Stages".Code);
                    StageC.SETFILTER(StageC.Semester, "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter"));
                    StageC.SETFILTER(StageC."Settlement Type", "ACA-Programme".GETFILTER("Settlement Type Filter"));
                    IF StageC.FIND('-') THEN
                        StageC.DELETEALL;


                    MasterCharges.RESET;
                    MasterCharges.SETRANGE(MasterCharges."First Time Students", FALSE);
                    MasterCharges.SETRANGE(MasterCharges."First Semster Only", FALSE);
                    IF MasterCharges.FIND('-') THEN BEGIN
                        REPEAT

                            StageC.INIT;
                            StageC."Programme Code" := "ACA-Programme Stages"."Programme Code";
                            StageC."Stage Code" := "ACA-Programme Stages".Code;
                            StageC.Code := MasterCharges.Code;
                            StageC.Semester := "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter");
                            StageC.Description := MasterCharges.Description;
                            StageC.Amount := MasterCharges.Amount;
                            StageC."Student Type" := MasterCharges."Student Type";
                            StageC."Recovery Priority" := MasterCharges."Recovery Priority";
                            StageC."Distribution (%)" := MasterCharges."Distribution (%)";
                            StageC."Distribution Account" := MasterCharges."Distribution Account";
                            StageC."Settlement Type" := "ACA-Programme".GETFILTER("Settlement Type Filter");
                            StageC.INSERT;

                        UNTIL MasterCharges.NEXT = 0;

                    END;


                    IF COPYSTR("ACA-Programme Stages".Code, 3, 2) = 'S1' THEN BEGIN
                        MasterCharges.RESET;
                        MasterCharges.SETRANGE(MasterCharges."First Time Students", FALSE);
                        MasterCharges.SETRANGE(MasterCharges."First Semster Only", TRUE);
                        IF MasterCharges.FIND('-') THEN BEGIN
                            REPEAT

                                StageC.INIT;
                                StageC."Programme Code" := "ACA-Programme Stages"."Programme Code";
                                StageC."Stage Code" := "ACA-Programme Stages".Code;
                                StageC.Code := MasterCharges.Code;
                                StageC.Description := MasterCharges.Description;
                                StageC.Semester := "ACA-Programme".GETFILTER("ACA-Programme"."Semester Filter");
                                StageC.Amount := MasterCharges.Amount;
                                StageC."Student Type" := MasterCharges."Student Type";
                                StageC."Recovery Priority" := MasterCharges."Recovery Priority";
                                StageC."Distribution (%)" := MasterCharges."Distribution (%)";
                                StageC."Distribution Account" := MasterCharges."Distribution Account";
                                StageC."Settlement Type" := "ACA-Programme".GETFILTER("Settlement Type Filter");
                                StageC.INSERT;

                            UNTIL MasterCharges.NEXT = 0;

                        END;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*
               NewSCharges.RESET;
               NewSCharges.SETRANGE(NewSCharges."Programme Code",Programme.Code);
               NewSCharges.SETFILTER(NewSCharges.Code,"Programme Stages".GETFILTER("Programme Stages".Code));
               IF NewSCharges.FIND('-') THEN
               NewSCharges.DELETEALL;
                */
                /* IF Programme.GETFILTER(Programme."Settlement Type Filter")= '' THEN
                 ERROR('Please select the Settlement type filter');  */

                MasterCharges.RESET;
                MasterCharges.SETRANGE(MasterCharges."First Time Students", TRUE);
                IF MasterCharges.FIND('-') THEN BEGIN
                    REPEAT
                        NewSCharges."Programme Code" := "ACA-Programme".Code;
                        NewSCharges.Code := MasterCharges.Code;
                        NewSCharges.Description := MasterCharges.Description;
                        NewSCharges.Amount := MasterCharges.Amount;
                        NewSCharges."First Time Students" := MasterCharges."First Time Students";
                        NewSCharges."Student Type" := MasterCharges."Student Type";
                        NewSCharges."Recovery Priority" := MasterCharges."Recovery Priority";
                        NewSCharges."Distribution (%)" := MasterCharges."Distribution (%)";
                        NewSCharges."Distribution Account" := MasterCharges."Distribution Account";
                        NewSCharges.INSERT;

                    UNTIL MasterCharges.NEXT = 0;
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
        FeeByStage: Record 61523;
        StageC: Record 61533;
        NewSCharges: Record 61543;
        MasterFee: Record 61555;
        MasterCharges: Record 61556;
        Master_Fee_UpdateCaptionLbl: Label 'Master Fee Update';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

