report 51279 "HTL Customer - List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/HTL Customer - List.rdl';
    Caption = 'Customer - List';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = WHERE("Customer Posting Group" = CONST('KSM HOTEL'));
            RequestFilterFields = "No.", "Search Name";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            } */
            column(USERID; USERID)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer__Customer_Posting_Group_; "Customer Posting Group")
            {
            }
            column(Customer__Customer_Disc__Group_; "Customer Disc. Group")
            {
            }
            column(Customer__Invoice_Disc__Code_; "Invoice Disc. Code")
            {
            }
            column(Customer__Customer_Price_Group_; "Customer Price Group")
            {
            }
            column(Customer__Fin__Charge_Terms_Code_; "Fin. Charge Terms Code")
            {
            }
            column(Customer__Payment_Terms_Code_; "Payment Terms Code")
            {
            }
            column(Customer__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Customer__Currency_Code_; "Currency Code")
            {
            }
            column(Customer__Credit_Limit__LCY__; "Credit Limit (LCY)")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Customer__Balance__LCY__; "Balance (LCY)")
            {
            }
            column(CustAddr_1_; CustAddr[1])
            {
            }
            column(CustAddr_2_; CustAddr[2])
            {
            }
            column(CustAddr_3_; CustAddr[3])
            {
            }
            column(CustAddr_4_; CustAddr[4])
            {
            }
            column(CustAddr_5_; CustAddr[5])
            {
            }
            column(Customer_Contact; Contact)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(CustAddr_6_; CustAddr[6])
            {
            }
            column(CustAddr_7_; CustAddr[7])
            {
            }
            column(Customer__Balance__LCY___Control42; "Balance (LCY)")
            {
            }
            column(Customer___ListCaption; Customer___ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer__Customer_Posting_Group_Caption; Customer__Customer_Posting_Group_CaptionLbl)
            {
            }
            column(Customer__Customer_Disc__Group_Caption; Customer__Customer_Disc__Group_CaptionLbl)
            {
            }
            column(Customer__Invoice_Disc__Code_Caption; Customer__Invoice_Disc__Code_CaptionLbl)
            {
            }
            column(Customer__Customer_Price_Group_Caption; Customer__Customer_Price_Group_CaptionLbl)
            {
            }
            column(Customer__Fin__Charge_Terms_Code_Caption; FIELDCAPTION("Fin. Charge Terms Code"))
            {
            }
            column(Customer__Payment_Terms_Code_Caption; Customer__Payment_Terms_Code_CaptionLbl)
            {
            }
            column(Customer__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
            {
            }
            column(Customer__Currency_Code_Caption; Customer__Currency_Code_CaptionLbl)
            {
            }
            column(Customer__Credit_Limit__LCY__Caption; FIELDCAPTION("Credit Limit (LCY)"))
            {
            }
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(Customer_ContactCaption; FIELDCAPTION(Contact))
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Balance (LCY)");
                FormatAddr.FormatAddr(
                  CustAddr, Name, "Name 2", '', Address, "Address 2",
                  City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnPreDataItem()
            begin
#pragma warning disable AL0667
                CurrReport.CREATETOTALS("Balance (LCY)");
#pragma warning restore AL0667
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

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
    end;

    var
        CustFilter: Text[250];
        CustAddr: array[8] of Text[50];
        FormatAddr: Codeunit 365;
        Customer___ListCaptionLbl: Label 'Customer - List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer__Customer_Posting_Group_CaptionLbl: Label 'Customer Posting Group';
        Customer__Customer_Disc__Group_CaptionLbl: Label 'Cust./Item Disc. Gr.';
        Customer__Invoice_Disc__Code_CaptionLbl: Label 'Invoice Disc. Code';
        Customer__Customer_Price_Group_CaptionLbl: Label 'Price Group Code';
        Customer__Payment_Terms_Code_CaptionLbl: Label 'Payment Terms Code';
        Customer__Currency_Code_CaptionLbl: Label 'Currency Code';
        Total__LCY_CaptionLbl: Label 'Total (LCY)';
}

