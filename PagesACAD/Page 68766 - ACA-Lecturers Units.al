page 68766 "ACA-Lecturers Units"
{
    PageType = Document;
    SourceTable = "HRM-Employee (D)";
    SourceTableView = WHERE(Lecturer = FILTER(true));

    layout
    {
        area(content)
        {
            group(Genera)
            {
                Caption = 'Genera';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'Employee No.';
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
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = All;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field("Part Time"; Rec."Part Time")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Units/Subjects")
            {
                Caption = 'Units/Subjects';
                part("Lecturer Units"; "ACA-Lecturers Units/Subjects")
                {
                    SubPageLink = Lecturer = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Lecturer)
            {
                Caption = 'Lecturer';
                action("Units Lecture can take")
                {
                    Caption = 'Units Lecture can take';
                    RunObject = Page "ACA-Units Lecture can take";
                    RunPageLink = Lecturer = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(____)
                {
                }
                action("Lecturer Appointment Letter")
                {
                    Caption = 'Lecturer Appointment Letter';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LecUnits.RESET;
                        LecUnits.SETFILTER(LecUnits.Lecturer, Rec."No.");
                        IF LecUnits.FIND('-') THEN
                            REPORT.RUN(39005734, TRUE, TRUE, LecUnits);
                    end;
                }
                separator(___)
                {
                }
                action("Create Payable Account")
                {
                    Image = Accounts;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT Vend.GET(Rec."No.") THEN BEGIN
                            Vend.INIT;
                            Vend."No." := Rec."No.";
                            Vend.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                            Vend."Search Name" := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                            Vend."Vendor Posting Group" := 'Lecturer';
                            Vend."Gen. Bus. Posting Group" := 'Local';
                            Vend."VAT Bus. Posting Group" := 'Local';
                            Vend.INSERT;
                            MESSAGE('Vendor Account No ' + Rec."No." + ' has been created successfully');
                        END ELSE BEGIN
                            ERROR('Vendor Account No ' + Rec."No." + ' already exists');
                        END;
                    end;
                }
                separator(_____________________)
                {
                }
                action("Post Lecturer Invoice")
                {
                    Image = Invoice;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Do you really want to post the lecturer invoice', FALSE) = TRUE THEN BEGIN
                            GeneralSetup.GET;
                            LecUnits.RESET;
                            LecUnits.SETRANGE(LecUnits.Lecturer, Rec."No.");
                            LecUnits.SETRANGE(LecUnits.Posted, FALSE);
                            LecUnits.SETRANGE(LecUnits."Claim to pay", TRUE);
                            IF LecUnits.FIND('-') THEN BEGIN
                                REPEAT
                                    IF LecUnits."Claimed Amount" > 0 THEN BEGIN
                                        gnLine.INIT;
                                        gnLine."Journal Template Name" := 'General';
                                        gnLine."Journal Batch Name" := 'Lecturer';
                                        gnLine."Line No." := gnLine."Line No." + 100;
                                        gnLine."Account Type" := gnLine."Account Type"::Vendor;
                                        gnLine."Account No." := Rec."No.";
                                        gnLine."Posting Date" := TODAY;
                                        gnLine."Document No." := Rec."No." + '/' + LecUnits.Unit;
                                        gnLine.Description := COPYSTR(LecUnits.Semester + '/' + LecUnits.Unit + '/' + LecUnits.Description, 1, 50);
                                        gnLine."Bal. Account Type" := gnLine."Bal. Account Type"::"G/L Account";
                                        gnLine."Bal. Account No." := '70310';//GeneralSetup."Lecturers Expense Account";
                                        gnLine.Amount := LecUnits."Claimed Amount" * -1;
                                        gnLine.INSERT;
                                    END;
                                UNTIL LecUnits.NEXT = 0;
                            END;
                            gnLine.RESET;
                            gnLine.SETRANGE(gnLine."Journal Template Name", 'General');
                            gnLine.SETRANGE(gnLine."Journal Batch Name", 'Lecturer');
                            IF gnLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", gnLine);
                            END;
                            LecUnits.RESET;
                            LecUnits.SETRANGE(LecUnits.Lecturer, Rec."No.");
                            LecUnits.SETRANGE(LecUnits.Posted, FALSE);
                            LecUnits.SETRANGE(LecUnits."Claim to pay", TRUE);
                            IF LecUnits.FIND('-') THEN BEGIN
                                REPEAT
                                    LecUnits.Posted := TRUE;
                                    LecUnits."Posted By" := USERID;
                                    LecUnits."Posted On" := TODAY;
                                    LecUnits.MODIFY;
                                UNTIL LecUnits.NEXT = 0;
                            END;
                            MESSAGE('Invoice posted successfully');
                        END;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Lecturer := TRUE;
        // IF Rec."No." = '' THEN BEGIN
        //     IF HumanResSetup.GET THEN;
        //     // HumanResSetup.TESTFIELD("PT. No.");
        //     Rec."No." := NoSeriesMgt.GetNextNo(HumanResSetup."PT. No.", TODAY, TRUE);
        // END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Lecturer := TRUE;

        /* IF Rec."No." = '' THEN BEGIN
            IF HumanResSetup.GET THEN;
            // HumanResSetup.TESTFIELD("PT. No.");
            Rec."No." := NoSeriesMgt.GetNextNo(HumanResSetup."PT. No.", TODAY, TRUE);
        END; */
        /*
        IF "No." <> xRec."No." THEN BEGIN
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("Employee Nos.");
          NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
          "No. Series" := '';
        END;*/

    end;

    var
        //KPAObjectives: Record "HRM-KPA Objectives (B)";
        KPACode: Code[20];
        LecUnits: Record "ACA-Lecturers Units";
        Vend: Record Vendor;
        gnLine: Record "Gen. Journal Line";
        GeneralSetup: Record "ACA-General Set-Up";
        GL: Record "G/L Entry";
        //HumanResSetup: Record "HRM-Human Resources Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

