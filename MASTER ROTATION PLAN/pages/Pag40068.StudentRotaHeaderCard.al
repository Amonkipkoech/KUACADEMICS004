page 40068 "Student Rota Header Card"
{
    PageType = Card;
    SourceTable = "Student Rota Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; "ID") { Editable = false; }
                field("Semester"; "Semester") { }
                field("Academic Year"; "Academic Year") { }
                field("Status"; "Status") { }
                field("Current"; "Current") { Editable = false; }
                field("Created Date"; "Created Date") { Editable = false; }
            }

            part(RotaLines; "Student Rota Line Subpage")
            {
                SubPageLink = "Header ID" = field(ID);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PostRota)
            {
                ApplicationArea = All;
                Caption = 'Post Rota';
                trigger OnAction()
                var
                    RotaHeader: Record "Student Rota Header";
                    RotaLine: Record "Student Rota Line";
                begin
                    // Unmark all old
                    RotaHeader.Reset();
                    RotaHeader.SetRange("Current", true);
                    if RotaHeader.FindSet() then begin
                        repeat
                            RotaHeader."Current" := false;
                            RotaHeader.Modify();

                            RotaLine.Reset();
                            RotaLine.SetRange("Header ID", RotaHeader.ID);
                            if RotaLine.FindSet() then begin
                                repeat
                                    RotaLine."Viewable" := false;
                                    RotaLine.Modify();
                                until RotaLine.Next() = 0;
                            end;
                        until RotaHeader.Next() = 0;
                    end;

                    // Mark current as active and viewable
                    Rec."Current" := true;
                    Rec.Modify();

                    RotaLine.Reset();
                    RotaLine.SetRange("Header ID", Rec.ID);
                    if RotaLine.FindSet() then begin
                        repeat
                            RotaLine."Viewable" := true;
                            RotaLine.Modify();
                        until RotaLine.Next() = 0;
                    end;
                end;
            }
        }
    }
}

