page 69033 "ACA-Stds Transfer"
{
    PageType = Document;
    SourceTable = "ACA-Students Transfer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("New Programme"; Rec."New Programme")
                {
                    ApplicationArea = All;
                }
                field("New Student No"; Rec."New Student No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
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
            action(Post)
            {
                Image = Save;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
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
                            Cust.Password := Rec."New Student No";
                            Cust."Changed Password" := TRUE;
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

                end;
            }
        }
    }

    var
        Cust: Record Customer;
        Cust2: Record Customer;
        GenJnl: Record "Gen. Journal Line";
        Receipts: Record "ACA-Receipt";
        CustL: Record "Cust. Ledger Entry";
        Creg: Record "ACA-Course Registration";
        Creg2: Record "ACA-Course Registration";
}

