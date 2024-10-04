report 50012 "ACA-Update Resit Status"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Customer)
        {
            //CalcFields = ;

            trigger OnAfterGetRecord()
            begin
                IF Customer.Status = Customer.Status::Halt THEN BEGIN
                    IF Customer."Cumm. Failed Courses" < 4 THEN BEGIN
                        Customer.Status := Customer.Status::Current;
                    END;
                END;
                IF Customer."Cumm. Failed Courses" > 3 THEN BEGIN
                    Customer.Status := Customer.Status::Halt;
                END;
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

    trigger OnPostReport()
    begin
        MESSAGE('Students HALT status Updated');
    end;

    trigger OnPreReport()
    begin
        IF CONFIRM('Update Students Halt Status?', TRUE) = FALSE THEN ERROR('Cancelled by user.');
    end;

    var
        Customer: Record Customer;
}

