report 51028 "Population Analy. (Gend/Type)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Population Analy. (GendType).rdl';

    dataset
    {
        dataitem(DV; 349)
        {
            DataItemTableView = WHERE("Dimension Code" = FILTER('SCHOOL'));
            PrintOnlyIfDetail = false;
            column(Dim_Name; DV.Code + ' ' + DV.Name)
            {
            }
            dataitem(AP; 61511)
            {
                DataItemLink = "School Code" = FIELD(Code);
                column(Desc; AP.Description)
                {
                }
                column(JabMAle; AP."Total JAB Male")
                {
                }
                column(JabFemale; AP."Total JAB Female")
                {
                }
                column(sspMale; AP."Total SSP Male")
                {
                }
                column(sspFemale; AP."Total SSP Female")
                {
                }
                column(StudRegistered; AP."Student Registered")
                {
                }
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

