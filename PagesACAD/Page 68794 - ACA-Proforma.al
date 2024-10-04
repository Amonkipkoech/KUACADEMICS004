page 68794 "ACA-Proforma"
{
    PageType = Document;
    SourceTable = 61588;
    SourceTableView = WHERE("Proforma No." = FILTER(<> 999999999));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Proforma No."; Rec."Proforma No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    ApplicationArea = All;
                }
                field("Programme Description"; Rec."Programme Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field(Modules; Rec.Modules)
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
            }
#pragma warning disable AL0269
            part(ACAPL; "ACA-Proforma Lines")
#pragma warning restore AL0269
            {
                SubPageLink = "Reg. Transacton ID" = FIELD("Proforma No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Proforma")
            {
                Caption = 'Print Proforma';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Proforma.RESET;
                    Proforma.SETRANGE(Proforma."Proforma No.", Rec."Proforma No.");
                    IF Proforma.FIND('-') THEN
                        REPORT.RUN(39005978, TRUE, FALSE, Proforma);
                end;
            }
        }
    }

    var
        Proforma: Record "ACA-Proforma";
}

