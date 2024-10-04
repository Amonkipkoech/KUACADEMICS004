page 68489 "ACA-Applic. Form Prv Admission"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = 61358;
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(__)
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
                    ApplicationArea = All;
                }
                field("Admitted Semester"; Rec."Admitted Semester")
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
                action("&Process Provisional Admission Letters")
                {
                    Caption = '&Process Provisional Admission Letters';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Process the provisional admission letter*/
                        Apps.RESET;
                        Apps.SETRANGE(Apps.Status, Apps.Status::Approved);
                        Apps.SETRANGE(Apps.Select, TRUE);
                        /*Check if any records are within the range*/
                        IF Apps.COUNT < 1 THEN BEGIN
                            ERROR('No Applications Selected For Processing');
                        END
                        ELSE BEGIN
                            /*Ask for user confirmation*/
                            IF CONFIRM('Process Provisional Admission Letters For ' + FORMAT(Apps.COUNT) + ' Applications?', FALSE) = FALSE THEN BEGIN
                                EXIT
                            END;
                        END;

                        /*Loop thru the records processing each*/
                        IF Apps.FIND('-') THEN BEGIN
                            REPEAT
                                Apps.Status := Apps.Status::"Provisional Admission";
                                Apps.MODIFY;
                            UNTIL Apps.NEXT = 0;
                        END;

                        /*Alert the user that the process is complete*/
                        MESSAGE('Select Applications have been Processed and Ready for Provisional Admission Letter Printing');

                    end;
                }
                action("Process & Print Provisional Admission Letters")
                {
                    Caption = 'Process & Print Provisional Admission Letters';
                    Image = Print;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Process the provisional admission letter*/
                        Apps.RESET;
                        Apps.SETRANGE(Apps.Status, Apps.Status::Approved);
                        Apps.SETRANGE(Apps.Select, TRUE);
                        /*Check if any records are within the range*/
                        IF Apps.COUNT < 1 THEN BEGIN
                            ERROR('No Applications Selected For Processing');
                        END
                        ELSE BEGIN
                            /*Ask for user confirmation*/
                            IF CONFIRM('Process Provisional Admission Letters For ' + FORMAT(Apps.COUNT) + 'Applications?', FALSE) = FALSE THEN BEGIN
                                EXIT
                            END;
                        END;

                        SendToPrinter := TRUE;
                        /*Ask for confirmation to send to default printer*/
                        IF CONFIRM('Send Directly to Printer?', FALSE) = FALSE THEN BEGIN
                            SendToPrinter := FALSE;
                        END;

                        /*Loop thru the records processing each*/
                        IF Apps.FIND('-') THEN BEGIN
                            REPEAT
                                REPORT.RUN(39005755, FALSE, SendToPrinter, Apps);
                                Apps.Status := Apps.Status::"Provisional Admission";
                                Apps.MODIFY;
                            UNTIL Apps.NEXT = 0;
                        END;

                        /*Alert the user that the process is complete*/
                        MESSAGE('Select Applications have been Processed and Ready for Provisional Admission Letter Printing');

                    end;
                }
            }
        }
    }

    var
        Apps: Record 61358;
        SendToPrinter: Boolean;
}

