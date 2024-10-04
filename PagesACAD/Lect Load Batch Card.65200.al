page 65200 "Lect Load Batch Card"
{
    DataCaptionFields = "Semester Code", Status, "Created By";
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 65200;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("No of Lecturers"; Rec."No of Lecturers")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approval Name"; Rec."Approval Name")
                {
                    ApplicationArea = All;
                }
                field("Approval Title"; Rec."Approval Title")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
                {
                    ApplicationArea = All;
                }
                field("Semester Range Descption"; Rec."Semester Range Descption")
                {
                    ApplicationArea = All;
                }
            }
            part("Loads List"; "Lect Load Batch Lines")
            {
                SubPageLink = "Semester Code" = field("Semester Code");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(CourseLoad)
            {
                Caption = 'Course Loading Summary';
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    counted: Integer;
                    LectLoadBatchLines: Record 65201;
                begin
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        REPORT.RUN(69270, TRUE, FALSE, LectLoadBatchLines);
                    END;
                end;
            }
            action(CourseLoadSum)
            {
                Caption = 'Course Loading Det,';
                Image = CalculateBinReplenishment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                // RunObject = Report 69274;
            }
            action("Load Missing Lectures")
            {
                Caption = 'Load Missing Lecturers';
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('This will load Missing Lecturers, Continue?', TRUE) = FALSE THEN ERROR('Cancelled by user:' + USERID);
                    HrEmployees.RESET;
                    HrEmployees.SETFILTER(HrEmployees.Lecturer, '=%1', TRUE);
                    IF HrEmployees.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            LectLoadBatchLines.RESET;
                            LectLoadBatchLines.SETRANGE(LectLoadBatchLines."Semester Code", Rec."Semester Code");
                            LectLoadBatchLines.SETRANGE(LectLoadBatchLines."Lecturer Code", HrEmployees."No.");
                            IF NOT (LectLoadBatchLines.FIND('-')) THEN BEGIN
                                LectLoadBatchLines.INIT;
                                LectLoadBatchLines."Semester Code" := Rec."Semester Code";
                                LectLoadBatchLines."Lecturer Code" := HrEmployees."No.";
                                LectLoadBatchLines."Lecturer Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                                LectLoadBatchLines.VALIDATE("Lecturer Code");
                                LectLoadBatchLines.INSERT;
                            END ELSE BEGIN

                                LectLoadBatchLines."Lecturer Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                                //LectLoadBatchLines.VALIDATE("Lecturer Code");
                                LectLoadBatchLines.MODIFY;
                            END;
                        END;
                        UNTIL HrEmployees.NEXT = 0;
                    END;
                    CurrPage.UPDATE;
                end;
            }
            action("upDate")
            {
                Caption = 'Update';
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    units: Record "ACA-Units Offered";
                    lecUnits: Record "ACA-Lecturers Units";
                begin
                    lecUnits.Reset();
                    lecUnits.SetRange(Semester, 'SEPT-DEC23');
                    if lecUnits.Find('-') then begin
                        repeat
                            units.Reset();
                            units.SetRange("Unit Base Code", lecUnits.Unit);
                            units.SetRange(Day, lecUnits.Day);
                            units.SetRange(TimeSlot, lecUnits.TimeSlot);
                            units.SetRange(Stream, lecUnits.Stream);
                            if units.Find('-') then begin
                                lecUnits.ModeOfStudy := units.ModeofStudy;
                                lecUnits.Modify();
                            end;
                        until lecUnits.Next() = 0;
                        Message('Success!!');
                    end;
                end;

            }




        }
    }

    var
        LectLoadBatchLines: Record 65201;
        LectLoadBatches1: Record 65200;
        lineNo: Integer;
        DateFilter: Date;

        HrEmployees: Record 61188;
}

