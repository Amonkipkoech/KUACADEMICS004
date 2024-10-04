/// <summary>
/// Report Account Modification (ID 51732).
/// </summary>
report 51732 "Account Modification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Account Modification.rdl';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            RequestFilterFields = "No.";
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

            trigger OnAfterGetRecord()
            begin
                DCustL.RESET;
                DCustL.SETRANGE(DCustL."Customer No.", OldNo);
                IF DCustL.FIND('-') THEN BEGIN
                    DCustL."Customer No." := NewNo;
                    DCustL.MODIFY;
                END;

                CustL.RESET;
                CustL.SETRANGE(CustL."Customer No.", OldNo);
                IF CustL.FIND('-') THEN BEGIN
                    CustL."Customer No." := NewNo;
                    CustL.MODIFY;
                END;

                "CourseReg.".RESET;
                "CourseReg.".SETRANGE("CourseReg."."Student No.", OldNo);
                IF "CourseReg.".FIND('-') THEN BEGIN
                    "CourseReg."."Student No." := NewNo;
                    "CourseReg."."Reg. Transacton ID" := "CourseReg."."Reg. Transacton ID";
                    "CourseReg.".MODIFY;
                END;

                /*
                StudCharges.RESET;
                StudCharges.SETRANGE(StudCharges."Student No.",OldNo);
                IF StudCharges.FIND('-') THEN BEGIN
                StudCharges."Student No.":=NewNo;
                StudCharges.MODIFY;
                END;
                */
                Receipt.RESET;
                Receipt.SETRANGE(Receipt."Student No.", OldNo);
                IF Receipt.FIND('-') THEN BEGIN
                    Receipt."Student No." := NewNo;
                    Receipt.MODIFY;
                END;
                /*
                StudUnits.RESET;
                StudUnits.SETRANGE(StudUnits."Student No.",OldNo);
                IF StudUnits.FIND('-') THEN BEGIN
                StudUnits."Student No.":=NewNo;
                StudUnits.MODIFY;
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
        "CourseReg.": Record 61532;
        CustL: Record 21;
        DCustL: Record 379;
        StudCharges: Record 61535;
        Receipt: Record 61538;
        StudUnits: Record 61549;
        OldNo: Code[20];
        NewNo: Code[20];
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

