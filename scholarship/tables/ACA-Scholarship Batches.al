table 78031 "ACA-Scholarship Batches"
{

    DrillDownPageId = "ACA-Scholarship Batches";
    LookupPageId = "ACA-Scholarship Batches";

    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Document Date"; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                genSetUp.Get();
                genSetUp.TestField("Scholarship Nos.");
                "No." := noseries.GetNextNo(genSetUp."Scholarship Nos.", TODAY, TRUE);
            end;
        }
        field(3; "Scholarship Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Scholarships".Code where(Status = filter(Active));

            trigger OnValidate()
            var
                scholarships: Record "ACA-Scholarships";
            begin

                scholarships.Reset();
                scholarships.SetRange(Code, "Scholarship Code");
                if scholarships.FindFirst() then begin
                    "Scholarship Name" := scholarships."Scholarship Name";
                    "Scholarship Type" := scholarships."Scholarship Category";
                end;


                "Document Date" := Today;
                Validate("Document Date");


            end;
        }
        field(4; "Scholarship Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Scholarship Type"; Option)
        {
            OptionMembers = " ","Internal","External";
        }
        field(6; "No. of Students "; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Batch No."; Code[20])
        {
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(8; "Batch Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Receipt Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Allocated Amount"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(12; "Semester"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(13; "Semester Code"; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(14; "Bank Code"; Code[20])
        {
            Caption = 'Allocating Bank Account';
            TableRelation = "Bank Account";
        }
        field(15; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(16; "Receipt No"; Code[20])
        {
            TableRelation = "FIN-Receipts Header" where("Is Scholarship" = filter(true));
            trigger OnValidate()
            var
                recEipts: Record "FIN-Receipts Header";
            begin
                // Find the selected receipt by the "Receipt No"
                if recEipts.Get("Receipt No") then
                    // Assign the "Amount Received" from "FIN-Receipts Header" to "Receipt Amount"
                    "Receipt Amount" := recEipts."Amount Recieved"
                // Message('Receipt amount %',"Receipt Amount", 'have been update succesfully ')

                else
                    // Optional: Clear "Receipt Amount" if no matching record is found
                    "Receipt Amount" := 0;
            end;
        }
        field(17; "Status"; Option)
        {
            OptionMembers = " ",Active,Inactive;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Batch No.")
        {

        }

    }

    var
        genSetUp: Record "ACA-General Set-Up";
        noseries: Codeunit NoSeriesManagement;
        pagie: Record "Purchase Header";

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