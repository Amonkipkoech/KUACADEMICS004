table 61770 "CAT-Meal Production Det."
{

    fields
    {
        field(1; Month; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(2; Year; Option)
        {
            OptionCaption = ' ,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020';
            OptionMembers = " ","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020";
        }
        field(3; "Meal Code"; Code[20])
        {
            TableRelation = "CAT-Meals Setup".Code;
        }
        field(8; Semester; Code[20])
        {
            TableRelation = "ACA-Semester".Code;
        }
        field(9; "Item Code"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(10; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item Code")));
            FieldClass = FlowField;
        }
        field(11; "Unit Price"; Decimal)
        {
            CalcFormula = Lookup(Item."Unit Cost" WHERE("No." = FIELD("Item Code")));
            FieldClass = FlowField;
        }
        field(12; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 4;

            trigger OnValidate()
            begin
                IF Quantity <> 0 THEN "Total Cost" := "Unit Price" * Quantity;
            end;
        }
        field(13; "Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item Code"));
        }
        field(14; "Total Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Month, Year, "Meal Code", Semester, "Item Code")
        {
        }
        key(Key2; Semester, Month, Year, "Meal Code")
        {
            SumIndexFields = "Total Cost";
        }
    }

    fieldgroups
    {
    }
}

