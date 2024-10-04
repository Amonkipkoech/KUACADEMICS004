page 61613 "ACA-Students Transfer Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ACA-Students Transfer";

    layout
    {
        area(content)
        {
            group(general)
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Wide;
            }
            field("Student No"; Rec."Student No")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Name; Rec.Name)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Current Programme"; Rec."Current Programme")
            {
                ApplicationArea = All;
            }
            field("New Student No"; Rec."New Student No")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("New Programme"; Rec."New Programme")
            {
                ApplicationArea = All;
            }
            field(Date; Rec.Date)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(UserId; Rec.UserId)
            {
                ApplicationArea = All;
            }
            field(Posted; Rec.Posted)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
            field("Agregate Points"; Rec."Agregate Points")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Responsibility Centre"; Rec."Responsibility Centre")
            {
                ApplicationArea = All;
            }
            field("Reason for Transfer"; Rec."Reason for Transfer")
            {
                ApplicationArea = All;
            }
            field("HOD Comments"; Rec."HOD Comments")
            {
                ApplicationArea = All;
            }
            field("DOS Present School"; Rec."DOS Present School")
            {
                ApplicationArea = All;
            }
            field("DOS Receiving School"; Rec."DOS Receiving School")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("KSCE Grades")
            {
                Image = Production;
                Promoted = true;
                RunObject = Page 61614;
                RunPageLink = "Student No" = FIELD("Student No");
                ApplicationArea = All;
            }
            action(ResultSlip)
            {
                Image = UserCertificate;
                Promoted = true;
                PromotedCategory = New;
                ApplicationArea = All;
                //RunObject = Page 130501;
                //RunPageLink = "Student No" = FIELD("Student No");
            }
            action("Send Approval")
            {
                Image = BookingsLogo;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit 439;
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    tableNo: Integer;
                    Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Farmer Application",Vehicle_Reg,"Sales Returns","Transfer Order",Payroll,"Casual Payroll","School Transfer";
                begin
                    Rec.Status := Rec.Status::Open;
                    IF Rec.Status <> Rec.Status::Open THEN State := State::"Pending Approval";
                    Doc_Type := Doc_Type::"School Transfer";
                    CLEAR(tableNo);
                    tableNo := DATABASE::"ACA-Students Transfer";
                    //IF ApprovalMgt.SendApproval(tableNo, Rec."Student No", Doc_Type, State, Rec."Responsibility Centre", 0) THEN;
                    // IF ApprovalMgt.SendSchTranRequest(tableNo,Rec."Student No")THEN;
                end;
            }
            action("Generate Admission")
            {
                Image = GetActionMessages;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Approved THEN BEGIN
                        ERROR('The request is not approved');
                    END;
                    IF CONFIRM('Generate admission no ?', TRUE) = FALSE THEN ERROR('Cancelled by User');
                    AdminSetup.RESET;
                    AdminSetup.SETRANGE(AdminSetup.Degree, Rec."New Programme");
                    IF AdminSetup.FIND('-') THEN BEGIN
                        Rec."New Student No" := NoSeriesMgt.GetNextNo(AdminSetup."No. Series", 0D, TRUE);
                        Rec."New Student No" := AdminSetup."Programme Prefix" + '-' + Rec."New Student No" + '/' + AdminSetup.Year;
                    END
                    ELSE BEGIN
                        ERROR('The Admission Number Setup For Programme ' + FORMAT(Rec."New Programme") + ' Does Not Exist');
                    END;
                end;
            }
            action("Post Transfer")
            {
                Enabled = false;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Approved THEN BEGIN
                        ERROR('Can only post an approved document');
                    END;
                    IF CONFIRM('POST Transfer?', TRUE) = FALSE THEN ERROR('Cancelled by User');

                    Rec.TESTFIELD(Posted, FALSE);
                    Rec.TESTFIELD("New Student No");
                    Rec.TESTFIELD("New Programme");
                    IF Cust2.GET(Rec."Student No") THEN BEGIN
                        Cust2.CALCFIELDS("Balance (LCY)");

                        IF NOT Cust.GET(Rec."New Student No") THEN BEGIN
                            Cust.INIT;
                            Cust."No." := Rec."New Student No";
                            Cust.Name := Cust2.Name;
                            Cust.VALIDATE(Cust.Name);
                            Cust."Global Dimension 1 Code" := Cust2."Global Dimension 1 Code";
                            Cust."Customer Posting Group" := Cust2."Customer Posting Group";
                            Cust."Application Method" := Cust."Application Method"::"Apply to Oldest";
                            Cust.Status := Cust.Status::Current;
                            Cust."Customer Type" := Cust."Customer Type"::Student;
                            Cust."Date Registered" := Cust2."Date Registered";
                            Cust.INSERT(TRUE);
                        END;

                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        GenJnl.DELETEALL;

                        CustL.RESET;
                        CustL.SETRANGE(CustL."Customer No.", Cust2."No.");
                        IF CustL.FIND('-') THEN BEGIN
                            REPEAT
                                CustL.CALCFIELDS(CustL.Amount);
                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := CustL."Posting Date";
                                GenJnl."Document No." := CustL."Document No.";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                                GenJnl."Account No." := Cust2."No.";
                                GenJnl.Amount := CustL.Amount * -1;
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := CustL.Description;
                                //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                                //GenJnl."Bal. Account No.":="Transfer to No.";
                                GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                /*
                                CReg.RESET;
                                CReg.SETRANGE(CReg."Student No.","No.");
                                IF CReg.FIND('+') THEN BEGIN
                                */
                                IF GenJnl.Amount <> 0 THEN
                                    GenJnl.INSERT;


                                GenJnl.INIT;
                                GenJnl."Line No." := GenJnl."Line No." + 10000;
                                GenJnl."Posting Date" := CustL."Posting Date";
                                GenJnl."Document No." := CustL."Document No.";
                                GenJnl.VALIDATE(GenJnl."Document No.");
                                GenJnl."Journal Template Name" := 'SALES';
                                GenJnl."Journal Batch Name" := 'STUD PAY';
                                GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                                GenJnl."Account No." := Rec."New Student No";
                                GenJnl.Amount := CustL.Amount;
                                GenJnl.VALIDATE(GenJnl."Account No.");
                                GenJnl.VALIDATE(GenJnl.Amount);
                                GenJnl.Description := CustL.Description;
                                //GenJnl."Bal. Account Type":=GenJnl."Bal. Account Type"::Customer;
                                //GenJnl."Bal. Account No.":="Transfer to No.";
                                //GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                                //GenJnl."Shortcut Dimension 2 Code":="Transfer to";
                                //GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                                IF GenJnl.Amount <> 0 THEN
                                    GenJnl.INSERT;

                            UNTIL CustL.NEXT = 0;
                        END;

                        Receipts.RESET;
                        Receipts.SETRANGE(Receipts."Student No.", Cust2."No.");
                        Receipts.SETRANGE(Receipts.Reversed, FALSE);
                        IF Receipts.FIND('-') THEN BEGIN
                            REPEAT
                                Receipts."Student No." := Rec."New Student No";
                                Receipts.MODIFY;
                            UNTIL Receipts.NEXT = 0;
                        END;



                        //Post
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnl);
                        END;
                        Creg2.RESET;
                        Creg2.SETRANGE(Creg2."Student No.", Cust2."No.");
                        IF Creg2.FIND('+') THEN BEGIN
                            Creg.INIT;
                            Creg."Student No." := Rec."New Student No";
                            Creg.Programmes := Rec."New Programme";
                            Creg.Semester := Creg2.Semester;
                            Creg.Stage := Creg2.Stage;
                            Creg."Settlement Type" := Creg2."Settlement Type";
                            Creg."Registration Date" := Creg2."Registration Date";
                            Creg.Posted := TRUE;
                            Creg."User ID" := Rec.UserId;
                            Creg.Session := Creg2.Session;
                            Creg.INSERT;
                        END;
                        Cust2.Status := Cust2.Status::Transferred;
                        Cust2.Blocked := Cust2.Blocked::All;
                        Cust2.MODIFY;

                        Rec.Posted := TRUE;
                        Rec.UserId := Rec.UserId;
                        Rec.MODIFY;
                    END;

                    MESSAGE('%1', 'Student transferred successfully.');
                    Rec.Status := Rec.Status::Posted;

                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                RunObject = page "Fin-Approval Entries";
                RunPageLink = "Document No." = field("Student No");
            }
        }
    }

    var
        //UserMgt: Codeunit 50114;
        ApprovalMgt: Codeunit 439;
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","School Transfer";
        respCenter: Code[10];
        //Commitment: Codeunit 50111;
        //BCSetup: Record 61721;
        // DeleteCommitment: Record "61722";
        //Loc: Record "14";
        Cust: Record Customer;
        AdminSetup: Record "ACA-Adm. Number Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //currCourse: Record "61532";
        Cust2: Record Customer;
        GenJnl: Record "Gen. Journal Line";
        Receipts: Record "ACA-Receipt";
        CustL: Record "Cust. Ledger Entry";
        Creg: Record "ACA-Course Registration";
        Creg2: Record "ACA-Course Registration";
        AppE: Record "Approval Entry";
}

