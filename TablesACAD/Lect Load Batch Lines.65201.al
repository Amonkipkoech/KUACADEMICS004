/// <summary>
/// Table Lect Load Batch Lines (ID 65201).
/// </summary>
table 65201 "Lect Load Batch Lines"
{

    fields
    {
        field(1; "Semester Code"; Code[20])
        {
            TableRelation = "Lect Load Batches"."Semester Code";
        }
        field(2; "Lecturer Code"; Code[20])
        {
            Caption = 'No.';
            TableRelation = "HRM-Employee (D)"."No." WHERE(Lecturer = FILTER(true));

            trigger OnValidate()
            begin
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "Lecturer Code");
                IF HRMEmployeeC.FIND('-') THEN BEGIN
                    "Lecturer Name" := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                    "Department Code" := HRMEmployeeC."Department Code";


                    // Faculty:=HRMEmployeeC.fa;
                    VALIDATE(Faculty);
                END;
            end;
        }
        field(3; "Lecturer Name"; Text[150])
        {
            //FieldClass = FlowField;
        }
        field(36; Admissible; Boolean)
        {
            CalcFormula = - Exist("ACA-Lecturers Units" WHERE(Lecturer = FIELD("Lecturer Code"),
                                                              Semester = FIELD("Semester Code"),
                                                              Approved = FILTER(false)));
            FieldClass = FlowField;
        }
        field(37; Approve; Boolean)
        {

            trigger OnValidate()
            begin
                IF Approve THEN BEGIN
                    CALCFIELDS("Courses Count", Admissible);
                    IF "Courses Count" = 0 THEN ERROR('No units to approve');
                    IF Admissible = FALSE THEN ERROR('Not admissible. Approve all units first');
                END;
                TESTFIELD(Campus);
                TESTFIELD("Department Code");
                IF Approve THEN BEGIN
                    Reject := FALSE;
                    "Reject Reason" := '';
                END;

                //"Approved by"
                "Approved by" := USERID;
                "Approved Time" := TIME;
                "Approved Date" := TODAY;
            end;
        }
        field(38; Reject; Boolean)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Reject Reason");
                IF Reject THEN BEGIN
                    Approve := FALSE;

                END;

                "Rejected By" := USERID;
                "Rejected Time" := TIME;
            end;
        }
        field(39; "Reject Reason"; Text[250])
        {
        }
        field(40; "Additional Comments"; Text[250])
        {
        }
        field(42; Phone; Code[100])
        {
            CalcFormula = Lookup("HRM-Employee (D)"."Cellular Phone Number" WHERE("No." = FIELD("Lecturer Code")));
            FieldClass = FlowField;
        }
        field(47; "Claim No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Claim Initiated By" := USERID;
                "Claim Initiated Date" := TODAY;
            end;
        }
        field(48; "PV No."; Code[20])
        {

            trigger OnValidate()
            begin
                //"PV Created Date":=TODAY;
                "PV Created Time" := TIME;
            end;
        }
        field(49; "Courses Count"; Integer)
        {
            CalcFormula = Count("ACA-Lecturers Units" WHERE(Lecturer = FIELD("Lecturer Code"),
                                                             Semester = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(50; "Last Modified By"; Code[50])
        {
        }
        field(51; "Last Modified Time"; Time)
        {
        }
        field(52; "Approved by"; Code[50])
        {
        }
        field(53; "Approved Time"; Time)
        {
        }
        field(54; "Approved Machine"; Code[100])
        {
        }
        field(55; "Claim Initiated By"; Code[50])
        {
        }
        field(56; "PV Created Date"; Date)
        {
        }
        field(57; "Rejected By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(58; "Rejected Time"; Time)
        {
        }
        field(59; "Created By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(60; "Created Time"; Time)
        {
        }
        field(306; "Claim Initiated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(307; "PV Created Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(308; "PV Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,1st Approval,2nd Approval,Cheque Printing,Posted,Cancelled,Checking,VoteBook,Pending Approval,Approved';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
        }
#pragma warning disable AL0603
        field(309; "Claim Status"; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup("Purchase Header".Status WHERE("Document Type" = FILTER(Invoice),
                                                                 "No." = FIELD("Claim No.")));
            FieldClass = FlowField;
            OptionCaption = 'Pending,1st Approval,2nd Approval,Cheque Printing,Posted,Cancelled,Checking,VoteBook,Pending Approval,Approved';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
        }
        field(310; "Claim Current Approver"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(311; "PV Current Approver"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(312; Faculty; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
        }
        field(313; "Faculty Name"; Text[250])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Faculty)));
            FieldClass = FlowField;
        }
        field(314; "Appointment Later Ref. No."; Code[100])
        {
            CalcFormula = Lookup("Lect Load Batches"."Appointment Later Ref. No." WHERE("Semester Code" = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(315; "Appointment Later Ref."; Code[150])
        {
            CalcFormula = Lookup("Lect Load Batches"."Appointment Later Ref." WHERE("Semester Code" = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(316; "Semester Range Descption"; Text[250])
        {
            CalcFormula = Lookup("Lect Load Batches"."Semester Range Descption" WHERE("Semester Code" = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(317; "Approval Name"; Text[250])
        {
            CalcFormula = Lookup("Lect Load Batches"."Approval Name" WHERE("Semester Code" = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(318; "Approval Title"; Code[250])
        {
            CalcFormula = Lookup("Lect Load Batches"."Approval Title" WHERE("Semester Code" = FIELD("Semester Code")));
            FieldClass = FlowField;
        }
        field(319; Amount; Decimal)
        {
            CalcFormula = Sum("ACA-Lecturers Units"."Unit Cost" WHERE(Lecturer = FIELD("Lecturer Code"),
                                                                       Semester = FIELD("Semester Code"),
                                                                       "Engagement Terms" = FILTER("External Part-Timer" | "Internal Part-Timer"),
                                                                       Posted = FILTER(false)));
            FieldClass = FlowField;
        }
        field(320; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(321; "Pending Marks"; Boolean)
        {
            CalcFormula = Exist("ACA-Lecturers Units" WHERE(Lecturer = FIELD("Lecturer Code"),
                                                             Semester = FIELD("Semester Code"),
                                                             "Marks Submitted" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(323; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(324; "Exists Part-Time"; Boolean)
        {
            CalcFormula = Exist("ACA-Lecturers Units" WHERE(Lecturer = FIELD("Lecturer Code"),
                                                             Semester = FIELD("Semester Code"),
                                                             "Engagement Terms" = FILTER("External Part-Timer" | "Internal Part-Timer")));
            FieldClass = FlowField;
        }
        field(325; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENT' | 'DEPARTMENTS'));
        }
        field(326; "Department Name"; Text[220])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Department Code"),
                                                               "Dimension Code" = FILTER('DEPARTMENTS' | 'DEPARTMENT')));
            FieldClass = FlowField;
        }
        field(327; Campus; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS' | 'CAMPUSES'));
        }
        field(328; Claimed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(329; Invoiced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Semester Code", "Lecturer Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "Claim No." <> '' THEN ERROR('Already Approved!');
        IF Approve THEN BEGIN
            IF LectLoadPermissions.GET(USERID) THEN
                LectLoadPermissions.TESTFIELD("Delete After Approval")
            ELSE
                ERROR('Access Denied!');
        END;

        LectLoadCustProdSource.RESET;
        LectLoadCustProdSource.SETRANGE(LectLoadCustProdSource.Semester, Rec."Semester Code");
        LectLoadCustProdSource.SETRANGE(LectLoadCustProdSource.Lecturer, Rec."Lecturer Code");
        IF LectLoadCustProdSource.FIND('-') THEN BEGIN
            LectLoadCustProdSource.DELETEALL;
        END;



        IF LectLoadBatches.GET("Semester Code") THEN BEGIN
            IF LectLoadBatches.Status <> LectLoadBatches.Status::Draft THEN BEGIN
                IF LectLoadPermissions.GET(USERID) THEN
                    LectLoadPermissions.TESTFIELD("Delete After Approval")
                ELSE
                    ERROR('Access Denied!');
            END;
        END ELSE
            ERROR('Batch does not exists!');
    end;

    trigger OnInsert()
    begin
        //IF LectLoadPermissions.GET(USERID) THEN
        // LectLoadPermissions.TESTFIELD("Create Load List");

        IF LectLoadBatches.GET("Semester Code") THEN BEGIN
            IF LectLoadBatches.Status <> LectLoadBatches.Status::Draft THEN BEGIN
                IF LectLoadPermissions.GET(USERID) THEN
                    LectLoadPermissions.TESTFIELD("Insert After Approval")
                ELSE
                    ERROR('Access Denied!');
            END;
        END ELSE
            ERROR('Batch does not exists!');

        "Created By" := USERID;
        "Created Time" := TIME;
    end;

    trigger OnModify()
    begin
        IF LectLoadBatches.GET("Semester Code") THEN BEGIN
            IF LectLoadBatches.Status <> LectLoadBatches.Status::Draft THEN BEGIN
                IF LectLoadPermissions.GET(USERID) THEN
                    LectLoadPermissions.TESTFIELD("Modify After Approval")
                ELSE
                    ERROR('Access Denied!');
            END;
        END ELSE
            ERROR('Batch does not exists!');
    end;

    var
        LectLoadBatches: Record 65200;
        LectLoadCustProdSource: Record 65202;
        LectLoadPermissions: Record 65207;
        HRMEmployeeC: Record "HRM-Employee (D)";
}

