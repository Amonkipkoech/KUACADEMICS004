page 68834 "ACA-Fee Structure Per Unit"
{
    PageType = List;
    SourceTable = 61652;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Amount Per Unit"; Rec."Amount Per Unit")
                {
                    ApplicationArea = All;
                }
                field("Programme Name"; Rec."Programme Name")
                {
                    ApplicationArea = All;
                }
                field("Settlement Desc."; Rec."Settlement Desc.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Student';
                action("Post Fee Structure")
                {
                    Caption = 'Post Fee Structure';
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Are you sure you want to Update the Fee Structure?\This may take afew minutes. Continue?', TRUE) = FALSE THEN EXIT;

                        Feestruct.RESET;
                        Feestruct.SETFILTER(Feestruct."Amount Per Unit", '>%1', 0);
                        IF Feestruct.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ProgSem.RESET;
                                ProgSem.SETRANGE(ProgSem."Programme Code", Feestruct."Programme Code");
                                IF ProgSem.FIND('-') THEN BEGIN
                                    ProgressWindow.OPEN('Proccessing Fee Structure for #1#####################################');
                                    REPEAT
                                    BEGIN
                                        ProgressWindow.UPDATE(1, Feestruct."Programme Code" + ' ' + Feestruct."Programme Name");
                                        SLEEP(100);
                                        IF Feestruct.Type = Feestruct.Type::lumpsum THEN BEGIN
                                            StageFee.RESET;
                                            StageFee.SETRANGE(StageFee."Programme Code", ProgSem."Programme Code");
                                            StageFee.SETRANGE(StageFee.Semester, ProgSem.Semester);
                                            IF Feestruct."Student Type" = 'Full Time' THEN
                                                StageFee.SETRANGE(StageFee."Student Type", 0)
                                            ELSE
                                                IF Feestruct."Student Type" = 'Part Time' THEN
                                                    StageFee.SETRANGE(StageFee."Student Type", 1)
                                                ELSE
                                                    IF Feestruct."Student Type" = 'ODL' THEN
                                                        StageFee.SETRANGE(StageFee."Student Type", 2)
                                                    ELSE
                                                        IF Feestruct."Student Type" = 'SB' THEN
                                                            StageFee.SETRANGE(StageFee."Student Type", 3);
                                            StageFee.SETRANGE(StageFee."Settlemet Type", Feestruct."Settlement Type");
                                            IF StageFee.FIND('-') THEN StageFee.DELETEALL;
                                            ProgStages.RESET;
                                            ProgStages.SETRANGE(ProgStages."Programme Code", Feestruct."Programme Code");
                                            IF ProgStages.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    StageFee.INIT;
                                                    StageFee."Programme Code" := Feestruct."Programme Code";
                                                    StageFee."Stage Code" := ProgStages.Code;
                                                    StageFee.Semester := ProgSem.Semester;
                                                    StageFee."Settlemet Type" := Feestruct."Student Type";
                                                    IF Feestruct."Student Type" = 'Full Time' THEN
                                                        StageFee."Student Type" := 0
                                                    ELSE
                                                        IF Feestruct."Student Type" = 'Part Time' THEN
                                                            StageFee."Student Type" := 1
                                                        ELSE
                                                            IF Feestruct."Student Type" = 'ODL' THEN
                                                                StageFee."Student Type" := 2
                                                            ELSE
                                                                IF Feestruct."Student Type" = 'SB' THEN
                                                                    StageFee."Student Type" := 3;
                                                    StageFee."Seq." := 1;
                                                    StageFee."Break Down" := Feestruct."Amount Per Unit";
                                                    StageFee.INSERT();
                                                END;
                                                UNTIL ProgStages.NEXT = 0;
                                            END; // if ProgStages.find('-') then
                                        END ELSE
                                            IF Feestruct.Type = Feestruct.Type::"Per Unit" THEN BEGIN


                                                UnitFee.RESET;
                                                UnitFee.SETRANGE(UnitFee."Programme Code", ProgSem."Programme Code");
                                                UnitFee.SETRANGE(UnitFee.Semester, ProgSem.Semester);
                                                IF Feestruct."Student Type" = 'Full Time' THEN
                                                    UnitFee.SETRANGE(UnitFee."Student Type", UnitFee."Student Type"::"Full Time")
                                                ELSE
                                                    IF Feestruct."Student Type" = 'Part Time' THEN
                                                        UnitFee.SETRANGE(UnitFee."Student Type", UnitFee."Student Type"::"Part Time")
                                                    ELSE
                                                        IF Feestruct."Student Type" = 'ODL' THEN
                                                            UnitFee.SETRANGE(UnitFee."Student Type", UnitFee."Student Type"::"Distance Learning");
                                                //   ELSE IF Feestruct."Settlement Type" = 'SB' THEN
                                                // UnitFee.SETRANGE(UnitFee."Student Type",UnitFee."Student Type"::"School Based");

                                                UnitFee.SETRANGE(UnitFee."Settlemet Type", Feestruct."Settlement Type");
                                                IF UnitFee.FIND('-') THEN UnitFee.DELETEALL;
                                                ProgStages.RESET;
                                                ProgStages.SETRANGE(ProgStages."Programme Code", Feestruct."Programme Code");
                                                IF ProgStages.FIND('-') THEN BEGIN
                                                    REPEAT
                                                    BEGIN
                                                        ProgUnits.RESET;
                                                        ProgUnits.SETRANGE(ProgUnits."Programme Code", Feestruct."Programme Code");
                                                        ProgUnits.SETRANGE(ProgUnits."Stage Code", ProgStages.Code);
                                                        IF ProgUnits.FIND('-') THEN BEGIN
                                                            REPEAT
                                                            BEGIN
                                                                UnitFee.RESET;
                                                                UnitFee.SETRANGE(UnitFee."Programme Code", Feestruct."Programme Code");
                                                                UnitFee.SETRANGE(UnitFee."Stage Code", ProgStages.Code);
                                                                UnitFee.SETRANGE(UnitFee."Unit Code", ProgUnits.Code);
                                                                UnitFee.SETRANGE(UnitFee.Semester, ProgSem.Semester);
                                                                IF Feestruct."Student Type" = 'Full Time' THEN
                                                                    UnitFee.SETRANGE(UnitFee."Student Type", UnitFee."Student Type"::"Full Time")
                                                                ELSE
                                                                    IF Feestruct."Student Type" = 'Part Time' THEN
                                                                        UnitFee.SETRANGE(UnitFee."Student Type", UnitFee."Student Type"::"Part Time")
                                                                    ELSE
                                                                        IF Feestruct."Student Type" = 'ODL' THEN
                                                                            UnitFee.SETRANGE(UnitFee."Student Type", UnitFee."Student Type"::"Distance Learning");
                                                                //  ELSE IF Feestruct."Settlement Type" = 'SB' THEN
                                                                //  UnitFee.SETRANGE(UnitFee."Student Type",UnitFee."Student Type"::"School Based");

                                                                UnitFee.SETRANGE(UnitFee."Settlemet Type", Feestruct."Settlement Type");
                                                                IF UnitFee.FIND('-') THEN
                                                                    UnitFee.DELETEALL;

                                                                UnitFee.INIT;
                                                                UnitFee."Programme Code" := Feestruct."Programme Code";
                                                                UnitFee."Stage Code" := ProgStages.Code;
                                                                UnitFee."Unit Code" := ProgUnits.Code;
                                                                UnitFee.Semester := ProgSem.Semester;
                                                                UnitFee."Settlemet Type" := Feestruct."Settlement Type";
                                                                IF Feestruct."Student Type" = 'Full Time' THEN
                                                                    UnitFee."Student Type" := UnitFee."Student Type"::"Full Time"
                                                                ELSE
                                                                    IF Feestruct."Student Type" = 'Part Time' THEN
                                                                        UnitFee."Student Type" := UnitFee."Student Type"::"Part Time"
                                                                    ELSE
                                                                        IF Feestruct."Student Type" = 'ODL' THEN
                                                                            UnitFee."Student Type" := UnitFee."Student Type"::"Distance Learning";
                                                                //   ELSE IF Feestruct."Settlement Type" = 'SB' THEN
                                                                //  UnitFee."Student Type":=UnitFee."Student Type"::"School Based";
                                                                UnitFee."Seq." := 1;
                                                                UnitFee."Break Down" := Feestruct."Amount Per Unit";
                                                                UnitFee.INSERT();
                                                            END;
                                                            UNTIL ProgUnits.NEXT = 0;
                                                        END; //  if ProgUnits.fin('-') then
                                                    END;
                                                    UNTIL ProgStages.NEXT = 0;
                                                END; // if ProgStages.find('-') then

                                            END;// end if Feestruct.Type = Feestruct.Type::LUMPSUM then begin
                                    END;
                                    UNTIL ProgSem.NEXT = 0;
                                    ProgressWindow.CLOSE();
                                END;
                            END;
                            UNTIL Feestruct.NEXT = 0;
                        END;

                        MESSAGE('The Fee Structure has Been Updated successfully.');
                    end;
                }
            }
        }
    }

    var
        Feestruct: Record "ACA-Prog. Unit Cost";
        ProgSem: Record "ACA-Programme Semesters";
        StageFee: Record "ACA-Fee By Stage";
        UnitFee: Record "ACA-Fee By Unit";
        ProgStages: Record "ACA-Programme Stages";
        ProgUnits: Record "ACA-Units/Subjects";
        ProgressWindow: Dialog;
}

