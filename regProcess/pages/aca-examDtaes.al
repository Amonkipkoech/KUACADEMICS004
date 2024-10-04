page 86641 "ACA-Exam Units"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Exam TimeTable";
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
                field("Unit Base Code"; Rec."Unit Base Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Base Code field.';
                }
                field(Stream; Rec.Stream)
                {
                    ApplicationArea = All;
                }
                field(ModeofStudy; Rec.ModeofStudy)
                {
                    ApplicationArea = ALL;
                }
                field("Final Exam Date"; Rec."Final Exam Date")
                {
                    ApplicationArea = All;
                }
                field("final exam day"; Rec."final exam day")
                {
                    ApplicationArea = All;
                }
                field("final Exam Time"; Rec."final Exam Time")
                {
                    ApplicationArea = All;
                }

                field("Final Exam Room"; Rec."Final Exam Room")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 1"; Rec."Invigilator 1")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 2"; Rec."Invigilator 2")
                {
                    ApplicationArea = All;
                }
                field("Invigilator 3"; Rec."Invigilator 3")
                {
                    ApplicationArea = All;
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

                field("Registered Students"; Rec."Registered Students")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Student Timetable")
            {
                ApplicationArea = All;
                RunObject = report StudentTimetable;
                Image = Report;
            }
            action("Lecturer Timetable")
            {
                ApplicationArea = All;
                RunObject = report LecturerTimetable;
                Image = Report;
            }
            action(updateSEm1)
            {
                ApplicationArea = all;
                Image = Process;
                trigger OnAction()
                begin
                    updateSem();
                end;
            }
            action(updateSEmLec)
            {
                ApplicationArea = all;
                Image = Process;
                trigger OnAction()
                begin
                    updateYer();
                end;
            }
            action(ConfirmLec)
            {

                ApplicationArea = all;
                Image = Process;
                trigger OnAction()
                begin
                    updateLecunits();
                end;
            }
            action(updateStud)
            {

                ApplicationArea = all;
                Image = Process;
                trigger OnAction()
                begin
                    updateStudunits();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
        Nopermission: Label 'You have insufficient Rights to access Exam TT';
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
        unitsOff.SetRange(Semester, 'SEPT-DEC23');
        IF unitsOff.Find('-') then begin
            repeat
                lecturers.Reset();
                lecturers.SetRange(Semester, unitsOff.Semester);
                lecturers.SetRange(Unit, unitsOff."Unit Base Code");
                lecturers.SetRange("Campus Code", unitsOff.Campus);
                lecturers.SetRange(ModeOfStudy, unitsOff.ModeofStudy);
                lecturers.SetRange(Stream, unitsOff.Stream);
                if lecturers.Find('-') then begin
                    unitsOff.LectureAllocated := true;
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