page 68970 "ACA-Clearance Approval Entries"
{
    Caption = 'Clearance Approval Entries';
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Clearance Approval Entries";
    SourceTableView = WHERE(Status = FILTER(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Clearance Level Code"; Rec."Clearance Level Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    ApplicationArea = All;
                }
                field("Initiated Date"; Rec."Initiated Date")
                {
                    ApplicationArea = All;
                }
                field("Initiated Time"; Rec."Initiated Time")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Student Intake"; Rec."Student Intake")
                {
                    ApplicationArea = All;
                }
                field("Clear By ID"; Rec."Clear By ID")
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                }
                field("Priority Level"; Rec."Priority Level")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
            action(clear_stud)
            {
                Caption = 'Clear Student';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'F12';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec."Clearance Level Code" = '' THEN ERROR('Nothing to clear!');
                    CLEAR(counted);
                    CLEAR(stringval);
                    IF CONFIRM('Clear ' + Rec."Student ID", TRUE) = FALSE THEN ERROR('Cancelled!');
                    conditions.RESET;
                    conditions.SETRANGE(conditions."Clearance Level Code", Rec."Clearance Level Code");
                    conditions.SETFILTER(conditions."Condition to Check", '<>%1', '');
                    IF conditions.FIND('-') THEN BEGIN
                        stringval := '\-----------------------***** ATTENTION *****------------------------';
                        stringval := stringval + '\Ensure that the following conditions are met';
                        REPEAT
                        BEGIN
                            stringval := stringval + '\' + FORMAT(conditions.Sequence) + '). ' + conditions."Condition to Check";
                        END;
                        UNTIL conditions.NEXT = 0;
                        stringval := stringval + '\                            CONTINUE?                               ';
                        stringval := stringval + '\-----------------------*********************------------------------';
                    END ELSE
                        stringval := 'Ensure that all the conditions required for clearance are met. Continue?';

                    IF CONFIRM(stringval, TRUE) = FALSE THEN ERROR('Cancelled!');

                    enties.RESET;
                    enties.SETRANGE(enties."Clearance Level Code", Rec."Clearance Level Code");
                    enties.SETRANGE(enties.Department, Rec.Department);
                    enties.SETRANGE(enties."Student ID", Rec."Student ID");
                    enties.SETFILTER(enties."Clear By ID", Rec."Clear By ID");
                    IF enties.FIND('-') THEN BEGIN
                        enties.Cleared := TRUE;
                        enties.MODIFY;
                    END;

                    enties.RESET;
                    enties.SETRANGE(enties."Clearance Level Code", Rec."Clearance Level Code");
                    enties.SETRANGE(enties.Department, Rec.Department);
                    enties.SETRANGE(enties."Student ID", Rec."Student ID");
                    enties.SETFILTER(enties.Status, '=%1', enties.Status::Open);
                    IF enties.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            enties."Last Date Modified" := TODAY;
                            enties."Last Time Modified" := TIME;
                            enties.Status := enties.Status::Cleared;
                            enties.MODIFY;
                        END;
                        UNTIL enties.NEXT = 0;
                    END;

                    // Approval for the 1st Approval
                    IF Rec."Priority Level" = Rec."Priority Level"::"1st Level" THEN BEGIN
                        //
                        enties.RESET;
                        // enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
                        enties.SETRANGE(enties.Department, Rec.Department);
                        enties.SETRANGE(enties."Student ID", Rec."Student ID");
                        enties.SETFILTER(enties.Status, '=%1', enties.Status::Created);
                        //enties.SETFILTER(enties."Priority Level",'=%1',enties."Priority Level"::Normal);
                        IF enties.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                enties."Last Date Modified" := TODAY;
                                enties."Last Time Modified" := TIME;
                                enties.Status := enties.Status::Open;
                                enties.MODIFY;
                            END;
                            UNTIL enties.NEXT = 0;
                        END;
                    END ELSE
                        IF Rec."Priority Level" = Rec."Priority Level"::Normal THEN BEGIN
                            //Search where Final Level and set to open
                            enties.RESET;
                            //enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
                            enties.SETRANGE(enties.Department, Rec.Department);
                            enties.SETRANGE(enties."Student ID", Rec."Student ID");
                            enties.SETFILTER(enties.Status, '=%1', enties.Status::Open);
                            enties.SETFILTER(enties."Priority Level", '=%1', enties."Priority Level"::Normal);
                            IF NOT enties.FIND('-') THEN BEGIN
                                // If All other Clearances are done, Open the final Clearance
                                /////////////////////////////////////////////////////////////
                                //enties.SETRANGE(enties."Clearance Level Code","Clearance Level Code");
                                enties.RESET;
                                enties.SETRANGE(enties.Department, Rec.Department);
                                enties.SETRANGE(enties."Student ID", Rec."Student ID");
                                enties.SETFILTER(enties.Status, '=%1', enties.Status::Created);
                                enties.SETFILTER(enties."Priority Level", '=%1', enties."Priority Level"::"Final level");
                                IF enties.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        enties."Last Date Modified" := TODAY;
                                        enties."Last Time Modified" := TIME;
                                        enties.Status := enties.Status::Open;
                                        enties.MODIFY;
                                    END;
                                    UNTIL enties.NEXT = 0;
                                END;

                                /////////////////////////////////////////////////////////////
                            END;
                        END ELSE
                            IF Rec."Priority Level" = Rec."Priority Level"::"Final level" THEN BEGIN
                                // Change status of the clearance of the student card
                                IF cust.GET(Rec."Student ID") THEN BEGIN
                                    cust."Clearance Status" := cust."Clearance Status"::Cleared;
                                    cust.MODIFY;
                                END;
                            END;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec.SETFILTER("Clear By ID", USERID);
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Clear By ID", USERID);
    end;

    var
        enties: Record "ACA-Clearance Approval Entries";
        counted: Integer;
        stringval: Code[1024];
        conditions: Record "ACA-Clearance Conditions list";
        cust: Record Customer;
}

