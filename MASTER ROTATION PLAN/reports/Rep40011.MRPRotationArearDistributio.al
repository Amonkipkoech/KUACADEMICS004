report 40011 "MRP Rotation Arear Distributio"
{
    Caption = 'MRP Rotation Arear Distributio';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './MASTER ROTATION PLAN/reports/MrpCapacities.rdl';

    dataset
    {
        dataitem(Clinicalrotation; "Clinical rotation")
        {
            DataItemTableView = SORTING(Year, Session, "Group", Areas);
            RequestFilterFields = Year, Session;

            column(PlanID; "Plan ID") { }
            column(NoOfStudents; "No Of Students") { }
            column(Group; "Group") { }
            column(Month; Month) { }
            column(StartingDate; "Starting Date") { }
            column(EndingDate; "Ending Date") { }
            column(Week; Week) { }
            column(NoSeries; "No. Series") { }
            column(Block7; Block7) { }
            column(AssessmentStartDate; "Assessment Start Date") { }
            column(AssessmentEndDate; "Assessment End Date") { }
            column(AssessmentScore; "Assessment Score") { }
            column(PassMark; "Pass Mark") { }
            column(Passed; Passed) { }
            column(MasterPlanNo; "Master Plan No") { }
            column(LecturerNo; "Lecturer No") { }
            column(LecturerName; "Lecturer Name") { }
            column(Block1; "Block 1") { }
            column(Block2; "Block 2") { }
            column(Block3; "Block 3") { }
            column(Capacity; Capacity) { }
            column(RemainingCapacity; "Remaining Capacity") { }
            column(Year; Year) { }
            column(Session; Session) { }
            column(Department; Department) { }
            column(program; "program") { }
            column(Status; Status) { }
            column(No; "No.") { }
            column(Areas; Areas) { }

            trigger OnPreDataItem()
            var
                TempClinical: Record "Clinical rotation" temporary;
                RealClinical: Record "Clinical rotation";
                LastKey: Code[100];
                CompositeKey: Text;
            begin
                // Copy matching records to a temporary table
                RealClinical.SetRange(Year, Clinicalrotation.GetFilter(Year));
                RealClinical.SetRange(Session, Clinicalrotation.GetFilter(Session));

                if RealClinical.FindSet() then begin
                    repeat
                        CompositeKey :=
                            Format(RealClinical.Year) + '|' +
                            Format(RealClinical.Session) + '|' +
                            Format(RealClinical."Group") + '|' +
                            Format(RealClinical.Areas);

                        if CompositeKey <> LastKey then begin
                            TempClinical := RealClinical;
                            TempClinical.Insert();
                            LastKey := CompositeKey;
                        end;
                    until RealClinical.Next() = 0;
                end;

                // Filter main dataitem to the selected No.'s
                if TempClinical.FindSet() then begin
                    SetRange("No."); // clear old filters
                    repeat
                        SetRange("No.", TempClinical."No.");
                        exit;
                    until TempClinical.Next() = 0;
                end else
                    CurrReport.Break();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // Let filters show on request page
            }
        }
    }
}
