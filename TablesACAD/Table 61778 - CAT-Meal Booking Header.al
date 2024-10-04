table 61778 "CAT-Meal Booking Header"
{
    // DrillDownPageID = 68803;
    // LookupPageID = 68803;

    fields
    {
        field(1; "Booking Id"; Code[20])
        {
        }
        field(2; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(3; "Request Date"; Date)
        {
        }
        field(4; "Booking Date"; Date)
        {
        }
        field(5; "Meeting Name"; Text[50])
        {
        }
        field(6; "Required Time"; Time)
        {
        }
        field(7; Venue; Text[50])
        {
        }
        field(8; "Contact Person"; Text[50])
        {
        }
        field(9; "Contact Number"; Text[30])
        {
        }
        field(10; "Contact Mail"; Text[30])
        {
        }
        field(11; Pax; Integer)
        {
        }
        field(12; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Cancelled,Rejected;
        }
        field(13; "Caterring Approval Date"; Date)
        {
        }
        field(14; "HOD Approve Date"; Date)
        {
        }
        field(15; "Finance Approve Date"; Date)
        {
        }
        field(16; "Registrar Approve Date"; Date)
        {
        }
        field(17; "Department Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD(Department)));
            FieldClass = FlowField;
        }
        field(18; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("CAT-Meal Booking Lines".Cost WHERE("Booking Id" = FIELD("Booking Id")));
            FieldClass = FlowField;
        }
        field(19; "Requested By"; Code[30])
        {
        }
        field(20; "No. Series"; Code[10])
        {
        }
        field(21; "Booking Time"; Time)
        {
        }
        field(22; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
        }
        field(23; Commited; Boolean)
        {
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin

                //TESTFIELD(Status,Status::pe);
                //IF NOT UserMgt.CheckRespCenter(1,"Responsibility Center") THEN
                // ERROR(
                // Text001,
                // RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */

            end;
        }
        field(50045; "Budgeted Amount"; Decimal)
        {
            Editable = false;
        }
        field(50046; "Actual Expenditure"; Decimal)
        {
            Editable = false;
        }
        field(50047; "Committed Amount"; Decimal)
        {
            Editable = false;
        }
        field(50048; "Budget Balance"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Booking Id")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Rec.Status <> Rec.Status::New THEN ERROR('Deletion is not allowed.');
    end;

    trigger OnInsert()
    begin
        IF "Booking Id" = '' THEN BEGIN
            NoSeries.GET;
            //NoSeries.TESTFIELD(NoSeries."Meals Booking No.");
            //NoSeriesMgt.InitSeries(NoSeries."Meals Booking No.",xRec."No. Series",0D,"Booking Id","No. Series");
        END;

        "Requested By" := USERID;
        "Booking Time" := TIME;
        "Booking Date" := TODAY;
        HRMEmployeeC.RESET;
        HRMEmployeeC.SETRANGE("User ID", USERID);
        IF HRMEmployeeC.FIND('-') THEN BEGIN
            Department := HRMEmployeeC."Department Code";
            "Contact Mail" := HRMEmployeeC."E-Mail";
            "Contact Number" := HRMEmployeeC."Cellular Phone Number" + '/' + HRMEmployeeC."Ext.";
            "Contact Person" := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
        END;
    end;

    var
        NoSeries: Record 98;
        NoSeriesMgt: Codeunit 396;
        HRMEmployeeC: Record 61188;
}

