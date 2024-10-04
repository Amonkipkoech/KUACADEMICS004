report 51004 "Student Room Allocations2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Student Room Allocations2.rdl';

    dataset
    {
        dataitem(SR; 61155)
        {
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

            trigger OnAfterGetRecord()
            begin
                IF ((i > 1) OR (i = 0)) THEN BEGIN
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
                RoomNo[i] := 'ROOM: ' + RoomNo[i] + ', SPACE: ' + SpaceNo[i];
                ;


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
        Studname: array[1] of Text[150];
        studNo: array[1] of Code[50];
        Gend: array[1] of Code[50];
        hostelName: array[1] of Code[100];
        RoomNo: array[1] of Code[50];
        SpaceNo: array[1] of Code[50];
        University: Label 'MASENO UNIVERSITY';
        HostAll: Label 'Student Hostel Allocation';
        i: Integer;
        HOST: Record 61162;
}

