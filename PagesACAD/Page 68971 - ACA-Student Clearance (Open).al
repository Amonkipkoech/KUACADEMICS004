page 68971 "ACA-Student Clearance (Open)"
{
    Caption = 'Student Clearance (Open)';
    CardPageID = "ACA-Clearance View Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Type" = CONST(Student),
                            "Clearance Status" = FILTER(= open));

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Clearance Semester"; Rec."Clearance Semester")
                {
                    ApplicationArea = All;
                }
                field("Clearance Academic Year"; Rec."Clearance Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Programme End Date"; Rec."Programme End Date")
                {
                    ApplicationArea = All;
                }
                field("Intake Code"; Rec."Intake Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Student';
                action(initiateClearance)
                {
                    Caption = 'Initiate Clearance';
                    Image = "Action";
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ClearLevela: Record "ACA-Clearance Level Codes";
                        ClearTemplates: Record "ACA-Clearance templates";
                        ClearDepTemplates: Record "ACA-Clearance Dept. Approvers";
                        ClearStandardApp: Record "ACA-Clearance Std Approvers";
                        cust: Record Customer;
                        ClearEntries: Record "ACA-Clearance Approval Entries";
                    begin
                        sems.RESET;
                        sems.SETRANGE(sems."Current Semester", TRUE);
                        IF sems.FIND('-') THEN
                            IF NOT (sems.Code = '') THEN
                                Rec."Clearance Semester" := sems.Code;
                        acadYear.RESET;
                        acadYear.SETRANGE(acadYear.Current, TRUE);
                        IF acadYear.FIND('-') THEN
                            IF NOT (acadYear.Code = '') THEN
                                Rec."Clearance Academic Year" := acadYear.Code;
                        Rec."Clearance Reason" := Rec."Clearance Reason"::Graduation;
                        Rec.MODIFY;
                        Rec.CALCFIELDS("Balance (LCY)");
                        // CALCFIELDS("Refund on PV");
                        IF (Rec."Balance (LCY)" > 0) THEN ERROR('The student''s balance must be zero (0).\The Balance is ' + FORMAT(Rec."Balance (LCY)"));
                        IF NOT (CONFIRM('Initiate student clearance for ' + Rec."No." + ': ' + Rec.Name, FALSE) = TRUE) THEN ERROR('Cancelled!');
                        //TESTFIELD("Clearance Reason");
                        //TESTFIELD("Global Dimension 2 Code");
                        //TESTFIELD("Clearance Semester");
                        //TESTFIELD("Clearance Academic Year");
                        Rec.TESTFIELD("Current Programme");
                        //TESTFIELD("Programme End Date");
                        //TESTFIELD("Intake Code");
                        deptemp.RESET;
                        //deptemp.SETRANGE(deptemp."Clearance Level Code",'001');
                        deptemp.SETRANGE(deptemp.Department, Rec."Global Dimension 2 Code");
                        IF NOT (deptemp.FIND('-')) THEN ERROR('Departmental approver for ''' + Rec."Global Dimension 2 Code" + ''' missing');
                        ClearLevela.RESET;
                        ClearLevela.SETRANGE(ClearLevela.Status, ClearLevela.Status::Active);
                        ClearLevela.SETFILTER(ClearLevela."Priority Level", '=%1', ClearLevela."Priority Level"::"1st Level");
                        IF NOT (ClearLevela.FIND('-')) THEN ERROR('1st Approval Level is missing!');

                        ClearLevela.RESET;
                        ClearLevela.SETRANGE(ClearLevela.Status, ClearLevela.Status::Active);
                        ClearLevela.SETFILTER(ClearLevela."Priority Level", '=%1', ClearLevela."Priority Level"::"Final level");
                        IF NOT (ClearLevela.FIND('-')) THEN ERROR('Final Approval Level is missing!');



                        ClearLevela.RESET;
                        ClearLevela.SETRANGE(ClearLevela.Status, ClearLevela.Status::Active);
                        IF ClearLevela.FIND('-') THEN BEGIN //5
                            REPEAT
                            BEGIN  //4
                                IF (ClearLevela.Standard) THEN BEGIN  //3
                                                                      // Pick from the standard Approvals and insert into the Entries table
                                    ClearStandardApp.RESET;
                                    ClearStandardApp.SETRANGE(ClearStandardApp."Clearance Level Code", ClearLevela."Clearance Level Code");
                                    ClearStandardApp.SETFILTER(ClearStandardApp.Active, '=%1', TRUE);
                                    IF ClearStandardApp.FIND('-') THEN BEGIN //2
                                        REPEAT  // Rep1
                                        BEGIN //1
                                            ClearEntries.INIT;
                                            ClearEntries."Clearance Level Code" := ClearStandardApp."Clearance Level Code";
                                            ClearEntries.Department := Rec."Global Dimension 2 Code";
                                            ClearEntries."Student ID" := Rec."No.";
                                            ClearEntries."Clear By ID" := ClearStandardApp."Clear By Id";
                                            ClearEntries."Initiated By" := USERID;
                                            ClearEntries."Initiated Date" := TODAY;
                                            ClearEntries."Initiated Time" := TIME;
                                            ClearEntries."Last Date Modified" := TODAY;
                                            ClearEntries."Last Time Modified" := TIME;
                                            ClearEntries.Cleared := FALSE;
                                            ClearEntries."Priority Level" := ClearLevela."Priority Level";
                                            ClearEntries."Academic Year" := Rec."Clearance Academic Year";
                                            ClearEntries.Semester := Rec."Clearance Semester";
                                            IF ClearLevela."Priority Level" = ClearLevela."Priority Level"::"1st Level" THEN
                                                ClearEntries.Status := ClearEntries.Status::Open
                                            ELSE
                                                ClearEntries.Status := ClearEntries.Status::Created;
                                            ClearEntries.INSERT;
                                        END; //1
                                        UNTIL ClearStandardApp.NEXT = 0; //  Rep1
                                    END ELSE
                                        ERROR('Setup for Clearance Templates not found;');  // 2
                                END ELSE BEGIN    //3
                                                  // Check templates for the related Clearance Approvals
                                    ClearTemplates.RESET;
                                    ClearTemplates.SETRANGE(ClearTemplates."Clearance Level Code", ClearLevela."Clearance Level Code");
                                    ClearTemplates.SETRANGE(ClearTemplates.Department, Rec."Global Dimension 2 Code");
                                    ClearTemplates.SETFILTER(ClearTemplates.Active, '=%1', TRUE);
                                    IF ClearTemplates.FIND('-') THEN BEGIN  //6
                                        ClearDepTemplates.RESET;
                                        ClearDepTemplates.SETRANGE(ClearDepTemplates."Clearance Level Code", ClearLevela."Clearance Level Code");
                                        ClearDepTemplates.SETRANGE(ClearDepTemplates.Department, Rec."Global Dimension 2 Code");
                                        ClearDepTemplates.SETFILTER(ClearDepTemplates.Active, '=%1', TRUE);
                                        IF ClearDepTemplates.FIND('-') THEN BEGIN//7
                                            REPEAT
                                            BEGIN
                                                ClearEntries.INIT;
                                                ClearEntries."Clearance Level Code" := ClearDepTemplates."Clearance Level Code";
                                                ClearEntries.Department := Rec."Global Dimension 2 Code";
                                                ClearEntries."Student ID" := Rec."No.";
                                                ClearEntries."Clear By ID" := ClearDepTemplates."Clear By Id";
                                                ClearEntries."Initiated By" := USERID;
                                                ClearEntries."Initiated Date" := TODAY;
                                                ClearEntries."Initiated Time" := TIME;
                                                ClearEntries."Last Date Modified" := TODAY;
                                                ClearEntries."Last Time Modified" := TIME;
                                                ClearEntries.Cleared := FALSE;
                                                ClearEntries."Priority Level" := ClearLevela."Priority Level";
                                                ClearEntries."Academic Year" := Rec."Clearance Academic Year";
                                                ClearEntries.Semester := Rec."Clearance Semester";
                                                IF ClearLevela."Priority Level" = ClearLevela."Priority Level"::"1st Level" THEN
                                                    ClearEntries.Status := ClearEntries.Status::Open
                                                ELSE
                                                    ClearEntries.Status := ClearEntries.Status::Created;
                                                ClearEntries.INSERT;
                                            END;
                                            UNTIL ClearDepTemplates.NEXT = 0;
                                        END;//7
                                    END //6
                                END;   //3
                            END;  //4
                            UNTIL ClearLevela.NEXT = 0;
                        END ELSE
                            ERROR('No Clearance levels specified.');  //5
                        MESSAGE('Clearance Initiated successfully.');
                        Rec."Clearance Status" := Rec."Clearance Status"::Active;
                        Rec.MODIFY;
                    end;
                }
                action(printForm)
                {
                    Caption = 'Print Clearance Form';
                    Image = PrintVoucher;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec."Clearance Status" = Rec."Clearance Status"::open THEN ERROR('Initiate the clearance process before printing the clearance form');
                        stud.RESET;
                        stud.SETRANGE(stud."No.", Rec."No.");
                        IF stud.FIND('+') THEN
                            REPORT.RUN(39006140, TRUE, FALSE, stud);
                    end;
                }
                action(stdId)
                {
                    Caption = 'Student ID Card';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        stud.RESET;
                        stud.SETRANGE(stud."No.", Rec."No.");
                        IF stud.FIND('+') THEN
                            REPORT.RUN(39006250, TRUE, FALSE, stud);
                        // ERROR('Yap');
                    end;
                }
            }
        }
        area(processing)
        {
            action(MarkAsAllumni)
            {
                Caption = 'Mark As Alluminae';
                Image = Status;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to mark this students as an alluminae?', TRUE) = TRUE THEN BEGIN
                        Rec.Status := Rec.Status::Alluminae;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }

    var
        stud: Record Customer;
        sems: Record "ACA-Semesters";
        acadYear: Record "ACA-Academic Year";
        deptemp: Record "ACA-Clearance templates";
}

