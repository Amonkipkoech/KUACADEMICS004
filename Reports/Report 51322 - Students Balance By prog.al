report 51322 "Students Balance By prog"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Balance By prog.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Customer Type" = CONST(Student),
                                      "New Stud" = CONST(false));
            RequestFilterFields = "Student Programme", "No.";
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
            column(Progname; Progname)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Debit_Amount_; "Debit Amount")
            {
            }
            column(Customer__Credit_Amount_; "Credit Amount")
            {
            }
            column(Customer__Student_Balance_; Balance)
            {
            }
            column(Num; Num)
            {
            }
            column(Customer__Student_Balance__Control1102760000; Balance)
            {
            }
            column(Customer__Credit_Amount__Control1102760007; "Credit Amount")
            {
            }
            column(Customer__Debit_Amount__Control1102760008; "Debit Amount")
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
            column(Customer__Debit_Amount_Caption; FIELDCAPTION("Debit Amount"))
            {
            }
            column(Customer__Credit_Amount_Caption; FIELDCAPTION("Credit Amount"))
            {
            }
            column(Customer__Student_Balance_Caption; FIELDCAPTION(Balance))
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(Customer_Current_Programme; "Current Programme")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                  Prog.RESET;
                 Prog.SETFILTER(Prog.Code,Customer.GETFILTER(Customer."Student Programme"));
                 IF Prog.FIND('-') THEN
                 Progname:=Prog.Description;


                 Customer."New Stud":=true;
                 Customer.modify;
                 */
                Num := Num + 1;

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Current Programme");
                Progname := Customer.GETFILTER(Customer."Student Programme");
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
        /*
        cust.reset;
        cust.setfilter(Cust."Customer Type",'%1',Cust."Customer Type"::student);
       // cust.setfilter(Cust."Student Programme",'%1',Customer.getfilter(Customer."Programme Filter"));
        if cust.find('-') then begin
        repeat
        Cust."Current Programme":=Cust."Student Programme";
        cust.modify;
        until cust.next=0;
        end;
       */

    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Cust: Record 18;
        Prog: Record 61511;
        Progname: Code[100];
        Num: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmptyStringCaptionLbl: Label '#';
        TotalsCaptionLbl: Label 'Totals';
}

