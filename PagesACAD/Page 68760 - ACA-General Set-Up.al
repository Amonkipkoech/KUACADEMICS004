page 68760 "ACA-General Set-Up"
{

    PageType = Card;
    SourceTable = "ACA-General Set-Up";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Student Nos."; Rec."Student Nos.")
                {
                    ApplicationArea = All;
                }
                field("Registration Nos."; Rec."Registration Nos.")
                {
                    ApplicationArea = All;
                }

                field("% of Accomodation"; Rec."% of Accomodation")
                {
                    ApplicationArea = All;
                }
                field("% of Billed Fees/Balance"; Rec."% of Billed Fees/Balance")
                {
                    ApplicationArea = All;
                }
                field("Receipt Nos."; Rec."Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Gown Issuance"; Rec."Class Allocation Nos.")
                {
                    Caption = 'Gown Issuance';
                    ApplicationArea = All;
                }
                field("Clinical request"; rec."Clinical request")
                {
                    Caption = 'Clinical request';
                    ApplicationArea = All;
                }
                field("Defered Account"; Rec."Defered Account")
                {
                    ApplicationArea = All;
                }
                field("Over Payment Account"; Rec."Over Payment Account")
                {
                    ApplicationArea = All;
                }
                field("Transaction Nos."; Rec."Transaction Nos.")
                {
                    ApplicationArea = All;
                }
                field("Pre-Payment Account"; Rec."Pre-Payment Account")
                {
                    ApplicationArea = All;
                }
                field("Cons. Marksheet Key2"; Rec."Cons. Marksheet Key2")
                {
                    ApplicationArea = All;
                }
                field("Bill Supplimentary Fee"; Rec."Bill Supplimentary Fee")
                {
                    ApplicationArea = All;
                }
                field("Supplimentary Fee Code"; Rec."Supplimentary Fee Code")
                {
                    ApplicationArea = All;
                }
                field("Unallocated Rcpts Account"; Rec."Unallocated Rcpts Account")
                {
                    ApplicationArea = All;
                }
                field("Further Info Nos"; Rec."Further Info Nos")
                {
                    ApplicationArea = All;
                }
                field("Medical Condition Nos"; Rec."Medical Condition Nos")
                {
                    ApplicationArea = All;
                }
                field("Attachment Nos"; Rec."Attachment Nos")
                {
                    ApplicationArea = All;
                }
                field("Enquiry Nos"; Rec."Enquiry Nos")
                {
                    ApplicationArea = All;
                }
                field("Application Fee"; Rec."Application Fee")
                {
                    ApplicationArea = All;
                }
                field("Master Rotation Nos"; Rec."Clearance Nos")
                {
                    Caption = 'Master Rotation Nos';
                    ApplicationArea = All;
                }
                field("Proforma Nos"; Rec."Proforma Nos")
                {
                    ApplicationArea = All;
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                    ApplicationArea = All;
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                    ApplicationArea = All;
                }
                field("Applications Date Line"; Rec."Applications Date Line")
                {
                    ApplicationArea = All;
                }
                field("Default Year"; Rec."Default Year")
                {
                    ApplicationArea = All;
                }
                field("Default Semester"; Rec."Default Semester")
                {
                    ApplicationArea = All;
                }
                field("Default Intake"; Rec."Default Intake")
                {
                    ApplicationArea = All;
                }
                field("Default Academic Year"; Rec."Default Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Allow UnPaid Hostel Booking"; Rec."Allow UnPaid Hostel Booking")
                {
                    ApplicationArea = All;
                }
                field("Cons. Marksheet Key1"; Rec."Cons. Marksheet Key1")
                {
                    ApplicationArea = All;
                }
                field("Allowed Reg. Fees Perc."; Rec."Allowed Reg. Fees Perc.")
                {
                    ApplicationArea = All;
                }
                field("Allow Online Results Access"; Rec."Allow Online Results Access")
                {
                    ApplicationArea = All;
                }
                field("Base Date"; Rec."Base Date")
                {
                    ApplicationArea = All;
                }
                field("Helb Account"; Rec."Helb Account")
                {
                    ApplicationArea = All;
                }
                field("CDF Account"; Rec."CDF Account")
                {
                    ApplicationArea = All;
                }
                field("Hostel Incidents"; Rec."Hostel Incidents")
                {
                    ApplicationArea = All;
                }
                field("Supplimentary Code"; Rec."Supplimentary Code")
                {
                    ApplicationArea = All;
                }
                field("Supplimentary Fee"; Rec."Supplimentary Fee")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Code"; Rec."Special Exam Code")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Fee"; Rec."Special Exam Fee")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Nos."; Rec."Scholarship Nos.")
                {
                    ToolTip = 'Specifies the value of the Scholarship Nos. field.';
                    ApplicationArea = All;
                }
                field("Receipt Buffer Nos"; Rec."Receipt Buffer Nos")
                {
                    ApplicationArea = All;
                }
                field("Deferral Nos."; Rec."Deferral Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deferral Nos. field.';
                }
                field("Student Clearance Request"; rec."Student Clearance Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deferral Nos. field.';
                }
                field("Release Proforma Invoice"; Rec."Release Proforma Invoice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Release Proforma Invoice';
                }
                field("Supplimentary No.";"Supplimentary No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Release Proforma Invoice';
                }

            }
            group("ID Setup")
            {
                Caption = 'ID Setup';
                field(Picture; Rec.Picture)
                {
                    Caption = 'Signature';
                    ApplicationArea = All;
                }
                field("Student Portal Message"; Rec."Student Portal Message")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(eval)
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    CReg.RESET;
                    CReg.SETRANGE(CReg."System Created",TRUE);
                    IF CReg.FIND('-') THEN
                    CReg.DELETEALL;
                    */
                    EVALUATE(PDate, '01/09/08');

                    SCharges.RESET;
                    SCharges.SETFILTER(SCharges.Stage, 'Y1S2..Y4S2');
                    SCharges.SETRANGE(SCharges.Recognized, FALSE);
                    IF SCharges.FIND('-') THEN
                        SCharges.MODIFYALL(SCharges.Date, PDate);
                    //SCharges.MODIFYALL(SCharges.Recognized,FALSE);

                end;
            }
            action("Temp Del")
            {
                Enabled = false;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    //  CReg.DELETEALL;
                    // Cust.DELETEALL;
                    //SCharges.DELETEALL;
                    //StudUnit.DELETEALL;
                    //Prog.DELETEALL;
                    //Units.DELETEALL;

                    // Cust.DELETEALL;
                    GLEntry.DELETEALL;
                    CustEntry.DELETEALL;
                    CustDet.DELETEALL;
                    BankL.DELETEALL;
                    vendL.DELETEALL;
                    vedDetailed.DELETEALL;


                    /*
                    ProgStage.DELETEALL;
                    //ProgSem.DELETEALL;
                    //Prog.SETRANGE(Prog."School Code",'003');
                    IF Prog.FIND('-') THEN BEGIN
                    REPEAT
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y1S1';
                    ProgStage.Description:='Year 1 Semester1';
                    ProgStage.Remarks:='Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y1S2';
                    ProgStage.Description:='Year 1 Semester2';
                    ProgStage.Remarks:='Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y2S1';
                    ProgStage.Description:='Year 2 Semester1';
                    ProgStage.Remarks:='Pass, Proceed to Third Year';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y2S2';
                    ProgStage.Description:='Year 2 Semester2';
                    ProgStage.Remarks:='Pass, Proceed to Third Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y3S1';
                    ProgStage.Description:='Year 3 Semester1';
                    ProgStage.Remarks:='Pass, Proceed to Forth Year';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y3S2';
                    ProgStage.Description:='Year 3 Semester2';
                    ProgStage.Remarks:='Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y4S1';
                    ProgStage.Description:='Year 4 Semester1';
                    ProgStage.Remarks:='Pass ';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y4S2';
                    ProgStage.Description:='Year 4 Semester2';
                    ProgStage.Remarks:='Pass ';
                    ProgStage.INSERT;
                    
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem1 09/10';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 09/10';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 10/11';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 10/11';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 11/12';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 11/12';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 12/13';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 12/13';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 13/14';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 13/14';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 14/15';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem2 14/15';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 08/09';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem2 08/09';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 08/09';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 09/10';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 10/11';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 11/12';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 12/13';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 13/14';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 15/16';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem2 15/16';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 15/16';
                    ProgSem.INSERT;
                    
                    UNTIL Prog.NEXT=0;
                    END;
                    
                    
                    JabBuff.RESET;
                    IF JabBuff.FIND('-') THEN BEGIN
                    REPEAT
                    JabBuff.Processed:=FALSE;
                    JabBuff.MODIFY;
                    UNTIL JabBuff.NEXT=0;
                    END;
                    */
                    //Admissions.DELETEALL;
                    //}
                    MESSAGE('Done');

                end;
            }
            action("Update Units")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    CReg.RESET;
                    CReg.SETRANGE(CReg.Semester,'SEM2-2014/2015');
                    IF CReg.FIND('-') THEN BEGIN
                    REPEAT
                    CReg.VALIDATE(CReg."Registration Date");
                    UNTIL
                    CReg.NEXT=0;
                    END;
                    */
                    StudUnit.RESET;
                    IF StudUnit.FIND('-') THEN BEGIN
                        REPEAT
                            StudUnit.Taken := TRUE;
                            StudUnit.MODIFY;
                        UNTIL StudUnit.NEXT = 0;
                    END;
                    MESSAGE('Done');

                end;
            }
            /* action(UPD)
            {

                trigger OnAction()
                begin
                    HMSP.DELETEALL;
                    MESSAGE('Done');
                end;
            } */
            action("Process Raw Marks")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RawMarks.RESET;
                    RawMarks.SETRANGE(RawMarks.Posted, FALSE);
                    IF RawMarks.FIND('-') THEN BEGIN
                        REPEAT
                            IF NOT Cust.GET(RawMarks."Reg No") THEN BEGIN
                                Cust.INIT;
                                Cust."No." := RawMarks."Reg No";
                                Cust.Name := RawMarks.Name;
                                Cust."Customer Type" := Cust."Customer Type"::Student;
                                Cust."Customer Posting Group" := 'Customer';
                                Cust."Gen. Bus. Posting Group" := 'LOCAL';
                                Cust.INSERT;
                            END;
                            CReg.RESET;
                            CReg.SETRANGE(CReg."Student No.", RawMarks."Reg No");
                            CReg.SETRANGE(CReg.Programmes, RawMarks.Prog);
                            CReg.SETRANGE(CReg.Stage, RawMarks.Stage);
                            CReg.SETRANGE(CReg.Semester, RawMarks.Semester);
                            IF NOT CReg.FIND('-') THEN BEGIN
                                CReg.INIT;
                                CReg."Reg. Transacton ID" := 'RG-0001';
                                CReg."Student No." := RawMarks."Reg No";
                                CReg.Programmes := RawMarks.Prog;
                                CReg.Stage := RawMarks.Stage;
                                CReg."Intake Code" := RawMarks.Intake;
                                CReg.Session := RawMarks.Session;
                                CReg.Semester := RawMarks.Semester + ' ' + RawMarks."Academic year";
                                CReg."Settlement Type" := RawMarks."Stud Type";
                                CReg."Registration Date" := TODAY;
                                CReg."Academic Year" := RawMarks."Academic year";
                                CReg.INSERT;
                            END;

                            FOR i := 1 TO 8 DO BEGIN
                                RawMarks1.RESET;
                                RawMarks1.SETRANGE(RawMarks1."Entry No", RawMarks."Entry No");
                                IF RawMarks1.FIND('-') THEN BEGIN
                                    Units.RESET;
                                    Units.SETRANGE(Units."Programme Code", RawMarks1.Prog);
                                    Units.SETRANGE(Units."Stage Code", RawMarks1.Stage);
                                    Units.SETRANGE(Units."Reserved Room", FORMAT(i));
                                    IF Units.FIND('-') THEN BEGIN
                                        StudUnit.RESET;
                                        StudUnit.SETRANGE(StudUnit."Student No.", RawMarks1."Reg No");
                                        StudUnit.SETRANGE(StudUnit.Unit, Units.Code);
                                        IF NOT StudUnit.FIND('-') THEN BEGIN
                                            StudUnit.INIT;
                                            StudUnit.Programme := RawMarks1.Prog;
                                            StudUnit.Stage := RawMarks1.Stage;
                                            StudUnit.Unit := Units.Code;
                                            StudUnit.Semester := RawMarks.Semester + ' ' + RawMarks."Academic year";
                                            StudUnit."Reg. Transacton ID" := 'RG-0001';
                                            StudUnit."Student No." := RawMarks1."Reg No";
                                            StudUnit."No. Of Units" := RawMarks1.Unit;
                                            StudUnit.Taken := TRUE;
                                            StudUnit.INSERT;
                                        END;
                                        ExResults.RESET;
                                        ExResults.SETRANGE(ExResults."Student No.", RawMarks1."Reg No");
                                        ExResults.SETRANGE(ExResults.Unit, Units.Code);
                                        IF NOT ExResults.FIND('-') THEN BEGIN
                                            ExResults.INIT;
                                            ExResults."Student No." := RawMarks1."Reg No";
                                            ExResults.Programmes := RawMarks1.Prog;
                                            ExResults.Stage := RawMarks1.Stage;
                                            ExResults.Unit := Units.Code;
                                            ExResults.Semester := RawMarks.Semester + ' ' + RawMarks."Academic year";
                                            ExResults.ExamType := 'EXAM';
                                            ExResults."Reg. Transaction ID" := 'RG-0001';
                                            ExResults.Exam := 'EXAM';
                                            IF i = 1 THEN BEGIN
                                                ExResults.Score := RawMarks1.U1;
                                                ExResults.Contribution := RawMarks1.U1;
                                            END;
                                            IF i = 2 THEN BEGIN
                                                ExResults.Score := RawMarks1.U2;
                                                ExResults.Contribution := RawMarks1.U2;
                                            END;
                                            IF i = 3 THEN BEGIN
                                                ExResults.Score := RawMarks1.U3;
                                                ExResults.Contribution := RawMarks1.U3;
                                            END;
                                            IF i = 4 THEN BEGIN
                                                ExResults.Score := RawMarks1.U4;
                                                ExResults.Contribution := RawMarks1.U4;
                                            END;
                                            IF i = 5 THEN BEGIN
                                                ExResults.Score := RawMarks1.U5;
                                                ExResults.Contribution := RawMarks1.U5;
                                            END;
                                            IF i = 6 THEN BEGIN
                                                ExResults.Score := RawMarks1.U6;
                                                ExResults.Contribution := RawMarks1.U6;
                                            END;
                                            IF i = 7 THEN BEGIN
                                                ExResults.Score := RawMarks1.U7;
                                                ExResults.Contribution := RawMarks1.U7;
                                            END;
                                            IF i = 8 THEN BEGIN
                                                ExResults.Score := RawMarks1.U8;
                                                ExResults.Contribution := RawMarks1.U8;
                                            END;
                                            ExResults.INSERT;
                                        END;
                                    END;
                                END;

                            END;

                        UNTIL RawMarks.NEXT = 0;
                    END;
                    MESSAGE('Done');
                end;
            }
        }
    }

    var
        CReg: Record "ACA-Course Registration";
        SCharges: Record "ACA-Std Charges";
        PDate: Date;
        StudUnit: Record "ACA-Student Units";
        Prog: Record "ACA-Programme";
        Units: Record "ACA-Units/Subjects";
        ProgStage: Record "ACA-Programme Stages";
        Cust: Record Customer;
        GLEntry: Record "G/L Entry";
        CustEntry: Record "Cust. Ledger Entry";
        CustDet: Record "Detailed Cust. Ledg. Entry";
        ProgSem: Record "ACA-Programme Semesters";
        JabBuff: Record "ACA-Raw KUCCPS Imports";
        //HMSP: Record 61402;
        RawMarks: Record "ACA-Raw Marks";
        RawMarks1: Record "ACA-Raw Marks";
        i: Integer;
        ExResults: Record "ACA-Exam Results";
        Admissions: Record "ACA-Adm. Form Header";
        BankL: Record "Bank Account Ledger Entry";
        vendL: Record "Vendor Ledger Entry";
        vedDetailed: Record "Detailed Vendor Ledg. Entry";
}

