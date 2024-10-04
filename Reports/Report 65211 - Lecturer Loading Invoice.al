report 65211 "Lecturer Loading Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Lecturer Loading Invoice.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 122)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Buy-from Vendor No.", "No.";
            column(Companyname; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompAddress1; CompanyInformation."Address 2")
            {
            }
            column(CompPhonenO; CompanyInformation."Phone No.")
            {
            }
            column(CompPhoneNo2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompPic; CompanyInformation.Picture)
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompHome; CompanyInformation."Home Page")
            {
            }
            column(InvNo; "No.")
            {
            }
            column(ShipCustNo; "Buy-from Vendor No.")
            {
            }
            column(ShipBill2No; "Pay-to Vendor No.")
            {
            }
            column(ShipBill2Name; "Pay-to Name")
            {
            }
            column(YourRef; "Your Reference")
            {
            }
            column(PostinDate; "Posting Date")
            {
            }
            column(PostingDes; "Posting Description")
            {
            }
            column(OrderNo; "Vendor Invoice No.")
            {
            }
            column(UserId1; "User ID")
            {
            }
            column(OrderRoute; '')
            {
            }
            column(route; '')
            {
            }
            column(PhoneNo; vendor."Phone No.")
            {
            }
            column(PrevBalance; vendor.Balance)
            {
            }
            column(BalAfterInvoice; vendor.Balance)
            {
            }
            column(invNo2; PurchaseInvoiceHeader."No.")
            {
            }
            column(invAmount; PurchaseInvoiceHeader.Amount)
            {
            }
            column(salesPerson; '')
            {
            }
            column(LocCode; '')
            {
            }
            dataitem(DataItem1000000001; 123)
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(seq; seq)
                {
                }
                column(LineNo; "Line No.")
                {
                }
                column(ItemType; Type)
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(ItemDesc; Description)
                {
                }
                column(UnitOdMeasure; MILKOrderCustProdSource."Unit Cost")
                {
                }
                column(ItemQty; Quantity)
                {
                }
                column(unitPrice; "Direct Unit Cost")
                {
                }
                column(amnt; "Direct Unit Cost")
                {
                }


                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                    IF Item.GET("No.") THEN BEGIN
                    END;


                    MILKOrderBatchLines.RESET;
                    MILKOrderBatchLines.SETRANGE(MILKOrderBatchLines."PV No.", "No.");
                    IF MILKOrderBatchLines.FIND('-') THEN BEGIN
                        MILKOrderCustProdSource.RESET;
                        MILKOrderCustProdSource.SETRANGE(MILKOrderCustProdSource.Semester, MILKOrderBatchLines."Semester Code");
                        MILKOrderCustProdSource.SETRANGE(MILKOrderCustProdSource.Lecturer, "Buy-from Vendor No.");
                        // MILKOrderCustProdSource.SETRANGE(MILKOrderCustProdSource.Stage,"Sales Invoice Line"."No.");
                        IF MILKOrderCustProdSource.FIND('-') THEN BEGIN
                        END;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(seq);
                vendor.RESET;
                vendor.SETRANGE(vendor."No.", "Buy-from Vendor No.");


                PurchaseInvoiceHeader.RESET;
                PurchaseInvoiceHeader.SETRANGE(PurchaseInvoiceHeader."No.", "No.");
                IF PurchaseInvoiceHeader.FIND('-') THEN BEGIN
                    PurchaseInvoiceHeader.CALCFIELDS(PurchaseInvoiceHeader.Amount);
                END;
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
        IF CompanyInformation.GET() THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        CompanyInformation: Record 79;
        seq: Integer;
        vendor: Record 23;
        PurchaseInvoiceHeader: Record 122;
        Item: Record 27;
        MILKOrderBatchLines: Record 65201;
        MILKOrderCustProdSource: Record 65202;
}

