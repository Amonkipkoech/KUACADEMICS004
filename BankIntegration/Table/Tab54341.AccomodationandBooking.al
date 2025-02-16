table 54341 "Accomodation and Booking"
{
    Caption = 'Accomodation and Booking';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; BillRefNo; Code[50])
        {
            Caption = 'Bill Ref No';
        }
        field(2; InvoiceNo; Code[50])
        {
            Caption = 'Invoice No';
        }
        field(3; StudentNo; Code[50])
        {
            Caption = 'Student No';
        }
        field(4; StudentName; Text[100])
        {
            Caption = 'Student Name';
        }
        field(5; Semester; Code[20])
        {
            Caption = 'Semester';
        }
        field(6; HostelNo; Code[20])
        {
            Caption = 'Hostel No';
        }
        field(7; RoomNo; Code[20])
        {
            Caption = 'Room No';
        }
        field(8; SpaceNo; Code[20])
        {
            Caption = 'Space No';
        }
        field(9; SpaceCost; Decimal)
        {
            Caption = 'Space Cost';
        }
        field(10; ServiceCode; Code[20])
        {
            Caption = 'Service Code';
        }

        field(11; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Booking Date"; Date)
        {
            Caption = 'Booking Date';
        }
        field(13; "Academic Year"; Text[100])
        {
            Caption = 'Booking Date';
        }

    }
    keys
    {
        key(PK;  Semester, HostelNo, RoomNo, SpaceNo)
        {
            Clustered = true;
        }

    }
}
