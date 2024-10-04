report 51718 "Random Four Digit Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Random Four Digit Code.rdl';

    dataset
    {
        dataitem(DataItem6836; 18)
        {
            RequestFilterFields = "No.";
            column(Customer__No__; "No.")
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }

            trigger OnAfterGetRecord()
            begin
                smsCode := FORMAT(RANDOM(9999));

                IF STRLEN(smsCode) = 1 THEN
                    smsCode := '000' + smsCode
                ELSE
                    IF STRLEN(smsCode) = 2 THEN
                        smsCode := '00' + smsCode
                    ELSE
                        IF STRLEN(smsCode) = 3 THEN
                            smsCode := '0' + smsCode;

                sms_Password := smsCode;
                //Customer.MODIFY;
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
        smsCode: Code[4];
}

