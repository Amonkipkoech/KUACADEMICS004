/// <summary>
/// Report Student Receipts per Charge (ID 51748).
/// </summary>
report 51748 "Student Receipts per Charge"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Receipts per Charge.rdl';

    dataset
    {
        dataitem("ACA-Charge"; "ACA-Charge")
        {
            column(Charge_code; Code)
            {
            }
            column(Charge_Desc; Description)
            {
            }
            column(GenDate; TODAY)
            {
            }
            column(Date_Filter; "Date Filter")
            {
            }
            column(pict; CompanyInfo.Picture)
            {
            }


            dataitem("Dimension Value"; "Dimension Value")
            {
                DataItemTableView = WHERE("Dimension Code" = FILTER(1));
                PrintOnlyIfDetail = true;
                column(deptCode; Code)
                {
                }
                column(deptName; Name)
                {
                }
                dataitem("ACA-Programme"; "ACA-Programme")
                {
                    DataItemLink = "Department Code" = FIELD(Code);
                    PrintOnlyIfDetail = true;
                    column(ProgCode; Code)
                    {
                    }
                    column(ProgDesc; Description)
                    {
                    }
                    dataitem("ACA-Course Registration"; "ACA-Course Registration")
                    {
                        DataItemLink = Programmes = FIELD(Code);
                        PrintOnlyIfDetail = true;
                        column(studNo; "Student No.")
                        {
                        }
                        column(StudName; "Student Name")
                        {
                        }
                        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                        {
                            DataItemLink = "Customer No." = FIELD("Student No.");
                            // DataItemTableView = WHERE(Reversed=FILTER(No));
                            PrintOnlyIfDetail = true;
                            column(entryNo; "Cust. Ledger Entry"."Entry No.")
                            {
                            }
                            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                            {
                                DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                                DataItemTableView = WHERE("Entry Type" = FILTER(Application));
                                column(Amnt; ("Cust. Ledger Entry"."Original Amt. (LCY)" - "Cust. Ledger Entry"."Remaining Amt. (LCY)"))
                                {
                                }
                                column(DocNo; "Document No.")
                                {
                                }
                                column(postDate; "Posting Date")
                                {
                                }

                                trigger OnAfterGetRecord()
                                begin
                                    // CurrReport.SHOWOUTPUT(COPYSTR("Document No.",1,3)='RCT')
                                    IF (COPYSTR("Document No.", 1, 3) <> 'RCT') THEN CurrReport.SKIP;
                                end;

                                trigger OnPreDataItem()
                                begin
                                    SETFILTER("Posting Date", '%1..%2');
                                end;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Original Amt. (LCY)", "Cust. Ledger Entry"."Remaining Amt. (LCY)");



                                IF "Cust. Ledger Entry"."Original Amt. (LCY)" = "Cust. Ledger Entry"."Remaining Amt. (LCY)" THEN
                                    CurrReport.SKIP
                            end;

                            trigger OnPreDataItem()
                            begin
                                // "Cust. Ledger Entry".reset;
                                "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry".Description, "ACA-Charge".Description);
                                // if "Cust. Ledger Entry".find('')
                                IF datefil <> '' THEN
                                    "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."Date Filter", '%1..%2', startDate, endDate);
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            SETFILTER(Semester, '=%1', sems);
                        end;
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(startDate; startDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                }
                field(EndDate; endDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = All;
                }
                field(sems; sems)
                {
                    Caption = 'Semester';
                    TableRelation = "ACA-Semesters".Code;
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

    trigger OnInitReport()
    begin
        IF compInf.GET() THEN BEGIN
            IF compInf."Last Used date Filter (Inv. 1)" <> 0D THEN startDate := compInf."Last Used date Filter (Inv. 1)";
            IF compInf."Last Used date Filter (Inv. 2)" <> 0D THEN endDate := compInf."Last Used date Filter (Inv. 2)";
            IF compInf."Last Semester Filter" <> '' THEN sems := compInf."Last Semester Filter";
        END;
    end;

    trigger OnPostReport()
    begin
        IF compInf.GET() THEN BEGIN
            IF startDate <> 0D THEN compInf."Last Used date Filter (Inv. 1)" := startDate;
            IF endDate <> 0D THEN compInf."Last Used date Filter (Inv. 2)" := endDate;
            IF sems <> '' THEN compInf."Last Semester Filter" := sems;
            compInf.MODIFY;
        END;
    end;

    trigger OnPreReport()
    begin
        IF ((startDate = 0D) AND (endDate = 0D)) THEN ERROR('Specify the start and/or end date');
        CLEAR(datefil);
        IF ((startDate = 0D) AND (endDate <> 0D)) THEN
            datefil := '..' + FORMAT(endDate)
        ELSE
            IF ((startDate <> 0D) AND (endDate = 0D)) THEN
                datefil := FORMAT(startDate) + '..'
            ELSE
                IF ((startDate <> 0D) AND (endDate <> 0D)) THEN datefil := FORMAT(startDate) + '..' + FORMAT(endDate);

        IF (sems = '') THEN ERROR('Specify the semester.');
        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        header1: Text;
        startDate: Date;
        endDate: Date;
        datefil: Text[120];
        compInf: Record 79;
        CompanyInfo: Record 79;
        acadyear: Code[30];
        sems: Code[30];
        transNo: Code[10];
        detcust: Record 379;
}

