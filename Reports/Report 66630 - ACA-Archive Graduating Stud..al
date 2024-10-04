report 66630 "ACA-Archive Graduating Stud."
{
    Caption = 'Archive Graduating Students';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE(Status = FILTER(Current | Registration | "Graduated no Certificates" | "Graduated with Certificate"),
                                      "Tagged as Graduating" = FILTER(true));
            RequestFilterFields = "No.", "Graduating Academic Year";

            trigger OnAfterGetRecord()
            begin
                Customer.Status := Customer.Status::Alluminae;
                Customer.MODIFY;
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
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FIND('-') THEN BEGIN
            UserSetup.TESTFIELD("Can Archive Students");
        END ELSE
            ERROR('Access denied!');
    end;

    trigger OnPostReport()
    begin
        MESSAGE('Updated!');
    end;

    trigger OnPreReport()
    begin
        IF Customer.GETFILTER("Graduating Academic Year") = '' THEN ERROR('Specify Graduating Academic Year!');
    end;

    var
        UserSetup: Record 91;
}

