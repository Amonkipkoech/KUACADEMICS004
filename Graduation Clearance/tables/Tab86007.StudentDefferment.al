table 86007 defferedStudents

{
    DataClassification = ToBeClassified;

    fields
    {
        field(123; "Request No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1; studentNo; Code[20])
        {
            TableRelation = Customer where("Customer Posting Group" = const('Student'));
            trigger OnValidate()
            begin
                if cust.get(Rec.studentNo) then begin
                    Rec.studentName := cust.Name;
                    cust.CalcFields(Programme);
                    Rec.programme := cust.Programme;
                    Rec."E-mail" := cust."E-Mail";
                    Rec."Mobile No" := cust."Mobile Phone No.";
                end;
            end;

        }
        field(2; studentName; Text[200])
        {

        }
        field(3; programme; code[20])
        {
            TableRelation = "ACA-Programme";
            trigger OnValidate()
            begin
                progs.Reset();
                progs.SetRange(Code, Rec.programme);
                if progs.Find('-') then begin
                    Rec.Department := progs."Department Code";
                    Rec."School Code" := progs.Faculty;
                end;
            end;
        }
        field(4; stage; code[20])
        {
            Caption = 'Year';
            TableRelation = "ACA-Programme Stages" where("Programme Code" = field(programme));
        }
        field(5; status; Option)
        {
            OptionMembers = Open,Pending,Approved,Cancelled,Rejected,Posted,ReAdmission,readmitted;
        }
        field(7; deffermentReason; Text[300])
        {

        }
        field(8; Semeter; Code[20])
        {
            Caption = 'Block/Session';
            TableRelation = "ACA-Semesters";
            trigger OnValidate()
            begin
                creg.Reset();
                creg.SetRange(Semester, Rec.Semeter);
                if creg.Find('-') then begin
                    Rec.stage := creg.Stage;
                end;
            end;
        }
        field(9; "Mobile No"; Text[15])
        {

        }
        field(10; Department; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "School Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(12; "Request Type"; Option)
        {
            OptionMembers = " ","Discontinuation",Deferment;
        }
        field(13; "Reason for Calling off"; Option)
        {
            OptionMembers = "Financial difficulties","Family problems ","Family problems";
        }
        field(14; "Recommendation COD"; text[200])
        {

        }
        field(30; "Hod Date"; Date)
        {

        }
        field(33; "Hoi Date"; Date)
        {

        }
        field(31; "Hod cleared"; Boolean)
        {

        }
        field(32; "HoI Cleared"; Boolean)
        {

        }
        field(34; "Head Of Clinical Rotation"; Date)
        {

        }
        field(36; "HoL"; Date)
        {

        }
        field(37; "HoL cleared"; Boolean)
        {

        }
        field(38; "HoF cleared"; Boolean)
        {

        }
        field(39; "HoF Approval Date"; Date)
        {

        }
        field(35; "HCR Cleared"; Boolean)
        {

        }

        field(15; "Recommendation Dean"; text[200])
        {

        }
        field(45; "DTRI Ratification Date"; date)
        {

        }
        field(16; "E-mail"; Text[50])
        {

        }
        field(17; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Deferment  Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Deferment  End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Request No")
        {
            Clustered = true;
        }
    }

    var
        cust: Record Customer;
        creg: Record "ACA-Course Registration";
        progs: Record "ACA-Programme";

    trigger OnInsert()
    var
        GeneralSetup: Record "ACA-General Set-Up";
        NoSerMng: Codeunit NoSeriesManagement;
    begin

        IF "Request No" = '' THEN BEGIN
            GeneralSetup.Get();
            GeneralSetup.TESTFIELD(GeneralSetup."Deferral Nos.");
            NoSerMng.InitSeries(GeneralSetup."Deferral Nos.", xRec."No. Series", 0D, "Request No", "No. Series");
        END;
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