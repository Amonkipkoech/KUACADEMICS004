/* report 50050 "Visitors Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Visitors Register.rdl';

    dataset
    {
        dataitem(Vl;50051)
        {
            column(VisitNo;Vl."Visit No.")
            {
            }
            column(TransDate;Vl."Transaction Date")
            {
            }
            column(IdNo;Vl."ID No.")
            {
            }
            column(FullName;Vl."Full Name")
            {
            }
            column(Phone;Vl."Phone No.")
            {
            }
            column(Email;Vl.Email)
            {
            }
            column(Company;Vl.Company)
            {
            }
            column(Dept;Vl."Office Station/Department")
            {
            }
            column(InBy;Vl."Signed in by")
            {
            }
            column(TimeIn;Vl."Time In")
            {
            }
            column(OutBy;Vl."Signed Out By")
            {
            }
            column(TimeOut;Vl."Time Out")
            {
            }
            column(Comment;Vl.Comment)
            {
            }
            column(CheckedOut;Vl."Checked Out")
            {
            }
            column(CompName;compInfo.Name)
            {
            }
            column(CompAddress;compInfo.Address)
            {
            }
            column(CompCity;compInfo.City)
            {
            }
            column(CompPhone;compInfo."Phone No.")
            {
            }
            column(CompMail;compInfo."E-Mail")
            {
            }
            column(CompWeb;compInfo."Home Page")
            {
            }
            column(Logo;compInfo.Picture)
            {
            }
            column(CompPostCode;compInfo."Post Code")
            {
            }
            column(seq;seq)
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq:=seq+1;
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
        IF compInfo.GET() THEN BEGIN
          compInfo.CALCFIELDS(Picture);
          END;
          CLEAR(seq);
    end;

    var
        compInfo: Record "79";
        seq: Integer;
        datefilter: Text[30];
}
 */
