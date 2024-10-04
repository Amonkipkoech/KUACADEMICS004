/// <summary>
/// Report Post 0.01 (ID 51701).
/// </summary>
report 51701 "Post 0.01"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Post 0.01.rdl';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Customer Type";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            dataitem(DataItem8503; 21)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                //DataItemTableView = WHERE(Open = CONST(Yes));
                column(Cust__Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Remaining Amt. (LCY)" > 0 THEN
                        OpenD := TRUE
                    ELSE
                        OpenC := TRUE
                end;

                trigger OnPostDataItem()
                begin
                    IF (OpenD = TRUE) AND (OpenC = TRUE) THEN BEGIN
                        LNo := LNo + 10000;

                        GenJnl.INIT;
                        GenJnl."Line No." := LNo;
                        GenJnl."Posting Date" := TODAY;
                        GenJnl."Document No." := '';
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'RND';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        GenJnl."Account No." := "Customer No.";
                        GenJnl.Amount := 0.01;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        GenJnl.Description := 'Rounding Adj';
                        GenJnl.INSERT;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                OpenD := FALSE;
                OpenC := FALSE;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('ha');
                /*
                IF (OpenD=TRUE) AND (OpenC=TRUE) THEN BEGIN
                LNo:=LNo+10000;
                
                GenJnl.INIT;
                GenJnl."Line No." := LNo;
                GenJnl."Posting Date":=TODAY;
                GenJnl."Document No.":='';
                GenJnl.VALIDATE(GenJnl."Document No.");
                GenJnl."Journal Template Name":='SALES';
                GenJnl."Journal Batch Name":='RND';
                GenJnl."Account Type":=GenJnl."Account Type"::Customer;
                GenJnl."Account No.":="No.";
                GenJnl.Amount:=0.01;
                GenJnl.VALIDATE(GenJnl."Account No.");
                GenJnl.VALIDATE(GenJnl.Amount);
                GenJnl.Description:='Rounding Adj';
                GenJnl.INSERT;
                END;
                */

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

    var
        OpenD: Boolean;
        OpenC: Boolean;
        GenJnl: Record 81;
        LNo: Integer;
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

