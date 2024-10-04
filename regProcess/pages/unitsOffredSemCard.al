page 86644 "UnitsOffered Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Units Offred Batches";
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
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
            part(units; "ACA-Units Offered")
            {
                SubPageLink = Semester = field(Semester);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Stream")
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin
                    // units.Reset();
                    // units.SetRange(Semester, Rec.Semester);
                    // if units.Find('-') then begin
                    //     repeat
                    //         units2.Reset();
                    //         units2.SetRange("Unit Base Code", units."Unit Base Code");
                    //         units2.SetRange(ModeofStudy, units.ModeofStudy);
                    //         units2.SetRange(Semester, units.Semester);
                    //         units2.SetRange(Campus, units.Campus);
                    //         //generate stream
                    //         IF units2.Find('-') then begin
                    //             if units2.Count = 1
                    //             then
                    //                 units2.Stream := 'Stream B' else
                    //                 if units2.Count = 2
                    //                 then
                    //                     units2.Stream := 'Stream C' else
                    //                     if units2.Count = 3
                    //                     then
                    //                         units2.Stream := 'Stream D' else
                    //                         if units2.Count = 4
                    //                         then
                    //                             units2.Stream := 'Stream E' else
                    //                             if units2.Count = 5
                    //                             then
                    //                                 units2.Stream := 'Stream F';
                    //         end else begin
                    //             units2.Stream := 'Stream A'
                    //         end;
                    //         //units2.Modify();
                    //     until units.Next() = 0;
                    //end;
                end;
            }
        }
    }

    var
        units: Record "ACA-Units Offered";
        units2: Record "ACA-Units Offered";
}