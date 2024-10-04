page 78132 "ACA-Print Admn Letter JAb"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "ACA-Applic. Form Header";
    SourceTableView = WHERE("Settlement Type" = FILTER('JAB'));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Degree Choice"; Rec."First Degree Choice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Choice Stage"; Rec."First Choice Stage")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Choice Semester"; Rec."First Choice Semester")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 1"; Apps."Address for Correspondence1")
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Apps."Address for Correspondence2")
                {
                    ApplicationArea = All;
                }
                field(Phone; Apps."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Address for Correspondence1"; Rec."Address for Correspondence1")
                {
                    Caption = 'Postal Address';
                    ApplicationArea = All;
                }
                field("Address for Correspondence2"; Rec."Address for Correspondence2")
                {
                    Caption = 'Postal Code';
                    ApplicationArea = All;
                }
                field("Address for Correspondence3"; Rec."Address for Correspondence3")
                {
                    Caption = 'Town';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Print Admission Letter & Fee Structure")
                {
                    Caption = '&Print Admission Letter & Fee Structure';
                    Image = Print;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Ask the user for the confirmation to  send o the printer*/
                        SendToPrinter := TRUE;
                        IF CONFIRM('Send Selected Provisional Admission Letter DIRECTLY to Printer', FALSE) = FALSE THEN BEGIN
                            SendToPrinter := FALSE;
                        END;
                        /*Set the range for the printer*/
                        Rec.TESTFIELD("First Degree Choice");
                        IF Rec."First Degree Choice" <> '' THEN BEGIN
                            IF progs.GET(Rec."First Degree Choice") THEN BEGIN
                            END;

                        END;
                        Apps.RESET;
                        Apps.SETRANGE(Apps."Application No.", Rec."Application No.");
                        Apps.SETRANGE(Apps.Select, TRUE);
                        IF Apps.FIND('-') THEN BEGIN
                            REPEAT
                                /*Print the report for the selected provisional admission letter*/
                                IF SendToPrinter = TRUE THEN BEGIN
                                    IF ((progs.Category <> progs.Category::Diploma) AND (progs.Category <> progs.Category::Certificate)) THEN
                                        REPORT.RUN(51343, FALSE, SendToPrinter, Apps)
                                    ELSE
                                        REPORT.RUN(51343, FALSE, SendToPrinter, Apps);
                                END
                                ELSE BEGIN
                                    IF ((progs.Category <> progs.Category::Diploma) AND (progs.Category <> progs.Category::Certificate)) THEN
                                        REPORT.RUN(51343, TRUE, SendToPrinter, Apps)
                                    ELSE
                                        REPORT.RUN(51343, TRUE, SendToPrinter, Apps);
                                END;
                            UNTIL Apps.NEXT = 0;
                        END;

                    end;
                }
            }
        }
    }

    var
        Apps: Record "ACA-Applic. Form Header";
        SendToPrinter: Boolean;
        progs: Record "ACA-Programme";
}

