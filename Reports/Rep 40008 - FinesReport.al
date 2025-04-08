report 40008 "Fines Report"
{
    Caption = 'Fines Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fines Billings.rdl';
    dataset
    {
        dataitem(GownIssuanceRegister; "Gown Issuance Register")
        {
            column(No; "No.")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(StudentName; "Student Name")
            {
            }
            column(School; School)
            {
            }
            column(Department; Department)
            {
            }
            column(Status; Status)
            {
            }
            column(DateIssued; "Date Issued")
            {
            }
            column(ExpectedReturnDate; "Expected Return Date")
            {
            }
            column(ActualReturnDate; "Actual Return Date")
            {
            }
            column(Issued; Issued)
            {
            }
            column(Returned; Returned)
            {
            }
            column(NumberofGownsLeft; "Number of Gowns Left")
            {
            }
            column(DaysPassed; DaysPassed)
            {
            }
            column(Fine; Fine)
            {
            }
            column(info_pic; info.Picture)
            {

            }
            column(info_name; info.name)
            {

            }
            column(info_address; info.Address)
            {

            }
            column(info_mail; info."E-Mail")
            {

            }
            column(seq;seq)
            {
                
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                seq := seq + 1;

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        info.get();
        info.CalcFields(info.Picture)

    end;

    var
        info: Record "Company Information";
        seq: Integer;
}
