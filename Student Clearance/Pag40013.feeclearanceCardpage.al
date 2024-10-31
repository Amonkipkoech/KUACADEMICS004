page 40013 "fee clearance Card page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "VC cleared Batches";
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Clearance Batch"; Rec."Clearance Batch")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Time field.';
                }

            }
            part(units; vcClearedList)
            {
                SubPageLink = "Clearance batch" = field("Clearance Batch");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clear Students")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    if not Confirm('Are you sure you want to clear the list below for exams?', false) then exit;
                    vclist.Reset();
                    vclist.SetRange(Approved, false);
                    if vclist.Find('-') then begin
                        repeat
                            cust.Reset();
                            cust.SetRange("No.", vclist.studentNo);
                            if cust.Find('-') then begin
                                cust."Fee Cleared"  := true;
                                cust.Modify();
                                vclist.Approved := true;
                                vclist.Modify();
                            end;
                        until vclist.Next() = 0;
                    end;
                    Message('Processed Successfully!!!');
                end;
            }
        }
    }

    var
        cust: Record Customer;
        vclist: Record VcCleraedList;
}