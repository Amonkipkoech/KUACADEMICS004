page 86619 "ACA-Units Offered"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA-Units Offered";
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field(Programs; Rec.Programs)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programs field.';
                }
                field("Program Name"; Rec."Program Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Program Name field.';
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field(uniqueRecord; Rec.uniqueRecord)
                {
                    ApplicationArea = All;
                }
                field("Unit Base Code"; Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Base Code field.';
                }
                field(LectureAllocated; Rec.LectureAllocated)
                {
                    ApplicationArea = All;
                }
                field(ModeofStudy; Rec.ModeofStudy)
                {
                    ApplicationArea = ALL;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Day field.';
                }
                field(TimeSlot; Rec.TimeSlot)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TimeSlot field.';
                }
                field("Lecture Hall"; Rec."Lecture Hall")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecture Hall field.';
                }
                field("Sitting Capacity"; Rec."Sitting Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sitting Capacity field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Lecturer; Rec.Lecturer)
                {
                    ApplicationArea = All;
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = ALL;
                }
                field("Registered Students"; Rec."Registered Students")
                {
                    ApplicationArea = All;
                }

            }
        }

    }

    actions
    {
        // area(Processing)
        // {
        //     action("Student Timetable")
        //     {
        //         ApplicationArea = All;
        //         RunObject = report StudentTimetable;
        //         Image = Report;
        //     }
        //     action("Lecturer Timetable")
        //     {
        //         ApplicationArea = All;
        //         RunObject = report LecturerTimetable;
        //         Image = Report;
        //     }
        //     action(updateSEm1)
        //     {
        //         ApplicationArea = all;
        //         Image = Process;
        //         trigger OnAction()
        //         begin
        //             updateSem();
        //         end;
        //     }
        //     action(updateSEmLec)
        //     {
        //         ApplicationArea = all;
        //         Image = Process;
        //         trigger OnAction()
        //         begin
        //             updateYer();
        //         end;
        //     }
        //     action(ConfirmLec)
        //     {

        //         ApplicationArea = all;
        //         Image = Process;
        //         trigger OnAction()
        //         begin
        //             updateLec();
        //         end;
        //     }
        //     action(updateStud)
        //     {

        //         ApplicationArea = all;
        //         Image = Process;
        //         trigger OnAction()
        //         begin
        //             updateStudunits();
        //         end;
        //     }
        // }
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to access Units Allocation';
    begin
        AllowAccessSetup := true;
        if usersetup.get(UserId) then
            if (usersetup."Can modify unit Alocation") then begin
                AllowAccessSetup := usersetup."Can modify unit Alocation";
                exit
            end;
        Error(Nopermission);
    end;

    var
        prog: Record "ACA-Programme";
        units: Record "ACA-Units Offered";
        Halls: Record "ACA-Lecturer Halls Setup";
        unitAss: Record acaAssosiateUnits;
        lecturers: Record "ACA-Lecturers Units";
        CurrentSem: Record "ACA-Semester";
        unitsOff: Record "ACA-Units Offered";
        AllowAccessSetup: boolean;
        lecunits: Record "ACA-Lecturers Units";
        coursereg: Record "ACA-Course Registration";
        studUnits: Record "ACA-Student Units";
        unitsMastr: Record "ACA-Units Master Table";


    procedure updateSem()
    begin
        unitsOff.Reset();
        unitsOff.SetRange(Semester, 'MAY-AUG23');
        if unitsOff.Find('-') then begin
            repeat
                unitsOff.Semester := 'SEPT-DEC23';
                unitsOff.Modify();
            until unitsOff.Next() = 0;
        end
    end;

    procedure updatelecsem()
    begin
        lecturers.Reset();
        lecturers.SetRange(Semester, 'MAY-AUG23');
        lecturers.SetRange(ModeOfStudy, 'FULL TIME');
        IF lecturers.Find('-') then begin
            repeat
                lecturers.Semester := 'SEPT-DEC23';
                Rename(lecturers.Semester);
            until lecturers.Next() = 0;
        end;
    end;

    procedure updateYer()
    begin
        unitsOff.Reset();
        unitsOff.SetRange("Academic Year", '2022-2023');
        if unitsOff.Find('-') then begin
            repeat
                unitsOff."Academic Year" := '2023-2024';
                unitsOff.Modify();
            until unitsOff.Next() = 0;
        end
    end;

    procedure updateLec()
    begin
        unitsOff.Reset();
        unitsOff.SetRange(Semester, 'JAN-APR24');
        unitsOff.SetRange(Campus, 'GABA');
        IF unitsOff.Find('-') then begin
            repeat
                lecunits.Reset();
                lecunits.SetRange(Lecturer, unitsOff.Lecturer);
                lecunits.SetRange(Programme, unitsOff.Programs);
                lecunits.SetRange(ModeOfStudy, unitsOff.ModeofStudy);
                lecunits.SetRange(Unit, unitsOff."Unit Base Code");
                lecunits.SetRange(Stream, unitsOff.Stream);
                lecunits.SetRange(Day, unitsOff.Day);
                lecunits.SetRange(TimeSlot, unitsOff.TimeSlot);
                if lecunits.Find('-') then begin
                    //Record already exists
                end else begin
                    lecunits.Init();
                    lecunits.Semester := 'JAN-APR24';
                    lecunits.Programme := unitsOff.Programs;
                    lecunits.Lecturer := unitsOff.Lecturer;
                    lecunits.ModeOfStudy := unitsOff.ModeofStudy;
                    lecunits.Unit := unitsOff."Unit Base Code";
                    unitsMastr.Reset();
                    unitsMastr.SetRange("Unit Code", unitsOff."Unit Base Code");
                    if unitsMastr.Find('-') then begin
                        lecunits.Description := unitsMastr."Unit Name";
                    end;
                    lecunits."Campus Code" := unitsOff.Campus;
                    lecunits.Stream := unitsOff.Stream;
                    lecunits.Day := unitsOff.Day;
                    lecunits.TimeSlot := unitsOff.TimeSlot;
                    lecunits.Insert();
                end;

            until unitsOff.Next() = 0;
            Message('Successfull!');
        end;

    end;

    procedure updateStudunits()
    begin
        studUnits.Reset();
        studUnits.SetRange(Semester, 'SEPT-DEC23');
        if studUnits.Find('-') then begin
            repeat
                unitsOff.Reset();
                unitsOff.SetRange("Unit Base Code", studUnits.Unit);
                unitsOff.SetRange(ModeofStudy, studUnits.ModeOfStudy);
                unitsOff.SetRange(Day, studUnits.Day);
                unitsOff.SetRange(TimeSlot, studUnits.TimeSlot);
                unitsOff.SetRange(Stream, studUnits.Stream);
                if unitsOff.Find('-') then begin
                    studUnits.LectureHall := unitsOff."Lecture Hall";
                    studUnits.Modify();
                end;
            until studUnits.Next() = 0;
        end;
    end;

    procedure updateLecunits()
    begin
        lecturers.Reset();
        lecturers.SetRange(Semester, 'SEPT-DEC23');
        if lecturers.Find('-') then begin
            repeat
                unitsOff.Reset();
                unitsOff.SetRange("Unit Base Code", lecturers.Unit);
                unitsOff.SetRange(ModeofStudy, lecturers.ModeOfStudy);
                unitsOff.SetRange(Day, lecturers.Day);
                unitsOff.SetRange(TimeSlot, lecturers.TimeSlot);
                unitsOff.SetRange(Stream, lecturers.Stream);
                if unitsOff.Find('-') then begin
                    //lecunits.LectureHall := unitsOff."Lecture Hall";
                    lecunits.Modify();
                end;
            until studUnits.Next() = 0;
        end;
    end;

}