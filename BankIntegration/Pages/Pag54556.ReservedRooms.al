page 54556 "Reserved Rooms"
{
    ApplicationArea = All;
    Caption = 'Reserved Rooms Spaces';
    PageType = List;
    DelayedInsert = true;
    SourceTable = "Accomodation and Booking";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(BillRefNo; Rec.BillRefNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill Ref No field.', Comment = '%';
                }
                field(InvoiceNo; Rec.InvoiceNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No field.', Comment = '%';
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No field.', Comment = '%';
                }
                field(StudentName; Rec.StudentName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field(HostelNo; Rec.HostelNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hostel No field.', Comment = '%';
                }
                field(RoomNo; Rec.RoomNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Room No field.', Comment = '%';
                }
                field(SpaceNo; Rec.SpaceNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Space No field.', Comment = '%';
                }
                field(SpaceCost; Rec.SpaceCost)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Space Cost field.', Comment = '%';
                }
                field(ServiceCode; Rec.ServiceCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Booking Date"; Rec."Booking Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Booking Date field.', Comment = '%';
                }
            }
        }
    }
}
