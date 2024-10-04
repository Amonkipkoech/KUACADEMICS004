table 85528 "ACA-Lecturer Halls Setup"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Lecture Room Code"; Code[20])
        {

        }
        field(2; "Lecture Room Name"; Text[100])
        {

        }
        field(3; "Sitting Capacity"; integer)
        {

        }
        field(4; "Exam Sitting Capacity"; Integer)
        {

        }
        field(5; "Building Code"; Code[20])
        {
            TableRelation = "ACA-Buidings Setups"."Building Code";
        }
        field(6; Campus; Code[20])
        {
             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; Department; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; Serial; code[10])
        {

        }

    }
    
    keys
    {
        key(Key1; "Lecture Room Code", "Building Code",Serial)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}