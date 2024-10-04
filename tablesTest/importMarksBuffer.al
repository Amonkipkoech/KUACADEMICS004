table 84517 "Import Marks Buffer"
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "importMarksBuffer";
    //LookupPageId = "importMarksBuffer";

    fields
    {
        field(1; examEntry; code[50])
        {

        }
        field(2; studentNo; code[20])
        {

        }
        field(3; AcademicYr; Code[20])
        {

        }
        field(4; Sem; Code[20])
        {

        }
        field(5; unitCode; Code[20])
        {

        }
        field(6; uniName; text[150])
        {

        }
        field(7; Prog; code[10])
        {

        }
        field(8; cat; Decimal)
        {

        }
        field(9; Exam; Decimal)
        {

        }
        field(10; Exists; Integer)
        {
            CalcFormula = count("Import Marks Buffer" where(studentNo = field(studentNo), AcademicYr = field(AcademicYr), unitCode = field(unitCode)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; examEntry)
        {
            Clustered = true;
        }
    }



}