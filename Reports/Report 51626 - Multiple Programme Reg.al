report 51626 "Multiple Programme Reg"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Multiple Programme Reg.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Customer Type" = CONST(Student));
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
            column(Multiple_Programme_RegistrationCaption; Multiple_Programme_RegistrationCaptionLbl)
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
                Multiple := FALSE;

                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", Customer."No.");
                IF CourseReg.FIND('-') THEN BEGIN
                    ProgCode := CourseReg.Programmes;
                    REPEAT
                        IF ProgCode <> CourseReg.Programmes THEN
                            Multiple := TRUE;
                    UNTIL CourseReg.NEXT = 0;
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

    var
        CourseReg: Record 61532;
        ProgCode: Code[20];
        Multiple: Boolean;
        Multiple_Programme_RegistrationCaptionLbl: Label 'Multiple Programme Registration';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

