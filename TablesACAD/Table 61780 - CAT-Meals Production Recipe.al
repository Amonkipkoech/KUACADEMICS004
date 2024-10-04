table 61780 "CAT-Meals Production Recipe"
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
        field(3; "Meal Code"; Code[10])
        {
            TableRelation = "CAT-Meals Setup".Code;
        }
        field(4; "Meal Discription"; Text[250])
        {
            CalcFormula = Lookup("CAT-Meals Setup".Discription WHERE(Code = FIELD("Meal Code")));
            FieldClass = FlowField;
        }
        field(5; Portions; Decimal)
        {
        }
        field(6; "Cost P.D."; Decimal)
        {
            CalcFormula = Sum("CAT-Meal Production Det."."Total Cost" WHERE(Month = FIELD(Month),
                                                                             Year = FIELD(Year),
                                                                             "Meal Code" = FIELD("Meal Code"),
                                                                             Semester = FIELD(Semester)));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(7; "S. Price"; Decimal)
        {
        }
        field(8; Semester; Code[10])
        {
            TableRelation = "ACA-Semester".Code;
        }
        field(9; "Year Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020';
            OptionMembers = " ","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020";
            TableRelation = "CAT-Meals Production Recipe".Year;
        }
    }

    keys
    {
        key(Key1; Month, Year, "Meal Code", Semester)
        {
        }
    }

    fieldgroups
    {
    }
}

