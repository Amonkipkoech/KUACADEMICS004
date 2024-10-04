report 51769 "Remove Billings & Receipts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Remove Billings & Receipts.rdl';

    dataset
    {
        dataitem(DataItem1; 18)
        {
            DataItemTableView = WHERE("Customer Type" = FILTER(Student));

            trigger OnAfterGetRecord()
            begin
                // Remove Customer Ledger Entries
                /*
                 custLedgerEntry.RESET;
                custLedgerEntry.SETRANGE(custLedgerEntry."Journal Batch Name",'REP');

                //custLedgerEntry.SETRANGE(custLedgerEntry."Customer No.",Customer."No.");

                //custLedgerEntry.setfilter(custLedgerEntry."Posting Date",'>%1',063014);
                IF custLedgerEntry.FIND('-') THEN BEGIN
               // message('Cust entries '+format(custLedgerEntry.COUNT));
                 custLedgerEntry.DELETEALL;
                END;

               // Remove Detailed Customer Ledger Entry
               DetailedcustLedgerEntry.RESET;
               DetailedcustLedgerEntry.SETRANGE(DetailedcustLedgerEntry."Journal Batch Name",'REP');
               //DetailedcustLedgerEntry.SETRANGE(DetailedcustLedgerEntry."Customer No.",Customer."No.");

               //DetailedcustLedgerEntry.setfilter(DetailedcustLedgerEntry."Posting Date",'>%1','06/30/14');
               IF DetailedcustLedgerEntry.FIND('-') THEN BEGIN
               //message('Cust entries '+format(DetailedcustLedgerEntry.COUNT));
               DetailedcustLedgerEntry.DELETEALL;
               END;
                */


                // Remove G/L Ledger Entries
                GlLedgerEntry.RESET;
                GlLedgerEntry.SETRANGE(GlLedgerEntry."Journal Batch Name", 'CRED');
                //GlLedgerEntry.SETRANGE(GlLedgerEntry."Bal. Account No.",Customer."No.");
                //GlLedgerEntry.setfilter(GlLedgerEntry."Posting Date",'>%1','06/30/14');
                IF GlLedgerEntry.FIND('-') THEN BEGIN
                    //message('Cust entries '+format(GlLedgerEntry.COUNT));
                    GlLedgerEntry.DELETEALL;
                END;

                vendledger.RESET;
                vendledger.SETRANGE(vendledger."Journal Batch Name", 'CRED');
                IF vendledger.FIND('-') THEN BEGIN
                    vendledger.DELETEALL;
                END;

                Detailedvend.RESET;
                Detailedvend.SETRANGE(Detailedvend."Journal Batch Name", 'CRED');
                IF Detailedvend.FIND('-') THEN BEGIN
                    Detailedvend.DELETEALL;
                END;

                /*
                // Remove Bank Ledger Entries
                BankLedgerEntry.RESET;
                BankLedgerEntry.SETRANGE(BankLedgerEntry."Journal Batch Name",'CRED');
                //BankLedgerEntry.SETRANGE(BankLedgerEntry."Bal. Account No.",Customer."No.");
                //BankLedgerEntry.setfilter(BankLedgerEntry."Posting Date",'>%1','06/30/14');
                IF BankLedgerEntry.FIND('-') THEN BEGIN
                //message('Cust entries '+format(BankLedgerEntry.COUNT));
                 BankLedgerEntry.DELETEALL;
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
        custLedgerEntry: Record 21;
        DetailedcustLedgerEntry: Record 379;
        BankLedgerEntry: Record 271;
        GlLedgerEntry: Record 17;
        vendledger: Record 25;
        Detailedvend: Record 380;
}

