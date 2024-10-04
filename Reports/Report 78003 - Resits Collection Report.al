report 78003 "Resits Collection Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Resits Collection Report.rdl';

    dataset
    {
        dataitem(DataItem1; 78002)
        {
            DataItemTableView = WHERE("Academic Year" = FILTER(<> ''),
                                      Programme = FILTER(<> ''),
                                      "Unit Code" = FILTER(<> ''));
            RequestFilterFields = "Academic Year", "Current Academic Year", Stage, Programme, "Unit Code";
            column(AcaYear; specexam
            ."Academic Year")
            {
            }
            column(AcaSem; specexam
            .Semester)
            {
            }
            column(stdNo; specexam
            ."Student No.")
            {
            }
            column(Stage; specexam
            .Stage)
            {
            }
            column(Prog; specexam
            .Programme)
            {
            }
            column(Unit; specexam
            ."Unit Code")
            {
            }
            column(CAcaYear; specexam
            ."Current Academic Year")
            {
            }
            column(CAcaSem; specexam
            ."Current Semester")
            {
            }
            column(Des; specexam
            ."Unit Description")
            {
            }
            column(logo; CompInfo.Picture)
            {
            }
            column(name; CompInfo.Name)
            {
            }
            column(address; CompInfo.Address)
            {
            }
            column(address2; CompInfo."Address 2")
            {
            }
            column(phone; CompInfo."Phone No.")
            {
            }
            column(mail; CompInfo."E-Mail")
            {
            }
            column(url; CompInfo."Home Page")
            {
            }
            column(scount; SCount)
            {
            }
            column(amount; Amount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SCount := SCount + 1;
                Amount := 200;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
                SCount := 0;
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
        CompInfo: Record 79;
        SCount: Integer;
        Amount: Decimal;
        specexam: Record "Aca-Special Exams Details";

}

