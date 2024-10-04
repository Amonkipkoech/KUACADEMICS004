report 51566 "Post Billing2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = "Student No.", Semester, Stage, Programmes;
            column(USERID; USERID)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bill_StudentsCaption; Bill_StudentsCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer.FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; Customer.FIELDCAPTION(Name))
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = FIELD("Student No.");
                DataItemTableView = SORTING("No.")
                                    WHERE(Blocked = FILTER(' '));
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //Billing
                    GenJnl.RESET;
                    GenJnl.SETRANGE("Journal Template Name", 'SALES');
                    GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                    GenJnl.DELETEALL;



                    GenSetUp.GET();

                    IF Charges.GET(ChargeCode) THEN BEGIN
                        GenJnl.INIT;
                        GenJnl."Line No." := GenJnl."Line No." + 10000;
                        GenJnl."Posting Date" := PDate;
                        GenJnl."Document No." := DocNo;
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        //
                        IF Cust.GET("No.") THEN BEGIN
                            IF Cust."Bill-to Customer No." <> '' THEN
                                GenJnl."Account No." := Cust."Bill-to Customer No."
                            ELSE
                                GenJnl."Account No." := "No.";
                        END;

                        GenJnl.Amount := ChargeAmount;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := Charges.Description;
                        GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                        GenJnl."Bal. Account No." := Charges."G/L Account";


                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");
                        GenJnl."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");

                        GenJnl."Shortcut Dimension 2 Code" := Prog."Department Code";
                        GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                        GenJnl."Due Date" := DueDate;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        IF StudentCharges."Recovery Priority" <> 0 THEN
                            GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                        ELSE
                            GenJnl."Recovery Priority" := 25;
                        IF GenJnl.Amount <> 0 THEN
                            GenJnl.INSERT;

                        //Post New
                        GenJnl.RESET;
                        GenJnl.SETRANGE("Journal Template Name", 'SALES');
                        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
                        IF GenJnl.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B", GenJnl);
                        END;

                        //Post New


                    END;


                    //BILLING
                end;
            }

            trigger OnPreDataItem()
            begin
                IF ChargeCode = '' THEN ERROR('Please select the Charge Code');
                IF ChargeAmount = 0 THEN ERROR('Please enter the Charge Amount');
                IF PDate = 0D THEN ERROR('Please enter the Charge Date');
                IF DocNo = '' THEN ERROR('Please enter the Document No');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ChargeCode; ChargeCode)
                {
                    Caption = 'Charge Code';
                    DrillDownPageID = "ACA-Charge";
                    LookupPageID = "ACA-Charge";
                    TableRelation = "ACA-Charge".Code;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Charges.GET(ChargeCode) THEN
                            ChargeAmount := Charges.Amount;
                    end;
                }
                field(ChargeAmount; ChargeAmount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field(PDate; PDate)
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
                field(DocNo; DocNo)
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        StudentPayments: Record 61536;
        StudentCharges: Record 61535;
        GenJnl: Record 81;

        ExamsByUnit: Record 61527;
        Charges: Record 61515;
        Receipt: Record 61538;
        ReceiptItems: Record 61539;
        GenSetUp: Record 61534;

        PDate: Date;
        DocNo: Code[20];
        VendLedg: Record 25;
        DVendLedg: Record 380;
        VATEntry: Record 254;
        CReg: Record 61532;
        StudCharges: Record 61535;
        CustLed2: Record 21;
        Receipt2: Record 61538;
        Cont: Boolean;
        Cust: Record 18;
        CustLedg: Record 21;
        DueDate: Date;
        Sems: Record 61692;
        "Settlement Type": Record 61522;
        Prog: Record 61511;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bill_StudentsCaptionLbl: Label 'Bill Students';
        StudHost: Record 61155;
        ChargeCode: Code[20];
        ChargeAmount: Decimal;
}

