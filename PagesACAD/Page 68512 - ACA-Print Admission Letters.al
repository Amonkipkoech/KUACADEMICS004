page 68512 "ACA-Print Admission Letters"
{
    PageType = List;
    SourceTable = 61372;
    SourceTableView = WHERE("Admission Type" = CONST('JAB'));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                Editable = true;
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Admission No."; Rec."Admission No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admission Type"; Rec."Admission Type")
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
                field("Faculty Admitted To"; Rec."Faculty Admitted To")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Degree Admitted To"; Rec."Degree Admitted To")
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
                field("E-Mail"; Rec."E-Mail")
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
            action("&Print Admission Letters and Fee Structures")
            {
                Caption = '&Print Admission Letters and Fee Structures';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Ask for the user confirmation*/
                    IF CONFIRM('Print out Admissions Letters and Fee Structure for Selected Admissions?', TRUE) = FALSE THEN BEGIN EXIT END;

                    PrintToPrinter := FALSE;
                    /*Ask for conformation of send to printer*/
                    IF CONFIRM('Send Letters Directly to System Default Printer?', FALSE) = TRUE THEN BEGIN
                        PrintToPrinter := TRUE;
                    END;
                    Admissions.RESET;
                    Admissions.SETRANGE(Admissions."Admission Type", 'JAB');
                    Admissions.SETRANGE(Admissions.Select, TRUE);

                    /*Check if the record has been retrieved*/
                    IF Admissions.FIND('-') THEN BEGIN
                        REPEAT
                            ReportAdm.RESET;
                            ReportAdm.SETRANGE(ReportAdm."Admission No.", Admissions."Admission No.");
                            IF PrintToPrinter = TRUE THEN BEGIN
                                //  REPORT.RUN(39005742,FALSE,FALSE,ReportAdm);
                                //  REPORT.RUN(39005761,FALSE,FALSE,ReportAdm);
                            END
                            ELSE BEGIN
                                REPORT.RUN(39005742, TRUE, TRUE, ReportAdm);
                                //  REPORT.RUN(39005761,FALSE,FALSE,ReportAdm);
                            END;
                        UNTIL Admissions.NEXT = 0;
                    END;

                end;
            }
        }
    }

    var
        Admissions: Record "ACA-Adm. Form Header";
        PrintToPrinter: Boolean;
        ReportAdm: Record "ACA-Adm. Form Header";
}

