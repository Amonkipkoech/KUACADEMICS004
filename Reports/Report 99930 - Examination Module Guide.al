report 99930 "Examination Module Guide"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Examination Module Guide.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            CalcFields = Picture;
            column(CompName; "Company Information".Name)
            {
            }
            column(Pic; "Company Information".Picture)
            {
            }
            column(Address; "Company Information".Address + ' ' + "Company Information"."Address 2" + ', ' + "Company Information".City)
            {
            }
            column(Phone; "Company Information"."Phone No." + ' ' + "Company Information"."Phone No. 2")
            {
            }
            column(mails; "Company Information"."E-Mail" + ' ' + "Company Information"."Home Page")
            {
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
}

