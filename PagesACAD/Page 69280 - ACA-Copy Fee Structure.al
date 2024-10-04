page 69280 "ACA-Copy Fee Structure"
{
    PageType = Card;
    SourceTable = "ACA-Programme";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Program Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Program Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(FromCode; FromCode)
                {
                    Caption = 'Copy From Code';
                    TableRelation = "ACA-Programme".Code;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF progs.GET(FromCode) THEN BEGIN
                            FromDesc := progs.Description;
                        END;
                    end;
                }
                field(FromDesc; FromDesc)
                {
                    Caption = 'Copy Fro Description';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(CopyFeeStruct)
            {
                Caption = 'Copy Fee Structure';
                Image = CopyBOM;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Code = FromCode THEN ERROR('The Source and destination Programs cannot be the same.');
                    // Check & Insert The Stages on the New Programs
                    progStages.RESET;
                    progStages.SETRANGE("Programme Code", FromCode);
                    IF progStages.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            progStages2.RESET;
                            progStages2.SETRANGE("Programme Code", Rec.Code);
                            progStages2.SETRANGE(Code, progStages.Code);
                            IF NOT progStages2.FIND('-') THEN BEGIN
                                progStages2.INIT;
                                progStages2."Programme Code" := Rec.Code;
                                progStages2.Code := progStages.Code;
                                progStages2.Description := progStages.Description;
                                progStages2."G/L Account" := progStages."G/L Account";
                                progStages2.Department := progStages.Department;
                                progStages2.Remarks := progStages.Remarks;
                                progStages2."Final Stage" := progStages."Final Stage";
                                progStages2.INSERT;
                            END;
                        END;
                        UNTIL progStages.NEXT = 0;
                    END;
                    ////////////////////////////////////
                    FeeByStage.RESET;
                    FeeByStage.SETRANGE(FeeByStage."Programme Code", FromCode);
                    IF FeeByStage.FIND('-') THEN BEGIN
                        FeeByStage2.RESET;
                        FeeByStage2.SETRANGE(FeeByStage2."Programme Code", Rec.Code);
                        IF FeeByStage2.FIND('-') THEN BEGIN
                            FeeByStage2.DELETEALL;
                        END;
                        // Fees found.
                        REPEAT
                        BEGIN
                            FeeByStage2.INIT;
                            FeeByStage2."Programme Code" := Rec.Code;
                            FeeByStage2."Stage Code" := FeeByStage."Stage Code";
                            FeeByStage2.Semester := FeeByStage.Semester;
                            FeeByStage2."Student Type" := FeeByStage."Student Type";
                            FeeByStage2."Settlemet Type" := FeeByStage."Settlemet Type";
                            FeeByStage2."Seq." := FeeByStage."Seq.";
                            FeeByStage2."Break Down" := FeeByStage."Break Down";
                            FeeByStage2.Remarks := FeeByStage.Remarks;
                            FeeByStage2."Amount Not Distributed" := FeeByStage."Amount Not Distributed";
                            FeeByStage2."programme Name" := FeeByStage."programme Name";
                            FeeByStage2."Stage Description" := FeeByStage."Stage Description";
                            FeeByStage2."Stage Charges" := FeeByStage."Stage Charges";
                            FeeByStage2.INSERT;
                        END;
                        UNTIL FeeByStage.NEXT = 0;
                    END ELSE
                        ERROR('The Specified Source Program does not have a fee Structure.');

                    Chargeables.RESET;
                    Chargeables.SETRANGE(Chargeables."Programme Code", FromCode);
                    IF Chargeables.FIND('-') THEN BEGIN
                        Chargeables2.RESET;
                        Chargeables2.SETRANGE(Chargeables2."Programme Code", Rec.Code);
                        IF Chargeables2.FIND('-') THEN BEGIN
                            Chargeables2.DELETEALL;
                        END;
                        // Copy Chargeable Items
                        REPEAT
                        BEGIN
                            Chargeables2.INIT;
                            Chargeables2."Programme Code" := Rec.Code;
                            Chargeables2."Stage Code" := Chargeables."Stage Code";
                            Chargeables2.Code := Chargeables.Code;
                            Chargeables2."Settlement Type" := Chargeables."Settlement Type";
                            Chargeables2.Semester := Chargeables.Semester;
                            Chargeables2.Description := Chargeables.Description;
                            Chargeables2.Amount := Chargeables.Amount;
                            Chargeables2.Remarks := Chargeables.Remarks;
                            Chargeables2."Recovered First" := Chargeables."Recovered First";
                            Chargeables2."Student Type" := Chargeables."Student Type";
                            Chargeables2."Recovery Priority" := Chargeables."Recovery Priority";
                            Chargeables2."Distribution (%)" := Chargeables."Distribution (%)";
                            Chargeables2."Distribution Account" := Chargeables."Distribution Account";
                            //Chargeables2."Programme Description":=Chargeables."Programme Description";
                            Chargeables2.INSERT;
                        END;
                        UNTIL Chargeables.NEXT = 0;
                    END ELSE
                        ERROR('The Chargeable items for the specified source does not exist.');

                    CurrPage.CLOSE;
                    MESSAGE('Fee Structure Copied Successfully');
                end;
            }
        }
    }

    var
        FromCode: Code[20];
        FromDesc: Text[150];
        FeeByStage: Record "ACA-Fee By Stage";
        Chargeables: Record "ACA-Stage Charges";
        FeeByStage2: Record "ACA-Fee By Stage";
        Chargeables2: Record "ACA-Stage Charges";
        progStages: Record "ACA-Programme Stages";
        progStages2: Record "ACA-Programme Stages";
        progs: Record "ACA-Programme";
}

