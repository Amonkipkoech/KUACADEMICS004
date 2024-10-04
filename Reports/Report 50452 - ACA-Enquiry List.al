report 50452 "ACA-Enquiry List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Enquiry List.rdl';

    dataset
    {
        dataitem(EnH; 61348)
        {
            column(no; EnH."Enquiry No.")
            {
            }
            column(enqDate; EnH."Enquiry Date")
            {
            }
            column(Names; EnH."Name(Surname First)")
            {
            }
            column(Gender; EnH.Gender)
            {
            }
            column(Prog; EnH.Programmes)
            {
            }
            column(Surname; EnH.Surname)
            {
            }
            column(OtherNames; EnH."Other Names")
            {
            }
            column(MktStrategy; EnH."How You knew about us")
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

