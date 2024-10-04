page 68017 "ACA-Stud. Status Data"
{
    PageType = List;
    SourceTable = 61761;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Sponsor Ref."; Rec."Sponsor Ref.")
                {
                    ApplicationArea = All;
                }
                field("NOK Relation"; Rec."NOK Relation")
                {
                    ApplicationArea = All;
                }
                field("NOK Address"; Rec."NOK Address")
                {
                    ApplicationArea = All;
                }
                field("NOK Email"; Rec."NOK Email")
                {
                    ApplicationArea = All;
                }
                field("NOK Town"; Rec."NOK Town")
                {
                    ApplicationArea = All;
                }
                field("NOK Phone"; Rec."NOK Phone")
                {
                    ApplicationArea = All;
                }
                field("NOK Ext"; Rec."NOK Ext")
                {
                    ApplicationArea = All;
                }
                field("NOK Mobile"; Rec."NOK Mobile")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Reason"; Rec."Withdrawal Reason")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Naration"; Rec."Withdrawal Naration")
                {
                    ApplicationArea = All;
                }
                field("Reinstate Note"; Rec."Reinstate Note")
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                }
                field("Discipline Status"; Rec."Discipline Status")
                {
                    ApplicationArea = All;
                }
                field(RegStud_Class; Rec.RegStud_Class)
                {
                    ApplicationArea = All;
                }
                field(RegCtudent_Cleared; Rec.RegCtudent_Cleared)
                {
                    ApplicationArea = All;
                }
                field(RegCtudent_Cleared_Date; Rec.RegCtudent_Cleared_Date)
                {
                    ApplicationArea = All;
                }
                field(RegStudent_Spons_Name; Rec.RegStudent_Spons_Name)
                {
                    ApplicationArea = All;
                }
                field(Sponsor_Address; Rec.Sponsor_Address)
                {
                    ApplicationArea = All;
                }
                field(Sponsor_Town; Rec.Sponsor_Town)
                {
                    ApplicationArea = All;
                }
                field(Sponsor_Email; Rec.Sponsor_Email)
                {
                    ApplicationArea = All;
                }
                field(Origin; Rec.Origin)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = AddAction;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    studBuffer.RESET;
                    IF studBuffer.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF cust.GET(studBuffer."Student No.") THEN BEGIN
                                IF (studBuffer.Cleared) THEN BEGIN
                                    cust."Clearance Status" := cust."Clearance Status"::Cleared;
                                    IF studBuffer.RegCtudent_Cleared_Date <> '' THEN BEGIN
                                        //if Evaluate()
                                    END;
                                    IF EVALUATE(beginDate, studBuffer.RegStud_RegDate) THEN BEGIN
                                    END;
                                    IF EVALUATE(endDate, studBuffer.Course_End_Date) THEN BEGIN
                                    END;
                                    IF beginDate <> 0D THEN BEGIN
                                        cust."Admission Date" := beginDate;
                                    END;
                                    IF endDate <> 0D THEN BEGIN
                                        cust."Programme End Date" := endDate;
                                    END;
                                    DimVal.RESET;
                                    DimVal.SETRANGE(DimVal."Dimension Code", 'DEPARTMENT');
                                    DimVal.SETRANGE(DimVal.Code, studBuffer.RegStud_DeptID);
                                    IF DimVal.FIND('-') THEN
                                        cust."Global Dimension 2 Code" := studBuffer.RegStud_DeptID;
                                    cust.MODIFY;
                                END;
                            END;
                        END;
                        UNTIL studBuffer.NEXT = 0;
                    END;
                end;
            }
            action("Create Withdrawal Reason")
            {
                Caption = 'Create Withdrawal Reason';
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    studBuffer.RESET;
                    IF studBuffer.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF NOT (withdReasons.GET(studBuffer."Withdrawal Reason")) THEN BEGIN
                                withdReasons.INIT;
                                withdReasons."Withdraw Reason" := studBuffer."Withdrawal Reason";
                                withdReasons.INSERT;
                            END;
                        END;
                        UNTIL studBuffer.NEXT = 0;
                    END;
                end;
            }
            action("Update Student Status")
            {
                Caption = 'Update Student Status';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    studBuffer.RESET;
                    IF studBuffer.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            IF (withdReasons.GET(studBuffer."Withdrawal Reason")) THEN BEGIN
                                IF ((withdReasons."Withdraw Reason" <> '') AND (withdReasons."Withdraw Reason" <> '-')) THEN
                                    IF cust.GET(studBuffer."Student No.") THEN BEGIN
                                        cust.Status := withdReasons.Status;
                                        cust.MODIFY;
                                    END;
                            END;
                        END;
                        UNTIL studBuffer.NEXT = 0;
                    END;
                end;
            }
        }
    }

    var
        cust: Record 18;
        studBuffer: Record 61761;
        beginDate: Date;
        endDate: Date;
        DimVal: Record 349;
        withdReasons: Record 61010;
}

