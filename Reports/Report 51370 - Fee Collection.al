/// <summary>
/// Report Fee Collection (ID 51370).
/// </summary>
report 51370 "Fee Collection"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fee Collection.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            //RequestFilterFields = "Posting Date";
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Descending)
                                WHERE("Credit Amount" = FILTER(<> 0),
                                      "Customer Posting Group" = CONST('STUDENT'),
                                      "Bal. Account Type" = CONST("Bank Account"));
            RequestFilterFields = "Customer No.", Description, "Settlement Type", "Date Filter", "Credit Amount (LCY)", "Posting Date";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(info_picture; info.Picture)
            {
            }
            column(info_name; info.Name)
            {
            }
            column(info_mail; info."E-Mail")
            {
            }
            column(info_tel; info."Phone No.")
            {
            }
            column(info_addres; info.Address)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Cust__Ledger_Entry__Document_Type_; "Document Type")
            {
            }
            column(Cust__Ledger_Entry__Document_No___Control1102760020; "Document No.")
            {
            }
            column(Cust__Ledger_Entry_Description; Description)
            {
            }
            column(Sname; Sname)
            {
            }
            column(Cust__Ledger_Entry__Credit_Amount__LCY__; "Cust. Ledger Entry"."Credit Amount")
            {
            }
            column(Cust__Ledger_Entry_Amount; Amount)
            {
            }
            column(TotalFor___FIELDCAPTION__Document_No___; TotalFor + FIELDCAPTION("Document No."))
            {
            }
            column(Totals; Totals)
            {
            }
            column(Fee_Collection_ReportCaption; Fee_Collection_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Cust__Ledger_Entry__Document_Type_Caption; FIELDCAPTION("Document Type"))
            {
            }
            column(Cust__Ledger_Entry__Document_No___Control1102760020Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Amount_PaidCaption; Amount_PaidCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Seq; Seq)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Totals := Totals + "Cust. Ledger Entry"."Credit Amount";
                Cust.RESET;

                Sname := '';
                Cust.SETRANGE(Cust."No.", "Cust. Ledger Entry"."Customer No.");
                IF Cust.FIND('-') THEN BEGIN
                    Sname := Cust.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        IF info.GET() THEN
            //Settlement_Type := compInf."Last Settlement Type";
        info.CALCFIELDS(info.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Totals: Decimal;
        Sname: Text[150];
        Cust: Record 18;
        info: Record "Company Information";
        Fee_Collection_ReportCaptionLbl: Label 'Fee Collection Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Amount_PaidCaptionLbl: Label 'Amount Paid';
        NameCaptionLbl: Label 'Name';
        Seq: Integer;
}

