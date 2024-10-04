page 68490 "ACA-Applic. Form Prv Adm List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = 61358;
    SourceTableView = WHERE(Status = CONST("Provisional Admission"));

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
                field("Application Date"; Rec."Application Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admitted Degree"; Rec."Admitted Degree")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admitted To Stage"; Rec."Admitted To Stage")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admitted Semester"; Rec."Admitted Semester")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Date Of Meeting"; Rec."Date Of Meeting")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Deferred Until"; Rec."Deferred Until")
                {
                    Editable = false;
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
                field("Country of Origin"; Rec."Country of Origin")
                {
                    Editable = false;
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
                        Apps.RESET;
                        Apps.SETRANGE(Apps."Application No.", Rec."Application No.");
                        Apps.SETRANGE(Apps.Select, TRUE);
                        IF Apps.FIND('-') THEN BEGIN
                            REPEAT
                                /*Print the report for the selected provisional admission letter*/
                                IF SendToPrinter = TRUE THEN BEGIN
                                    REPORT.RUN(39005743, FALSE, SendToPrinter, Apps);
                                    //  REPORT.RUN(39005761,FALSE,SendToPrinter,Apps);
                                END
                                ELSE BEGIN
                                    REPORT.RUN(39005743, TRUE, SendToPrinter, Apps);
                                    //  REPORT.RUN(39005743,TRUE,SendToPrinter,Apps);
                                    //  REPORT.RUN(39005761,TRUE,SendToPrinter,Apps);
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
}

