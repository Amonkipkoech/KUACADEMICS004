table 61344 "ACA-Staff Online Access"
{
    Caption = 'Employee';
    // DrillDownPageID = 68423;
    // LookupPageID = 68423;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                /*
                IF "No." <> xRec."No." THEN BEGIN
                  salessetup.GET;
                  NoSeriesMgt.TestManual(salessetup."Stud Application");
                  "No. Series" := '';
                END;
                 */

            end;
        }
        field(2; "First Name"; Text[80])
        {
        }
        field(3; "Middle Name"; Text[50])
        {
        }
        field(4; "Last Name"; Text[50])
        {

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5; Initials; Text[15])
        {
        }
        field(7; "Search Name"; Code[50])
        {
        }
        field(67; "Applicant Type"; Option)
        {
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
        }
        field(68; Activate; Boolean)
        {
        }
        field(69; "Course Requested"; Text[100])
        {
        }
        field(70; Password; Text[50])
        {
        }
        field(71; Qualifications; Text[250])
        {
        }
        field(72; "Email Comments"; Text[250])
        {
        }
        field(73; "Activation Date"; DateTime)
        {
        }
        field(74; "Enquiry Date"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        /*IF "No." = '' THEN BEGIN
          salessetup.GET;
          salessetup.TESTFIELD(salessetup."Stud Application");
          NoSeriesMgt.InitSeries(salessetup."Stud Application",xRec."No. Series",0D,"No.","No. Series");
        END;
        */

    end;

    var
        //Needs: Record "61307";
        Employee: Record 61188;
        //HumanResSetup: Record 61204;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record 5203;
        //AppQualifications: Record 61314;
        AppSeriesGet: Record 61342;
        salessetup: Record 311;
}

