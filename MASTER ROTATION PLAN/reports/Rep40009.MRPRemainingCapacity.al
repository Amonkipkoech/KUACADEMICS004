report 40009 "Rotation Capacity Summary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './MASTER ROTATION PLAN/reports/MrpRemainingCapacities.rdl';

    dataset
    {
        dataitem(Rotation; "Clinical rotation")
        {
            DataItemTableView = sorting("Group", "Areas");
            RequestFilterFields = "Group", "Areas", Session, Year;

            column(Year; Rotation.Year) { }
            column(Session; Rotation.Session) { }
            column(Group; Group) { }
            column(Areas; Areas) { }
            column(No_Of_Students; "No Of Students") { }
            column(Capacity; Capacity) { }
            column(Remaining_Capacity; RemainingCapacity) { }

            trigger OnAfterGetRecord()
            var
                TempRotation: Record "Clinical rotation" temporary;
                NoOfStudents: Integer;
                AreaCap: Integer;
            begin
                // Prevent duplicate Group + Area records
                if TempRotation.Get(Rotation."Group", Rotation."Areas") then
                    CurrReport.Skip();

                TempRotation.Init();
                TempRotation."Group" := Rotation."Group";
                TempRotation."Areas" := Rotation."Areas";
                TempRotation.Insert();

                // Calculate actual values
                CalcGroupAreaSummary(Rotation.Year, Rotation.Session, Rotation."Group", Rotation."Areas", NoOfStudents, AreaCap);
                RemainingCapacity := AreaCap - NoOfStudents;

                // Assign to output fields
                Group := Rotation."Group";
                Areas := Rotation."Areas";
                "No Of Students" := NoOfStudents;
                Capacity := AreaCap;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field("Group Filter"; Rotation."Group") { ApplicationArea = All; }
                    field("Area Filter"; Rotation."Areas") { ApplicationArea = All; }
                    field("Year Filter"; Rotation.Year) { ApplicationArea = All; }
                    field("Session Filter"; Rotation.Session) { ApplicationArea = All; }
                }
            }
        }
    }

    labels
    {
        Caption = 'Rotation Capacity Summary';
    }

    var
        Group: Code[20];
        Areas: Code[20];
        Capacity: Integer;
        RemainingCapacity: Integer;
        "No Of Students": Integer;

    local procedure CalcGroupAreaSummary(
        Year: Code[20];
        Session: Code[20];
        GroupCode: Code[20];
        Areas: Code[20];
        var NoOfStudents: Integer;
        var AreaCapacity: Integer)
    var
        RotRec: Record "Clinical rotation";
    begin
        NoOfStudents := 0;
        AreaCapacity := 0;

        RotRec.SetRange(Year, Year);
        RotRec.SetRange(Session, Session);
        RotRec.SetRange("Group", GroupCode);
        RotRec.SetRange("Areas", Areas);
        if RotRec.FindFirst() then begin
            NoOfStudents := RotRec."No Of Students";
            AreaCapacity := RotRec.Capacity;
        end;
    end;
}
