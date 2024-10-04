report 51001 "Student Room Allocations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Room Allocations.rdl';

    dataset
    {
        dataitem(SR; 61155)
        {
            RequestFilterFields = "Hostel No", "Room No", "Space No";
            column(University; University)
            {
            }
            column(HostAll; HostAll)
            {
            }
            column(studNo_1; studNo[1])
            {
            }
            column(Studname_1; Studname[1])
            {
            }
            column(Gend_1; Gend[1])
            {
            }
            column(hostelName_1; hostelName[1])
            {
            }
            column(RoomNo_1; RoomNo[1])
            {
            }
            column(SpaceNo_1; SpaceNo[1])
            {
            }
            column(studNo_2; studNo[2])
            {
            }
            column(Studname_2; Studname[2])
            {
            }
            column(Gend_2; Gend[2])
            {
            }
            column(hostelName_2; hostelName[2])
            {
            }
            column(RoomNo_2; RoomNo[2])
            {
            }
            column(SpaceNo_2; SpaceNo[2])
            {
            }
            column(studNo_3; studNo[3])
            {
            }
            column(Studname_3; Studname[3])
            {
            }
            column(Gend_3; Gend[3])
            {
            }
            column(hostelName_3; hostelName[3])
            {
            }
            column(RoomNo_3; RoomNo[3])
            {
            }
            column(SpaceNo_3; SpaceNo[3])
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF ((i > 3) OR (i = 0)) THEN BEGIN
                    CLEAR(Studname);
                    CLEAR(studNo);
                    CLEAR(Gend);
                    CLEAR(hostelName);
                    CLEAR(RoomNo);
                    CLEAR(SpaceNo);

                    CLEAR(i);
                    i := 1;
                END;

                HOST.RESET;
                HOST.SETRANGE(HOST."Asset No", SR."Hostel No");
                IF HOST.FIND('-') THEN BEGIN
                END;

                studNo[i] := SR.Student;
                Studname[i] := SR."Student Name";
                Gend[i] := FORMAT(SR.Gender);
                hostelName[i] := HOST.Description;//"Room Allocation Buffer"."Hostel No";
                RoomNo[i] := SR."Room No";
                SpaceNo[i] := SR."Space No";

                studNo[i] := 'NO: ' + studNo[i];
                Studname[i] := 'NAME: ' + Studname[i];
                Gend[i] := 'GENDER: ' + Gend[i];
                hostelName[i] := 'HOSTEL: ' + hostelName[i];
                RoomNo[i] := 'ROOM: ' + RoomNo[i];
                SpaceNo[i] := 'SPACE: ' + SpaceNo[i];

                i := i + 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CLEAR(Studname);
        CLEAR(studNo);
        CLEAR(Gend);
        CLEAR(hostelName);
        CLEAR(RoomNo);
        CLEAR(SpaceNo);
        // CLEAR(i);
        // i:=1;
    end;

    var
        Studname: array[3] of Text[150];
        studNo: array[3] of Code[50];
        Gend: array[3] of Code[50];
        hostelName: array[3] of Code[100];
        RoomNo: array[3] of Code[50];
        SpaceNo: array[3] of Code[50];
        University: Label 'MASENO UNIVERSITY';
        HostAll: Label 'Student Hostel Allocation';
        i: Integer;
        HOST: Record 61162;
}

