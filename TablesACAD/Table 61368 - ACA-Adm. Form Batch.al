table 61368 "ACA-Adm. Form Batch"
{

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            Description = 'Stores the batch number code n the database';
        }
        field(2; "Batch Date"; Date)
        {
            Description = 'Stores the batch date in the database';
        }
        field(3; "Batch Time"; Time)
        {
            Description = 'Stores the time of the batch in the database';
        }
        field(4; "No. Of Applications Pending"; Integer)
        {
            CalcFormula = Count("ACA-Applic. Form Header" WHERE(Status = CONST("Admission Board"),
                                                                 "Batch No." = FIELD("Batch No.")));
            FieldClass = FlowField;
        }
        field(5; "No.Of Applications Ratified"; Integer)
        {
            CalcFormula = Count("ACA-Applic. Form Header" WHERE(Status = FILTER(<> "Admission Board Rejected"),
                                                                 "Batch No." = FIELD("Batch No."),
                                                                 Status = FILTER(<> "Admission Board")));
            FieldClass = FlowField;
        }
        field(6; "No. Of Applications Rejected"; Integer)
        {
            CalcFormula = Count("ACA-Applic. Form Header" WHERE(Status = FILTER(= "Admission Board Rejected"),
                                                                 "Batch No." = FIELD("Batch No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Batch No.")
        {
        }
    }

    fieldgroups
    {
    }
}

