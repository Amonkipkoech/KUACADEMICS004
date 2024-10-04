table 85601 "Programme Leaders"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Programme Code"; Code[10])
        {
            TableRelation = "ACA-Programme".Code;
            trigger OnValidate()
            begin
                prog.Reset;
                prog.SetRange(prog.Code, "Programme Code");
                if prog.FindFirst() then
                    "Programme Name" := prog.Description;
            end;
        }
        field(2; "Programme Name"; text[200])
        {

        }
        field(3; Levels; Option)
        {
            OptionMembers = ,,Certificate,Diploma,"Postgraduate Diploma",Bachelor,Masters,Doctorate,Professional,Others;
        }
        field(4; "Faculty Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            // trigger OnValidate()
            // begin
            //     prog.Reset;
            //     prog.SetRange(prog.Faculty, "Faculty Code");
            //     if prog.FindFirst() then
            //         "Faculty Name" := prog.fa;
            // end;  
            // get back!!!
        }
        field(5; "Faculty Name"; Text[100])
        {

        }
        field(6; "Programme Leader Staff ID"; Code[10])
        {
            TableRelation = "HRM-Employee (D)"."No.";//WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Programme Leader Staff ID");
                if HREmp.Find('-') then begin
                    EmpFullName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Programme Leader Name" := EmpFullName;
                end;
            end;

        }
        field(7; "Programme Leader Name"; Text[100])
        {

        }
        field(8; "Programme Status"; option)
        {
            OptionMembers = "",Active,Decomission;

        }
        field(9; "Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

        }
    }

    keys
    {
        key(Key1; "Programme Code", "Programme Leader Staff ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        prog: Record "ACA-Programme";
        HREmp: Record "HRM-Employee (D)";
        EmpFullName: Text;




}