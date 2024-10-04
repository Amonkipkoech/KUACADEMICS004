report 51586 "Generate Accomodation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Generate Accomodation.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Balance (LCY)" = FILTER(-2900 | -2100 | -3400));
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
            column(Customer__Balance__LCY__; "Balance (LCY)")
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
            column(Customer__Balance__LCY__Caption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            dataitem(DataItem2901; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No.");
                DataItemTableView = WHERE("System Created" = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    EVALUATE(PDate, '01/09/08');
                    StudentCharges.INIT;
                    StudentCharges.Programme := Programmes;
                    StudentCharges.Stage := Stage;
                    StudentCharges.Semester := Semester;
                    StudentCharges."Student No." := "Student No.";
                    StudentCharges."Reg. Transacton ID" := "Reg. Transacton ID";
                    StudentCharges."Transaction Type" := StudentCharges."Transaction Type"::"Stage Fees";
                    StudentCharges.Date := PDate;
                    StudentCharges.Description := 'Accomodation Fee';
                    IF Customer."Balance (LCY)" = -3400 THEN BEGIN
                        StudentCharges.Code := 'ACC1';
                        StudentCharges.Amount := 3400;
                    END ELSE
                        IF Customer."Balance (LCY)" = -2100 THEN BEGIN
                            StudentCharges.Code := 'ACC3';
                            StudentCharges.Amount := 2100;
                        END ELSE BEGIN
                            StudentCharges.Code := 'ACC2';
                            StudentCharges.Amount := 2900;
                        END;

                    StudentCharges."Recovered First" := FALSE;
                    StudentCharges."Recovery Priority" := 12;
                    StudentCharges."System Created" := TRUE;
                    StudentCharges.Charge := TRUE;
                    StudentCharges."Transacton ID" := '';
                    StudentCharges.VALIDATE(StudentCharges."Transacton ID");
                    StudentCharges.INSERT;
                end;
            }
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
        StudentCharges: Record 61535;
        PDate: Date;
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

