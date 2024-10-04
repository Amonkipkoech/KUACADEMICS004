report 77122 "Student Fee Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Fee Statement.rdl';

    dataset
    {
        dataitem(DataItem1000000000; 18)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(StudNo; Customer."No.")
            {
            }
            column(StudName; Customer.Name)
            {
            }
            column(Balance; Customer.Balance)
            {
            }
            column(campus; Customer."Global Dimension 1 Code")
            {
            }
            column(ProgName; Progs.Description)
            {
            }
            column(Progs; ACACourseRegistration.Programmes)
            {
            }
            column(Semesters; ACACourseRegistration.Semester)
            {
            }
            column(Stages; ACACourseRegistration.Stage)
            {
            }
            column(Settlement; ACACourseRegistration."Settlement Type")
            {
            }
            column(AcadYear; ACACourseRegistration."Academic Year")
            {
            }
            column(compName; CompanyInformation.Name)
            {
            }
            column(address; CompanyInformation.Address + ',' + CompanyInformation."Address 2")
            {
            }
            column(phones; CompanyInformation."Phone No." + '/' + CompanyInformation."Phone No. 2")
            {
            }
            column(pics; CompanyInformation.Picture)
            {
            }
            column(mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            dataitem(DataItem1000000001; 379)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = WHERE("Entry Type" = FILTER('Initial Entry'));
                column(pDate; CustLedgerEntry."Posting Date")
                {
                }
                column(DocNo; CustLedgerEntry."Document No.")
                {
                }
                column(Desc; CustLedgerEntry.Description)
                {
                }
                column(Amount; ledg.Amount)
                {
                }
                column(DebitAm; ledg."Debit Amount")
                {
                }
                column(CreditAm; ledg."Credit Amount")
                {
                }
                column(runningBal; runningBal)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //runningBal:=runningBal+ledg."Debit Amount"-ledg."Credit Amount";
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Entry No.", ledg."Cust. Ledger Entry No.");
                    IF CustLedgerEntry.FIND('-') THEN BEGIN

                    END;
                    runningBal := runningBal + ledg.Amount;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(runningBal);
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETRANGE(ACACourseRegistration."Student No.", Customer."No.");
                ACACourseRegistration.SETFILTER(ACACourseRegistration.Programmes, '<>%1', '');
                ACACourseRegistration.SETFILTER(ACACourseRegistration.Reversed, '=%1', FALSE);
                ACACourseRegistration.SETFILTER(ACACourseRegistration.Transfered, '=%1', FALSE);
                IF ACACourseRegistration.FIND('+') THEN BEGIN
                    Progs.RESET;
                    Progs.SETRANGE(Code, ACACourseRegistration.Programmes);
                    IF Progs.FIND('-') THEN BEGIN
                    END;
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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        customer: Record 18;
        runningBal: Decimal;
        ACACourseRegistration: Record 61532;
        Progs: Record 61511;
        CustLedgerEntry: Record 21;
        CompanyInformation: Record 79;
        ledg: Record "Detailed Cust. Ledg. Entry";
}

